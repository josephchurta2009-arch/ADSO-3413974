-- =====================================================================
-- schedule_sena — Base de datos definitiva
-- Ficha 3413974 · Tecnólogo en Análisis y Desarrollo de Software (SENA)
-- =====================================================================
-- Fuente: models.md (Modelo de Datos Lógico Global del instructor, A10)
-- Alcance: los 12 bounded contexts de models.md se consolidan en UNA sola
--   base de datos (no 9 microservicios) porque el entregable es un
--   ejercicio académico sobre MySQL/MariaDB (XAMPP), no una arquitectura
--   distribuida real. Se conserva la separación lógica con comentarios
--   de sección y con el mismo nombre de entidad/atributo que models.md.
-- Patrones adoptados de models.md:
--   1. UUID (CHAR(36)) como PK en toda tabla, en vez de INT AUTO_INCREMENT.
--   2. RBAC granular: module -> feature -> role -> role_feature -> user_role.
--   3. Estado parametrizable: status_category / status / status_transition,
--      en vez de ENUM fijo, para los agregados que lo requieren (aquí:
--      productive_stage). Los ENUM de estado que el propio models.md deja
--      como ENUM técnico cerrado (schedule.status, enrollment_ficha.status,
--      learner.enrollment_status, etc.) se respetan tal cual están definidos.
--   4. Auditoría estándar (created_at/by, updated_at/by, deleted_at/by,
--      is_active, row_version) en toda tabla transaccional.
--   5. audit_record: log de negocio inmutable (solo INSERT, forzado con
--      triggers), separado de created_at/updated_at de cada tabla.
-- Diferencia respecto al modelo de microservicios: como todo vive en una
-- sola base de datos, sí se declaran FOREIGN KEY físicas incluso entre
-- tablas que en models.md pertenecen a bounded contexts distintos
-- (ej. class_session.instructor_id -> instructor.id). En un despliegue
-- de microservicios real esas referencias serían lógicas (por evento de
-- dominio), tal como lo documenta la sección "Referencias cruzadas" de
-- models.md.
-- =====================================================================

DROP DATABASE IF EXISTS schedule_sena;
CREATE DATABASE schedule_sena CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE schedule_sena;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================================
-- ESTÁNDAR TRANSVERSAL — Estado parametrizable
-- =====================================================================

CREATE TABLE status_category (
  id                 CHAR(36)     NOT NULL PRIMARY KEY,
  code               VARCHAR(50)  NOT NULL UNIQUE,
  name               VARCHAR(120) NOT NULL,
  applies_to_entity  VARCHAR(80)  NULL,
  is_active          BOOLEAN      NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE status (
  id                  CHAR(36)     NOT NULL PRIMARY KEY,
  status_category_id  CHAR(36)     NOT NULL,
  code                VARCHAR(50)  NOT NULL,
  name                VARCHAR(120) NOT NULL,
  is_initial          BOOLEAN      NOT NULL DEFAULT FALSE,
  is_terminal         BOOLEAN      NOT NULL DEFAULT FALSE,
  display_order       SMALLINT     NOT NULL DEFAULT 0,
  color_hex           VARCHAR(7)   NULL,
  is_active           BOOLEAN      NOT NULL DEFAULT TRUE,
  UNIQUE KEY uq_status_cat_code (status_category_id, code),
  CONSTRAINT fk_status_category FOREIGN KEY (status_category_id) REFERENCES status_category(id)
) ENGINE=InnoDB;

CREATE TABLE status_transition (
  id                     CHAR(36)    NOT NULL PRIMARY KEY,
  from_status_id         CHAR(36)    NOT NULL,
  to_status_id           CHAR(36)    NOT NULL,
  required_feature_code  VARCHAR(60) NULL,
  is_active              BOOLEAN     NOT NULL DEFAULT TRUE,
  UNIQUE KEY uq_from_to (from_status_id, to_status_id),
  CONSTRAINT fk_st_from FOREIGN KEY (from_status_id) REFERENCES status(id),
  CONSTRAINT fk_st_to   FOREIGN KEY (to_status_id)   REFERENCES status(id)
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: iam-service
-- =====================================================================

CREATE TABLE user (
  id               CHAR(36)      NOT NULL PRIMARY KEY,
  email            VARCHAR(255)  NOT NULL UNIQUE,
  password_hash    TEXT          NOT NULL,
  full_name        VARCHAR(200)  NOT NULL,
  actor_type       ENUM('USER','INSTRUCTOR','LEARNER') NOT NULL,
  actor_id         CHAR(36)      NULL,
  is_active        BOOLEAN       NOT NULL DEFAULT TRUE,
  failed_attempts  SMALLINT      NOT NULL DEFAULT 0,
  locked_until     TIMESTAMP     NULL,
  created_by       CHAR(36)      NULL,
  created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by       CHAR(36)      NULL,
  updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by       CHAR(36)      NULL,
  deleted_at       TIMESTAMP     NULL,
  row_version      INT           NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE module (
  id             CHAR(36)     NOT NULL PRIMARY KEY,
  code           VARCHAR(30)  NOT NULL UNIQUE,
  name           VARCHAR(100) NOT NULL,
  display_order  SMALLINT     NOT NULL,
  icon_key       VARCHAR(50)  NULL,
  is_active      BOOLEAN      NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE feature (
  id            CHAR(36)     NOT NULL PRIMARY KEY,
  module_id     CHAR(36)     NOT NULL,
  code          VARCHAR(60)  NOT NULL UNIQUE,
  name          VARCHAR(120) NOT NULL,
  action_level  ENUM('READ','WRITE','DELETE','PUBLISH','APPROVE') NOT NULL,
  is_active     BOOLEAN      NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_feature_module FOREIGN KEY (module_id) REFERENCES module(id)
) ENGINE=InnoDB;

CREATE TABLE role (
  id              CHAR(36)     NOT NULL PRIMARY KEY,
  name            VARCHAR(50)  NOT NULL UNIQUE,
  display_name    VARCHAR(100) NOT NULL,
  is_system_role  BOOLEAN      NOT NULL DEFAULT FALSE
) ENGINE=InnoDB;

CREATE TABLE role_feature (
  id          CHAR(36) NOT NULL PRIMARY KEY,
  role_id     CHAR(36) NOT NULL,
  feature_id  CHAR(36) NOT NULL,
  scope_type  ENUM('GLOBAL','TRAINING_CENTER','AREA','OWN_FICHAS','OWN_SCHEDULE','OWN_PROFILE','OWN_FICHA_AS_LEARNER') NOT NULL,
  UNIQUE KEY uq_role_feature (role_id, feature_id),
  CONSTRAINT fk_rf_role    FOREIGN KEY (role_id)    REFERENCES role(id),
  CONSTRAINT fk_rf_feature FOREIGN KEY (feature_id) REFERENCES feature(id)
) ENGINE=InnoDB;

CREATE TABLE user_role (
  id                   CHAR(36)  NOT NULL PRIMARY KEY,
  user_id              CHAR(36)  NOT NULL,
  role_id              CHAR(36)  NOT NULL,
  training_center_id   CHAR(36)  NULL,
  assigned_by          CHAR(36)  NULL,
  expires_at           TIMESTAMP NULL,
  created_at           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active            BOOLEAN   NOT NULL DEFAULT TRUE,
  row_version          INT       NOT NULL DEFAULT 1,
  CONSTRAINT fk_ur_user        FOREIGN KEY (user_id)     REFERENCES user(id),
  CONSTRAINT fk_ur_role        FOREIGN KEY (role_id)     REFERENCES role(id),
  CONSTRAINT fk_ur_assigned_by FOREIGN KEY (assigned_by) REFERENCES user(id)
) ENGINE=InnoDB;

CREATE TABLE user_scope_override (
  id          CHAR(36)  NOT NULL PRIMARY KEY,
  user_id     CHAR(36)  NOT NULL,
  feature_id  CHAR(36)  NOT NULL,
  scope_type  ENUM('GLOBAL','TRAINING_CENTER','AREA','OWN_FICHAS','OWN_SCHEDULE','OWN_PROFILE','OWN_FICHA_AS_LEARNER') NOT NULL,
  is_allowed  BOOLEAN   NOT NULL,
  reason      TEXT      NOT NULL,
  expires_at  TIMESTAMP NULL,
  CONSTRAINT fk_uso_user    FOREIGN KEY (user_id)    REFERENCES user(id),
  CONSTRAINT fk_uso_feature FOREIGN KEY (feature_id) REFERENCES feature(id)
) ENGINE=InnoDB;

CREATE TABLE refresh_token (
  id          CHAR(36)  NOT NULL PRIMARY KEY,
  user_id     CHAR(36)  NOT NULL,
  token_hash  TEXT      NOT NULL,
  ip_address  VARCHAR(45) NULL,
  expires_at  TIMESTAMP NOT NULL,
  is_revoked  BOOLEAN   NOT NULL DEFAULT FALSE,
  created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_rt_user FOREIGN KEY (user_id) REFERENCES user(id)
) ENGINE=InnoDB;

CREATE TABLE audit_login (
  id               CHAR(36)     NOT NULL PRIMARY KEY,
  user_id          CHAR(36)     NULL,
  email_attempted  VARCHAR(255) NOT NULL,
  outcome          ENUM('SUCCESS','INVALID_PASSWORD','USER_NOT_FOUND','ACCOUNT_LOCKED','TOKEN_EXPIRED') NOT NULL,
  ip_address       VARCHAR(45)  NULL,
  attempted_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: reference-data-service
-- =====================================================================

CREATE TABLE macroregion (
  id    CHAR(36)     NOT NULL PRIMARY KEY,
  code  VARCHAR(10)  NOT NULL UNIQUE,
  name  VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE microregion (
  id               CHAR(36)     NOT NULL PRIMARY KEY,
  macroregion_id   CHAR(36)     NOT NULL,
  code             VARCHAR(10)  NOT NULL UNIQUE,
  name             VARCHAR(100) NOT NULL,
  CONSTRAINT fk_micro_macro FOREIGN KEY (macroregion_id) REFERENCES macroregion(id)
) ENGINE=InnoDB;

CREATE TABLE department (
  id              CHAR(36)    NOT NULL PRIMARY KEY,
  microregion_id  CHAR(36)    NOT NULL,
  name            VARCHAR(100) NOT NULL,
  dane_code       VARCHAR(5)  NOT NULL UNIQUE,
  CONSTRAINT fk_dept_micro FOREIGN KEY (microregion_id) REFERENCES microregion(id)
) ENGINE=InnoDB;

CREATE TABLE municipality (
  id             CHAR(36)     NOT NULL PRIMARY KEY,
  department_id  CHAR(36)     NOT NULL,
  name           VARCHAR(100) NOT NULL,
  dane_code      VARCHAR(8)   NOT NULL UNIQUE,
  CONSTRAINT fk_muni_dept FOREIGN KEY (department_id) REFERENCES department(id)
) ENGINE=InnoDB;

CREATE TABLE training_center (
  id               CHAR(36)     NOT NULL PRIMARY KEY,
  municipality_id  CHAR(36)     NOT NULL,
  center_code      VARCHAR(10)  NOT NULL UNIQUE,
  name             VARCHAR(200) NOT NULL,
  address          TEXT         NULL,
  phone            VARCHAR(20)  NULL,
  is_active        BOOLEAN      NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_tc_muni FOREIGN KEY (municipality_id) REFERENCES municipality(id)
) ENGINE=InnoDB;

CREATE TABLE institutional_unit (
  id                   CHAR(36)     NOT NULL PRIMARY KEY,
  training_center_id   CHAR(36)     NOT NULL,
  name                 VARCHAR(200) NOT NULL,
  unit_type            VARCHAR(50)  NULL,
  CONSTRAINT fk_iu_tc FOREIGN KEY (training_center_id) REFERENCES training_center(id)
) ENGINE=InnoDB;

CREATE TABLE catalog (
  id           CHAR(36)     NOT NULL PRIMARY KEY,
  code         VARCHAR(50)  NOT NULL UNIQUE,
  name         VARCHAR(100) NOT NULL,
  description  TEXT         NULL,
  is_active    BOOLEAN      NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE catalog_detail (
  id             CHAR(36)     NOT NULL PRIMARY KEY,
  catalog_id     CHAR(36)     NOT NULL,
  code           VARCHAR(50)  NOT NULL,
  label          VARCHAR(255) NOT NULL,
  display_order  INT          NOT NULL DEFAULT 0,
  is_active      BOOLEAN      NOT NULL DEFAULT TRUE,
  UNIQUE KEY uq_catalog_code (catalog_id, code),
  CONSTRAINT fk_cd_catalog FOREIGN KEY (catalog_id) REFERENCES catalog(id)
) ENGINE=InnoDB;

CREATE TABLE parameter (
  id           CHAR(36)     NOT NULL PRIMARY KEY,
  `key`        VARCHAR(100) NOT NULL UNIQUE,
  value        TEXT         NOT NULL,
  value_type   ENUM('integer','string','boolean','json') NOT NULL,
  description  TEXT         NULL
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: academic-management-service
-- =====================================================================

CREATE TABLE tech_line (
  id    CHAR(36)     NOT NULL PRIMARY KEY,
  name  VARCHAR(100) NOT NULL UNIQUE,
  code  VARCHAR(10)  NULL
) ENGINE=InnoDB;

CREATE TABLE tech_network (
  id            CHAR(36)     NOT NULL PRIMARY KEY,
  tech_line_id  CHAR(36)     NOT NULL,
  name          VARCHAR(100) NOT NULL,
  CONSTRAINT fk_tn_tl FOREIGN KEY (tech_line_id) REFERENCES tech_line(id)
) ENGINE=InnoDB;

CREATE TABLE knowledge_network (
  id                CHAR(36)     NOT NULL PRIMARY KEY,
  tech_network_id   CHAR(36)     NOT NULL,
  name              VARCHAR(100) NOT NULL,
  CONSTRAINT fk_kn_tn FOREIGN KEY (tech_network_id) REFERENCES tech_network(id)
) ENGINE=InnoDB;

CREATE TABLE training_program (
  id                     CHAR(36)     NOT NULL PRIMARY KEY,
  knowledge_network_id   CHAR(36)     NOT NULL,
  program_code           VARCHAR(20)  NOT NULL UNIQUE,
  name                   VARCHAR(200) NOT NULL,
  training_level         ENUM('AUXILIARY','OPERATOR','TECHNICIAN','TECHNOLOGIST') NOT NULL,
  total_hours            INT          NOT NULL,
  version                INT          NOT NULL DEFAULT 1,
  is_active              BOOLEAN      NOT NULL DEFAULT TRUE,
  created_by             CHAR(36)     NULL,
  created_at             TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by             CHAR(36)     NULL,
  updated_at             TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by             CHAR(36)     NULL,
  deleted_at             TIMESTAMP    NULL,
  row_version            INT          NOT NULL DEFAULT 1,
  CONSTRAINT fk_tp_kn FOREIGN KEY (knowledge_network_id) REFERENCES knowledge_network(id)
) ENGINE=InnoDB;

CREATE TABLE competency (
  id           CHAR(36)     NOT NULL PRIMARY KEY,
  program_id   CHAR(36)     NOT NULL,
  sena_code    VARCHAR(20)  NOT NULL UNIQUE,
  name         VARCHAR(300) NOT NULL,
  total_hours  INT          NOT NULL,
  is_active    BOOLEAN      NOT NULL DEFAULT TRUE,
  row_version  INT          NOT NULL DEFAULT 1,
  CONSTRAINT fk_comp_program FOREIGN KEY (program_id) REFERENCES training_program(id)
) ENGINE=InnoDB;

CREATE TABLE learning_outcome (
  id             CHAR(36)    NOT NULL PRIMARY KEY,
  competency_id  CHAR(36)    NOT NULL,
  code           VARCHAR(20) NOT NULL,
  description    TEXT        NOT NULL,
  CONSTRAINT fk_lo_comp FOREIGN KEY (competency_id) REFERENCES competency(id)
) ENGINE=InnoDB;

CREATE TABLE enrollment_ficha (
  id                   CHAR(36)     NOT NULL PRIMARY KEY,
  program_id           CHAR(36)     NOT NULL,
  training_center_id   CHAR(36)     NOT NULL,
  ficha_number         VARCHAR(20)  NOT NULL UNIQUE,
  start_date           DATE         NOT NULL,
  expected_end_date    DATE         NOT NULL,
  learner_count        INT          NOT NULL DEFAULT 0,
  status               ENUM('INDUCTION','EXECUTION','PRODUCTIVE_STAGE','COMPLETED','CANCELLED') NOT NULL DEFAULT 'INDUCTION',
  created_by           CHAR(36)     NULL,
  created_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by           CHAR(36)     NULL,
  updated_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by           CHAR(36)     NULL,
  deleted_at           TIMESTAMP    NULL,
  is_active            BOOLEAN      NOT NULL DEFAULT TRUE,
  row_version          INT          NOT NULL DEFAULT 1,
  CONSTRAINT fk_ef_program FOREIGN KEY (program_id) REFERENCES training_program(id),
  CONSTRAINT fk_ef_tc      FOREIGN KEY (training_center_id) REFERENCES training_center(id),
  CONSTRAINT chk_ef_dates CHECK (expected_end_date > start_date)
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: training-environment-service
-- =====================================================================

CREATE TABLE environment_type (
  id           CHAR(36)     NOT NULL PRIMARY KEY,
  code         VARCHAR(20)  NOT NULL UNIQUE,
  name         VARCHAR(100) NOT NULL,
  description  TEXT         NULL
) ENGINE=InnoDB;

CREATE TABLE environment (
  id                    CHAR(36)     NOT NULL PRIMARY KEY,
  environment_type_id   CHAR(36)     NOT NULL,
  training_center_id    CHAR(36)     NOT NULL,
  name                  VARCHAR(100) NOT NULL,
  capacity              INT          NOT NULL,
  location              VARCHAR(200) NULL,
  created_by            CHAR(36)     NULL,
  created_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by            CHAR(36)     NULL,
  updated_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by            CHAR(36)     NULL,
  deleted_at            TIMESTAMP    NULL,
  is_active             BOOLEAN      NOT NULL DEFAULT TRUE,
  row_version           INT          NOT NULL DEFAULT 1,
  CONSTRAINT fk_env_type FOREIGN KEY (environment_type_id) REFERENCES environment_type(id),
  CONSTRAINT fk_env_tc   FOREIGN KEY (training_center_id)  REFERENCES training_center(id)
) ENGINE=InnoDB;

CREATE TABLE availability_rule (
  id                CHAR(36) NOT NULL PRIMARY KEY,
  environment_id    CHAR(36) NOT NULL,
  day_of_week       SMALLINT NOT NULL,
  start_time        TIME     NOT NULL,
  end_time          TIME     NOT NULL,
  effective_from    DATE     NOT NULL,
  effective_until   DATE     NULL,
  CONSTRAINT fk_ar_env FOREIGN KEY (environment_id) REFERENCES environment(id),
  CONSTRAINT chk_ar_dow  CHECK (day_of_week BETWEEN 1 AND 7),
  CONSTRAINT chk_ar_time CHECK (start_time < end_time)
) ENGINE=InnoDB;

CREATE TABLE maintenance (
  id               CHAR(36)  NOT NULL PRIMARY KEY,
  environment_id   CHAR(36)  NOT NULL,
  start_datetime   TIMESTAMP NOT NULL,
  end_datetime     TIMESTAMP NOT NULL,
  reason           TEXT      NULL,
  created_by       CHAR(36)  NULL,
  created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_maint_env FOREIGN KEY (environment_id) REFERENCES environment(id),
  CONSTRAINT chk_maint_range CHECK (start_datetime < end_datetime)
) ENGINE=InnoDB;

CREATE TABLE inventory_item (
  id              CHAR(36)     NOT NULL PRIMARY KEY,
  environment_id  CHAR(36)     NOT NULL,
  name            VARCHAR(200) NOT NULL,
  quantity        INT          NOT NULL DEFAULT 1,
  `condition`     ENUM('GOOD','FAIR','POOR','OUT_OF_SERVICE') NOT NULL DEFAULT 'GOOD',
  CONSTRAINT fk_inv_env FOREIGN KEY (environment_id) REFERENCES environment(id)
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: actors-service
-- =====================================================================

CREATE TABLE instructor (
  id                    CHAR(36)     NOT NULL PRIMARY KEY,
  user_id               CHAR(36)     NULL,
  document_type         VARCHAR(10)  NOT NULL,
  document_number       VARCHAR(20)  NOT NULL UNIQUE,
  full_name             VARCHAR(200) NOT NULL,
  email                 VARCHAR(255) NOT NULL,
  phone                 VARCHAR(20)  NULL,
  max_hours_per_week    DECIMAL(4,1) NOT NULL DEFAULT 40.0,
  created_by            CHAR(36)     NULL,
  created_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by            CHAR(36)     NULL,
  updated_at            TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by            CHAR(36)     NULL,
  deleted_at            TIMESTAMP    NULL,
  is_active             BOOLEAN      NOT NULL DEFAULT TRUE,
  row_version           INT          NOT NULL DEFAULT 1,
  CONSTRAINT fk_instr_user FOREIGN KEY (user_id) REFERENCES user(id)
) ENGINE=InnoDB;

CREATE TABLE instructor_contract (
  id                   CHAR(36) NOT NULL PRIMARY KEY,
  instructor_id        CHAR(36) NOT NULL,
  contract_type        ENUM('STAFF','CONTRACTOR') NOT NULL,
  start_date           DATE     NOT NULL,
  end_date             DATE     NULL,
  training_center_id   CHAR(36) NOT NULL,
  is_active            BOOLEAN  NOT NULL DEFAULT TRUE,
  row_version          INT      NOT NULL DEFAULT 1,
  CONSTRAINT fk_ic_instr FOREIGN KEY (instructor_id) REFERENCES instructor(id),
  CONSTRAINT fk_ic_tc    FOREIGN KEY (training_center_id) REFERENCES training_center(id)
) ENGINE=InnoDB;

CREATE TABLE competency_assignment (
  id              CHAR(36) NOT NULL PRIMARY KEY,
  instructor_id   CHAR(36) NOT NULL,
  competency_id   CHAR(36) NOT NULL,
  certified_at    DATE     NOT NULL,
  is_active       BOOLEAN  NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_ca_instr FOREIGN KEY (instructor_id) REFERENCES instructor(id),
  CONSTRAINT fk_ca_comp  FOREIGN KEY (competency_id) REFERENCES competency(id),
  UNIQUE KEY uq_instructor_competency (instructor_id, competency_id)
) ENGINE=InnoDB;

CREATE TABLE learner (
  id                  CHAR(36)     NOT NULL PRIMARY KEY,
  user_id             CHAR(36)     NULL,
  document_type       VARCHAR(10)  NOT NULL,
  document_number     VARCHAR(20)  NOT NULL UNIQUE,
  full_name           VARCHAR(200) NOT NULL,
  email               VARCHAR(255) NOT NULL,
  ficha_id            CHAR(36)     NOT NULL,
  enrollment_status   ENUM('ACTIVE','DROPOUT','TRANSFERRED','COMPLETED') NOT NULL DEFAULT 'ACTIVE',
  current_stage       ENUM('LECTURE','PRODUCTIVE') NOT NULL DEFAULT 'LECTURE',
  created_by          CHAR(36)     NULL,
  created_at          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by          CHAR(36)     NULL,
  updated_at           TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by          CHAR(36)     NULL,
  deleted_at          TIMESTAMP    NULL,
  is_active           BOOLEAN      NOT NULL DEFAULT TRUE,
  row_version         INT          NOT NULL DEFAULT 1,
  CONSTRAINT fk_learner_user  FOREIGN KEY (user_id)  REFERENCES user(id),
  CONSTRAINT fk_learner_ficha FOREIGN KEY (ficha_id) REFERENCES enrollment_ficha(id)
) ENGINE=InnoDB;

CREATE TABLE company (
  id               CHAR(36)     NOT NULL PRIMARY KEY,
  nit              VARCHAR(20)  NOT NULL UNIQUE,
  business_name    VARCHAR(200) NOT NULL,
  contact_name     VARCHAR(200) NULL,
  contact_email    VARCHAR(255) NULL,
  contact_phone    VARCHAR(20)  NULL,
  is_active        BOOLEAN      NOT NULL DEFAULT TRUE,
  row_version      INT          NOT NULL DEFAULT 1
) ENGINE=InnoDB;

-- status_id de productive_stage sigue el patron parametrizable (patron 3)
CREATE TABLE productive_stage (
  id                          CHAR(36)  NOT NULL PRIMARY KEY,
  learner_id                  CHAR(36)  NOT NULL,
  company_id                  CHAR(36)  NOT NULL,
  start_date                  DATE      NOT NULL,
  end_date                    DATE      NULL,
  supervisor_instructor_id    CHAR(36)  NOT NULL,
  status_id                   CHAR(36)  NOT NULL,
  created_by                  CHAR(36)  NULL,
  created_at                  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by                  CHAR(36)  NULL,
  updated_at                  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  row_version                 INT       NOT NULL DEFAULT 1,
  CONSTRAINT fk_ps_learner FOREIGN KEY (learner_id) REFERENCES learner(id),
  CONSTRAINT fk_ps_company FOREIGN KEY (company_id) REFERENCES company(id),
  CONSTRAINT fk_ps_instr   FOREIGN KEY (supervisor_instructor_id) REFERENCES instructor(id),
  CONSTRAINT fk_ps_status  FOREIGN KEY (status_id) REFERENCES status(id)
) ENGINE=InnoDB;

CREATE TABLE company_visit (
  id                    CHAR(36) NOT NULL PRIMARY KEY,
  productive_stage_id   CHAR(36) NOT NULL,
  instructor_id         CHAR(36) NOT NULL,
  visit_date            DATE     NOT NULL,
  observations          TEXT     NULL,
  next_visit_date       DATE     NULL,
  CONSTRAINT fk_cv_ps    FOREIGN KEY (productive_stage_id) REFERENCES productive_stage(id),
  CONSTRAINT fk_cv_instr FOREIGN KEY (instructor_id) REFERENCES instructor(id)
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: scheduling-service
-- =====================================================================

CREATE TABLE schedule (
  id             CHAR(36)     NOT NULL PRIMARY KEY,
  ficha_id       CHAR(36)     NOT NULL,
  name           VARCHAR(200) NOT NULL,
  status         ENUM('DRAFT','UNDER_REVIEW','PUBLISHED','ARCHIVED') NOT NULL DEFAULT 'DRAFT',
  published_at   TIMESTAMP    NULL,
  published_by   CHAR(36)     NULL,
  created_by     CHAR(36)     NOT NULL,
  created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by     CHAR(36)     NULL,
  updated_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_by     CHAR(36)     NULL,
  deleted_at     TIMESTAMP    NULL,
  is_active      BOOLEAN      NOT NULL DEFAULT TRUE,
  row_version    INT          NOT NULL DEFAULT 1,
  CONSTRAINT fk_sched_ficha FOREIGN KEY (ficha_id) REFERENCES enrollment_ficha(id)
) ENGINE=InnoDB;

CREATE TABLE time_slot (
  id            CHAR(36)    NOT NULL PRIMARY KEY,
  day_of_week   SMALLINT    NOT NULL,
  start_time    TIME        NOT NULL,
  end_time      TIME        NOT NULL,
  name          VARCHAR(50) NULL,
  CONSTRAINT chk_ts_dow  CHECK (day_of_week BETWEEN 1 AND 7),
  CONSTRAINT chk_ts_time CHECK (start_time < end_time)
) ENGINE=InnoDB;

CREATE TABLE class_session (
  id              CHAR(36) NOT NULL PRIMARY KEY,
  schedule_id     CHAR(36) NOT NULL,
  competency_id   CHAR(36) NOT NULL,
  instructor_id   CHAR(36) NOT NULL,
  environment_id  CHAR(36) NOT NULL,
  time_slot_id    CHAR(36) NOT NULL,
  session_date    DATE     NOT NULL,
  notes           TEXT     NULL,
  CONSTRAINT fk_cs_sched FOREIGN KEY (schedule_id)    REFERENCES schedule(id),
  CONSTRAINT fk_cs_comp  FOREIGN KEY (competency_id)  REFERENCES competency(id),
  CONSTRAINT fk_cs_instr FOREIGN KEY (instructor_id)  REFERENCES instructor(id),
  CONSTRAINT fk_cs_env   FOREIGN KEY (environment_id) REFERENCES environment(id),
  CONSTRAINT fk_cs_ts    FOREIGN KEY (time_slot_id)   REFERENCES time_slot(id),
  -- Enforcement del invariante de exclusion mutua (ADR-005 de models.md):
  -- MySQL/MariaDB no soportan EXCLUDE constraints (exclusivo de PostgreSQL).
  -- Se emula con UNIQUE sobre (recurso, franja, fecha), que bloquea la doble
  -- reserva del mismo instructor o del mismo ambiente en la misma franja+fecha.
  CONSTRAINT uq_instructor_slot  UNIQUE (instructor_id, time_slot_id, session_date),
  CONSTRAINT uq_environment_slot UNIQUE (environment_id, time_slot_id, session_date)
) ENGINE=InnoDB;

CREATE TABLE scheduling_conflict (
  id              CHAR(36)  NOT NULL PRIMARY KEY,
  schedule_id     CHAR(36)  NOT NULL,
  conflict_type   ENUM('INSTRUCTOR_DOUBLE_BOOKED','ENVIRONMENT_DOUBLE_BOOKED','SESSIONS_OVERLAP') NOT NULL,
  description     TEXT      NULL,
  session_a_id    CHAR(36)  NOT NULL,
  session_b_id    CHAR(36)  NULL,
  detected_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_sc_sched  FOREIGN KEY (schedule_id)  REFERENCES schedule(id),
  CONSTRAINT fk_sc_sess_a FOREIGN KEY (session_a_id) REFERENCES class_session(id),
  CONSTRAINT fk_sc_sess_b FOREIGN KEY (session_b_id) REFERENCES class_session(id)
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: document-service
-- =====================================================================

CREATE TABLE document_template (
  id              CHAR(36)     NOT NULL PRIMARY KEY,
  code            VARCHAR(50)  NOT NULL UNIQUE,
  name            VARCHAR(200) NOT NULL,
  template_body   MEDIUMTEXT   NOT NULL,
  version         INT          NOT NULL DEFAULT 1,
  is_active       BOOLEAN      NOT NULL DEFAULT TRUE
) ENGINE=InnoDB;

-- Invariante de models.md: los binarios NUNCA se guardan en la BD, solo storage_key.
CREATE TABLE document (
  id                CHAR(36)     NOT NULL PRIMARY KEY,
  template_id       CHAR(36)     NULL,
  title             VARCHAR(300) NOT NULL,
  owner_service     VARCHAR(50)  NOT NULL,
  owner_entity_id   CHAR(36)     NOT NULL,
  storage_key       VARCHAR(500) NOT NULL,
  mime_type         VARCHAR(100) NULL,
  size_bytes        BIGINT       NULL,
  created_by        CHAR(36)     NULL,
  created_at        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active         BOOLEAN      NOT NULL DEFAULT TRUE,
  row_version       INT          NOT NULL DEFAULT 1,
  CONSTRAINT fk_doc_template FOREIGN KEY (template_id) REFERENCES document_template(id)
) ENGINE=InnoDB;

CREATE TABLE document_version (
  id               CHAR(36)     NOT NULL PRIMARY KEY,
  document_id      CHAR(36)     NOT NULL,
  version_number   INT          NOT NULL,
  storage_key      VARCHAR(500) NOT NULL,
  created_by       CHAR(36)     NULL,
  created_at       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_doc_version (document_id, version_number),
  CONSTRAINT fk_dv_doc FOREIGN KEY (document_id) REFERENCES document(id)
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: monitoring-service
-- =====================================================================

CREATE TABLE ficha_tracking (
  id                       CHAR(36)  NOT NULL PRIMARY KEY,
  ficha_id                 CHAR(36)  NOT NULL,
  assigned_instructor_id   CHAR(36)  NOT NULL,
  status                   ENUM('ON_TRACK','AT_RISK','CRITICAL') NOT NULL DEFAULT 'ON_TRACK',
  last_updated_at          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  row_version              INT       NOT NULL DEFAULT 1,
  CONSTRAINT fk_ft_ficha FOREIGN KEY (ficha_id)               REFERENCES enrollment_ficha(id),
  CONSTRAINT fk_ft_instr FOREIGN KEY (assigned_instructor_id) REFERENCES instructor(id)
) ENGINE=InnoDB;

CREATE TABLE tracking_session (
  id                     CHAR(36)      NOT NULL PRIMARY KEY,
  ficha_tracking_id      CHAR(36)      NOT NULL,
  session_date           DATE          NOT NULL,
  instructor_id          CHAR(36)      NOT NULL,
  attendance_percentage  DECIMAL(5,2)  NULL,
  progress_percentage    DECIMAL(5,2)  NULL,
  notes                  TEXT          NULL,
  CONSTRAINT fk_tsess_ft    FOREIGN KEY (ficha_tracking_id) REFERENCES ficha_tracking(id),
  CONSTRAINT fk_tsess_instr FOREIGN KEY (instructor_id)     REFERENCES instructor(id)
) ENGINE=InnoDB;

CREATE TABLE kpi_tracking (
  id                   CHAR(36)       NOT NULL PRIMARY KEY,
  ficha_tracking_id    CHAR(36)       NOT NULL,
  kpi_code             VARCHAR(50)    NOT NULL,
  value                DECIMAL(10,4)  NOT NULL,
  measured_at          TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_kpi_ft FOREIGN KEY (ficha_tracking_id) REFERENCES ficha_tracking(id)
) ENGINE=InnoDB;

CREATE TABLE generated_alert (
  id                   CHAR(36)  NOT NULL PRIMARY KEY,
  ficha_tracking_id    CHAR(36)  NOT NULL,
  alert_type           VARCHAR(50) NOT NULL,
  severity             ENUM('LOW','MEDIUM','HIGH','CRITICAL') NOT NULL,
  message              TEXT      NOT NULL,
  is_resolved          BOOLEAN   NOT NULL DEFAULT FALSE,
  generated_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  resolved_at          TIMESTAMP NULL,
  CONSTRAINT fk_ga_ft FOREIGN KEY (ficha_tracking_id) REFERENCES ficha_tracking(id)
) ENGINE=InnoDB;

CREATE TABLE improvement_plan (
  id                    CHAR(36)  NOT NULL PRIMARY KEY,
  ficha_tracking_id     CHAR(36)  NOT NULL,
  generated_alert_id    CHAR(36)  NULL,
  description           TEXT      NOT NULL,
  due_date              DATE      NOT NULL,
  status                ENUM('PENDING','IN_PROGRESS','COMPLETED','CANCELLED') NOT NULL DEFAULT 'PENDING',
  created_by            CHAR(36)  NULL,
  CONSTRAINT fk_ip_ft    FOREIGN KEY (ficha_tracking_id)  REFERENCES ficha_tracking(id),
  CONSTRAINT fk_ip_alert FOREIGN KEY (generated_alert_id) REFERENCES generated_alert(id)
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: notification-service
-- =====================================================================

CREATE TABLE sent_notification (
  id                CHAR(36)     NOT NULL PRIMARY KEY,
  recipient_id      CHAR(36)     NOT NULL,
  recipient_email   VARCHAR(255) NOT NULL,
  channel           ENUM('EMAIL','IN_APP') NOT NULL,
  subject           VARCHAR(300) NOT NULL,
  sent_at           TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  status            ENUM('SENT','FAILED','PENDING') NOT NULL DEFAULT 'PENDING'
) ENGINE=InnoDB;

-- =====================================================================
-- BOUNDED CONTEXT: audit-service
-- Invariante absoluta: SOLO INSERT. Forzado con triggers (no hay
-- equivalente nativo de tabla "append-only" en MySQL/MariaDB).
-- =====================================================================

CREATE TABLE audit_record (
  id               CHAR(36)  NOT NULL PRIMARY KEY,
  event_id         CHAR(36)  NOT NULL UNIQUE,
  event_type       VARCHAR(100) NOT NULL,
  source_service   VARCHAR(50)  NOT NULL,
  actor_id         CHAR(36)  NULL,
  entity_type      VARCHAR(50)  NULL,
  entity_id        CHAR(36)  NULL,
  payload          JSON      NOT NULL,
  recorded_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

DELIMITER $$
CREATE TRIGGER trg_audit_record_no_update BEFORE UPDATE ON audit_record
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'audit_record es append-only: UPDATE no permitido';
END$$

CREATE TRIGGER trg_audit_record_no_delete BEFORE DELETE ON audit_record
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'audit_record es append-only: DELETE no permitido';
END$$
DELIMITER ;

-- =====================================================================
-- SEED — Estado parametrizable (patron 3): SCHEDULE, FICHA, PRODUCTIVE_STAGE
-- =====================================================================

INSERT INTO status_category (id, code, name, applies_to_entity, is_active) VALUES
('a0000000-0000-0000-0000-000000000001','PRODUCTIVE_STAGE','Etapa productiva','ProductiveStage',TRUE),
('a0000000-0000-0000-0000-000000000002','KPI','Estado de KPI','KpiTracking',TRUE),
('a0000000-0000-0000-0000-000000000003','RISK','Nivel de riesgo de ficha','FichaTracking',TRUE);

INSERT INTO status (id, status_category_id, code, name, is_initial, is_terminal, display_order, color_hex, is_active) VALUES
('b0000000-0000-0000-0000-000000000001','a0000000-0000-0000-0000-000000000001','PENDING','Pendiente de inicio',TRUE,FALSE,1,'#F59E0B',TRUE),
('b0000000-0000-0000-0000-000000000002','a0000000-0000-0000-0000-000000000001','IN_PROGRESS','En curso',FALSE,FALSE,2,'#3B82F6',TRUE),
('b0000000-0000-0000-0000-000000000003','a0000000-0000-0000-0000-000000000001','SUSPENDED','Suspendida',FALSE,FALSE,3,'#EF4444',TRUE),
('b0000000-0000-0000-0000-000000000004','a0000000-0000-0000-0000-000000000001','COMPLETED','Completada',FALSE,TRUE,4,'#10B981',TRUE);

INSERT INTO status_transition (id, from_status_id, to_status_id, required_feature_code, is_active) VALUES
('c0000000-0000-0000-0000-000000000001','b0000000-0000-0000-0000-000000000001','b0000000-0000-0000-0000-000000000002','PROD_STAGE_START',TRUE),
('c0000000-0000-0000-0000-000000000002','b0000000-0000-0000-0000-000000000002','b0000000-0000-0000-0000-000000000003','PROD_STAGE_SUSPEND',TRUE),
('c0000000-0000-0000-0000-000000000003','b0000000-0000-0000-0000-000000000002','b0000000-0000-0000-0000-000000000004','PROD_STAGE_COMPLETE',TRUE),
('c0000000-0000-0000-0000-000000000004','b0000000-0000-0000-0000-000000000003','b0000000-0000-0000-0000-000000000002','PROD_STAGE_RESUME',TRUE);

-- =====================================================================
-- SEED — RBAC (patron 2): 7 roles de models.md + modulos/features base
-- =====================================================================

INSERT INTO role (id, name, display_name, is_system_role) VALUES
('d0000000-0000-0000-0000-000000000001','SYSTEM_ADMIN','Administrador del sistema',TRUE),
('d0000000-0000-0000-0000-000000000002','CENTER_DIRECTOR','Director de centro',TRUE),
('d0000000-0000-0000-0000-000000000003','COORDINATOR','Coordinador académico',TRUE),
('d0000000-0000-0000-0000-000000000004','AREA_LEADER','Líder de área',TRUE),
('d0000000-0000-0000-0000-000000000005','INSTRUCTOR','Instructor',TRUE),
('d0000000-0000-0000-0000-000000000006','LEARNER','Aprendiz',TRUE),
('d0000000-0000-0000-0000-000000000007','ADMIN_STAFF','Personal de back-office',TRUE);

INSERT INTO module (id, code, name, display_order, icon_key, is_active) VALUES
('e0000000-0000-0000-0000-000000000001','MOD_SCHEDULING','Gestión de horarios',1,'calendar',TRUE),
('e0000000-0000-0000-0000-000000000002','MOD_MONITORING','Seguimiento y monitoreo',2,'activity',TRUE),
('e0000000-0000-0000-0000-000000000003','MOD_DOCUMENT','Gestión documental',3,'file-text',TRUE),
('e0000000-0000-0000-0000-000000000004','MOD_IAM','Usuarios y roles',4,'users',TRUE);

INSERT INTO feature (id, module_id, code, name, action_level, is_active) VALUES
('f0000000-0000-0000-0000-000000000001','e0000000-0000-0000-0000-000000000001','SCH_CREATE','Crear horario','WRITE',TRUE),
('f0000000-0000-0000-0000-000000000002','e0000000-0000-0000-0000-000000000001','SCH_PUBLISH','Publicar horario','PUBLISH',TRUE),
('f0000000-0000-0000-0000-000000000003','e0000000-0000-0000-0000-000000000001','SCH_VIEW_OWN','Consultar horario propio','READ',TRUE),
('f0000000-0000-0000-0000-000000000004','e0000000-0000-0000-0000-000000000002','MON_ALERT_RESOLVE','Resolver alerta de seguimiento','APPROVE',TRUE),
('f0000000-0000-0000-0000-000000000005','e0000000-0000-0000-0000-000000000002','MON_TRACKING_REGISTER','Registrar seguimiento de ficha','WRITE',TRUE),
('f0000000-0000-0000-0000-000000000006','e0000000-0000-0000-0000-000000000003','DOC_GENERATE','Generar documento desde plantilla','WRITE',TRUE),
('f0000000-0000-0000-0000-000000000007','e0000000-0000-0000-0000-000000000004','IAM_ROLE_ASSIGN','Asignar o revocar rol','APPROVE',TRUE);

INSERT INTO role_feature (id, role_id, feature_id, scope_type) VALUES
('10000000-0000-0000-0000-000000000001','d0000000-0000-0000-0000-000000000003','f0000000-0000-0000-0000-000000000001','TRAINING_CENTER'),
('10000000-0000-0000-0000-000000000002','d0000000-0000-0000-0000-000000000003','f0000000-0000-0000-0000-000000000002','TRAINING_CENTER'),
('10000000-0000-0000-0000-000000000003','d0000000-0000-0000-0000-000000000005','f0000000-0000-0000-0000-000000000003','OWN_SCHEDULE'),
('10000000-0000-0000-0000-000000000004','d0000000-0000-0000-0000-000000000005','f0000000-0000-0000-0000-000000000005','OWN_FICHAS'),
('10000000-0000-0000-0000-000000000005','d0000000-0000-0000-0000-000000000006','f0000000-0000-0000-0000-000000000003','OWN_FICHA_AS_LEARNER'),
('10000000-0000-0000-0000-000000000006','d0000000-0000-0000-0000-000000000004','f0000000-0000-0000-0000-000000000004','AREA'),
('10000000-0000-0000-0000-000000000007','d0000000-0000-0000-0000-000000000007','f0000000-0000-0000-0000-000000000006','GLOBAL'),
('10000000-0000-0000-0000-000000000008','d0000000-0000-0000-0000-000000000001','f0000000-0000-0000-0000-000000000007','GLOBAL');

-- =====================================================================
-- SEED — Jerarquía geográfica (Yopal, Casanare) + centro de formación
-- =====================================================================

INSERT INTO macroregion (id, code, name) VALUES
('20000000-0000-0000-0000-000000000001','ORINOQ','Regional Orinoquía');

INSERT INTO microregion (id, macroregion_id, code, name) VALUES
('20000000-0000-0000-0000-000000000002','20000000-0000-0000-0000-000000000001','CASANARE','Casanare');

INSERT INTO department (id, microregion_id, name, dane_code) VALUES
('20000000-0000-0000-0000-000000000003','20000000-0000-0000-0000-000000000002','Casanare','85');

INSERT INTO municipality (id, department_id, name, dane_code) VALUES
('20000000-0000-0000-0000-000000000004','20000000-0000-0000-0000-000000000003','Yopal','85001');

INSERT INTO training_center (id, municipality_id, center_code, name, address, phone, is_active) VALUES
('20000000-0000-0000-0000-000000000005','20000000-0000-0000-0000-000000000004','CF-YOP-01','Centro de Formación Yopal','Km 1 vía Yopal - Aguazul','6086325000',TRUE);

-- =====================================================================
-- SEED — Estructura curricular (ADSO) y ficha
-- =====================================================================

INSERT INTO tech_line (id, name, code) VALUES
('30000000-0000-0000-0000-000000000001','Tecnologías de la Información','TI');

INSERT INTO tech_network (id, tech_line_id, name) VALUES
('30000000-0000-0000-0000-000000000002','30000000-0000-0000-0000-000000000001','Red de Software');

INSERT INTO knowledge_network (id, tech_network_id, name) VALUES
('30000000-0000-0000-0000-000000000003','30000000-0000-0000-0000-000000000002','Análisis y Desarrollo de Software');

INSERT INTO training_program (id, knowledge_network_id, program_code, name, training_level, total_hours, version, is_active) VALUES
('30000000-0000-0000-0000-000000000004','30000000-0000-0000-0000-000000000003','228106','Tecnólogo en Análisis y Desarrollo de Software','TECHNOLOGIST',2880,1,TRUE);

INSERT INTO competency (id, program_id, sena_code, name, total_hours) VALUES
('30000000-0000-0000-0000-000000000005','30000000-0000-0000-0000-000000000004','220501092','Desarrollar componentes de software según requisitos del sistema',400);

INSERT INTO enrollment_ficha (id, program_id, training_center_id, ficha_number, start_date, expected_end_date, learner_count, status) VALUES
('30000000-0000-0000-0000-000000000006','30000000-0000-0000-0000-000000000004','20000000-0000-0000-0000-000000000005','3413974','2025-02-03','2026-12-15',28,'EXECUTION');

-- =====================================================================
-- SEED — Ambientes, instructor, aprendiz, usuario, horario y sesión
-- =====================================================================

INSERT INTO environment_type (id, code, name, description) VALUES
('40000000-0000-0000-0000-000000000001','LAB_SOFT','Laboratorio de software','Sala con equipos de cómputo para desarrollo');

INSERT INTO environment (id, environment_type_id, training_center_id, name, capacity, location, is_active) VALUES
('40000000-0000-0000-0000-000000000002','40000000-0000-0000-0000-000000000001','20000000-0000-0000-0000-000000000005','Ambiente 204',30,'Bloque B, piso 2',TRUE);

INSERT INTO user (id, email, password_hash, full_name, actor_type, is_active) VALUES
('50000000-0000-0000-0000-000000000001','instructor.adso@sena.edu.co','$2y$10$examplehashonly','Laura Ximena Rojas','INSTRUCTOR',TRUE),
('50000000-0000-0000-0000-000000000002','rony.aprendiz@sena.edu.co','$2y$10$examplehashonly','Rony','LEARNER',TRUE);

INSERT INTO instructor (id, user_id, document_type, document_number, full_name, email, phone, max_hours_per_week, is_active) VALUES
('50000000-0000-0000-0000-000000000003','50000000-0000-0000-0000-000000000001','CC','1117845321','Laura Ximena Rojas','instructor.adso@sena.edu.co','3115557788',40.0,TRUE);

INSERT INTO competency_assignment (id, instructor_id, competency_id, certified_at, is_active) VALUES
('50000000-0000-0000-0000-000000000004','50000000-0000-0000-0000-000000000003','30000000-0000-0000-0000-000000000005','2024-01-15',TRUE);

INSERT INTO learner (id, user_id, document_type, document_number, full_name, email, ficha_id, enrollment_status, current_stage) VALUES
('50000000-0000-0000-0000-000000000005','50000000-0000-0000-0000-000000000002','TI','1122334455','Rony','rony.aprendiz@sena.edu.co','30000000-0000-0000-0000-000000000006','ACTIVE','LECTURE');

INSERT INTO user_role (id, user_id, role_id, training_center_id, assigned_by) VALUES
('50000000-0000-0000-0000-000000000006','50000000-0000-0000-0000-000000000001','d0000000-0000-0000-0000-000000000005','20000000-0000-0000-0000-000000000005',NULL),
('50000000-0000-0000-0000-000000000007','50000000-0000-0000-0000-000000000002','d0000000-0000-0000-0000-000000000006','20000000-0000-0000-0000-000000000005',NULL);

INSERT INTO time_slot (id, day_of_week, start_time, end_time, name) VALUES
('60000000-0000-0000-0000-000000000001',1,'07:00:00','10:00:00','Lunes AM'),
('60000000-0000-0000-0000-000000000002',3,'14:00:00','17:00:00','Miércoles PM');

INSERT INTO schedule (id, ficha_id, name, status, created_by) VALUES
('60000000-0000-0000-0000-000000000003','30000000-0000-0000-0000-000000000006','Horario 3413974 - Trimestre 3','PUBLISHED','50000000-0000-0000-0000-000000000001');

INSERT INTO class_session (id, schedule_id, competency_id, instructor_id, environment_id, time_slot_id, session_date, notes) VALUES
('60000000-0000-0000-0000-000000000004','60000000-0000-0000-0000-000000000003','30000000-0000-0000-0000-000000000005','50000000-0000-0000-0000-000000000003','40000000-0000-0000-0000-000000000002','60000000-0000-0000-0000-000000000001','2026-08-24','Sesión de laboratorio: backend'),
('60000000-0000-0000-0000-000000000005','60000000-0000-0000-0000-000000000003','30000000-0000-0000-0000-000000000005','50000000-0000-0000-0000-000000000003','40000000-0000-0000-0000-000000000002','60000000-0000-0000-0000-000000000002','2026-08-26','Sesión de laboratorio: base de datos');

-- =====================================================================
-- SEED — Seguimiento de ficha (cierra el hueco detectado en instructor.bpmn)
-- =====================================================================

INSERT INTO ficha_tracking (id, ficha_id, assigned_instructor_id, status) VALUES
('70000000-0000-0000-0000-000000000001','30000000-0000-0000-0000-000000000006','50000000-0000-0000-0000-000000000003','ON_TRACK');

INSERT INTO tracking_session (id, ficha_tracking_id, session_date, instructor_id, attendance_percentage, progress_percentage, notes) VALUES
('70000000-0000-0000-0000-000000000002','70000000-0000-0000-0000-000000000001','2026-08-15','50000000-0000-0000-0000-000000000003',92.50,68.00,'Buen avance general del grupo');

INSERT INTO kpi_tracking (id, ficha_tracking_id, kpi_code, value, measured_at) VALUES
('70000000-0000-0000-0000-000000000003','70000000-0000-0000-0000-000000000001','ATTENDANCE_RATE',92.5000,'2026-08-15 08:00:00');

-- =====================================================================
-- VISTA — Horario del usuario autenticado (instructor o aprendiz)
-- =====================================================================

CREATE OR REPLACE VIEW v_my_schedule AS
SELECT
  cs.id               AS class_session_id,
  s.id                AS schedule_id,
  s.name              AS schedule_name,
  s.status            AS schedule_status,
  ef.ficha_number,
  c.name              AS competency_name,
  i.id                AS instructor_id,
  i.full_name         AS instructor_name,
  e.name              AS environment_name,
  ts.day_of_week,
  ts.start_time,
  ts.end_time,
  cs.session_date,
  cs.notes
FROM class_session cs
JOIN schedule s          ON s.id = cs.schedule_id
JOIN enrollment_ficha ef  ON ef.id = s.ficha_id
JOIN competency c         ON c.id = cs.competency_id
JOIN instructor i         ON i.id = cs.instructor_id
JOIN environment e        ON e.id = cs.environment_id
JOIN time_slot ts         ON ts.id = cs.time_slot_id
WHERE s.status = 'PUBLISHED';
