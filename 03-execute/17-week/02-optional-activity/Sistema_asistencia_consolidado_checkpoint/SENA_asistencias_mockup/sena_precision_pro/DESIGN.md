---
name: SENA Precision Pro
colors:
  surface: '#f8f9fa'
  surface-dim: '#d9dadb'
  surface-bright: '#f8f9fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f4f5'
  surface-container: '#edeeef'
  surface-container-high: '#e7e8e9'
  surface-container-highest: '#e1e3e4'
  on-surface: '#191c1d'
  on-surface-variant: '#3f4a3b'
  inverse-surface: '#2e3132'
  inverse-on-surface: '#f0f1f2'
  outline: '#6f7a69'
  outline-variant: '#becab6'
  surface-tint: '#006e0d'
  primary: '#006e0d'
  on-primary: '#ffffff'
  primary-container: '#39a935'
  on-primary-container: '#003503'
  inverse-primary: '#6fde63'
  secondary: '#575e70'
  on-secondary: '#ffffff'
  secondary-container: '#d9dff5'
  on-secondary-container: '#5c6274'
  tertiary: '#585f6c'
  on-tertiary: '#ffffff'
  tertiary-container: '#8d94a3'
  on-tertiary-container: '#262d39'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#8bfc7c'
  primary-fixed-dim: '#6fde63'
  on-primary-fixed: '#002201'
  on-primary-fixed-variant: '#005307'
  secondary-fixed: '#dce2f7'
  secondary-fixed-dim: '#c0c6db'
  on-secondary-fixed: '#141b2b'
  on-secondary-fixed-variant: '#404758'
  tertiary-fixed: '#dce2f3'
  tertiary-fixed-dim: '#c0c7d6'
  on-tertiary-fixed: '#151c27'
  on-tertiary-fixed-variant: '#404754'
  background: '#f8f9fa'
  on-background: '#191c1d'
  surface-variant: '#e1e3e4'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 8px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  container-max: 1440px
  gutter: 24px
  sidebar-width: 260px
---

## Brand & Style
The design system is engineered for high-utility educational environments, prioritizing clarity, efficiency, and institutional trust. It targets administrators, instructors, and students within a professional ecosystem, requiring a UI that feels both authoritative and effortless to navigate.

The aesthetic follows a **Modern Corporate** approach, blending the organizational rigor of Microsoft 365 with the refined, minimalist execution found in developer-centric tools like Linear. The interface leverages ample whitespace to reduce cognitive load during complex data entry and attendance tracking. Every element is designed with high-fidelity precision, utilizing subtle borders and soft elevations to create a sense of organized depth without visual clutter.

## Colors
This design system utilizes a high-contrast palette grounded in Institutional Green to reinforce brand identity. 

- **Primary:** Institutional Green (#39A935) is used for primary actions, success states, and brand reinforcement.
- **Surface & Background:** The layout uses a Pure White (#FFFFFF) primary background with Light Gray (#F9FAFB) for secondary surfaces like sidebars and container backgrounds to create subtle separation.
- **Typography:** Deep Charcoal (#111827) is used for headers to ensure maximum readability, while Mid-Gray (#6B7280) is reserved for secondary text and icons.
- **Semantic Statuses:** Specifically tuned for attendance, using soft pastel backgrounds with high-contrast text for badges (e.g., Mint for "Presente", Rose for "Ausente").

## Typography
Inter is the sole typeface for this design system, chosen for its exceptional legibility in data-dense environments. The type scale is built on a modular 4px grid.

- **Headlines:** Use semi-bold weights with slight negative letter-spacing for a modern, "tight" feel.
- **Body Text:** Standardized at 14px for most interface elements to maximize information density while maintaining accessibility.
- **Labels:** Small, all-caps labels are used for metadata and table headers to create a clear distinction from interactive data points.

## Layout & Spacing
The layout follows a **Fixed-Fluid hybrid** model. The primary navigation is a fixed-width left sidebar (260px), while the main content area resides in a fluid container with a maximum width of 1440px for optimal readability.

- **Grid:** A 12-column grid is used for dashboard layouts.
- **Spacing Rhythm:** Use a strict 4px/8px incremental system. Components should generally have 16px (md) or 24px (lg) of internal padding to maintain the "breathing room" required by the brand personality.
- **Responsive Behavior:** On mobile, sidebars collapse into a drawer menu and container margins reduce to 16px.

## Elevation & Depth
This design system uses a logic of **Tonal Elevation** complemented by soft, diffused shadows to indicate hierarchy and interactivity.

- **Level 0 (Flat):** Main background surfaces (#FFFFFF).
- **Level 1 (Subtle):** Cards and main UI containers. Defined by a 1px border (#E5E7EB) and a soft shadow: `0px 1px 3px rgba(0,0,0,0.05), 0px 1px 2px rgba(0,0,0,0.03)`.
- **Level 2 (Active/Floating):** Modals, dropdowns, and hovered cards. Increased shadow depth: `0px 10px 15px -3px rgba(0,0,0,0.08), 0px 4px 6px -2px rgba(0,0,0,0.04)`.
- **Backdrop:** Use a 40% opacity blur for modal overlays to keep focus on the foreground without losing context.

## Shapes
The shape language is "Soft Professional." 
- **Base Components:** Buttons and input fields use an 8px (0.5rem) radius.
- **Containers:** Large cards and dashboard sections use a 12px (0.75rem) radius to feel modern and approachable.
- **Status Pills:** Badges for attendance use a fully rounded (pill) shape to distinguish them from interactive buttons.

## Components
- **Buttons:** Primary buttons use a solid #39A935 background with white text. Secondary buttons use a white background with a 1px #E5E7EB border.
- **Attendance Badges:** 
    - *Presente:* Green text on Emerald-50 background.
    - *Ausente:* Red text on Red-50 background.
    - *Tarde:* Amber text on Amber-50 background.
    - *Justificado:* Blue text on Blue-50 background.
- **Tables:** Use a minimalist approach. No vertical borders. 1px #F3F4F6 horizontal dividers. Apply a very subtle #F9FAFB zebra stripe on even rows for long data sets. Header cells use `label-md` typography.
- **Input Fields:** 1px #E5E7EB border that transitions to 1px #39A935 on focus with a subtle green outer glow.
- **Sidebars:** Use a #F9FAFB background. Active states for nav items should use a subtle left-aligned 3px vertical bar in Institutional Green and a slightly darker gray text weight.
- **Data Viz:** Use thin-stroke line charts and clean bar graphs using the primary green and neutral grays to maintain professional sobriety.