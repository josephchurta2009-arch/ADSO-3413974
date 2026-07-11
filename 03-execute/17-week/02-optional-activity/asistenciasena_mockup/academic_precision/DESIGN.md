---
name: Academic Precision
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#404847'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#717977'
  outline-variant: '#c0c8c6'
  surface-tint: '#3b6660'
  primary: '#001b18'
  on-primary: '#ffffff'
  primary-container: '#00322d'
  on-primary-container: '#709b94'
  inverse-primary: '#a3cfc8'
  secondary: '#226d00'
  on-secondary: '#ffffff'
  secondary-container: '#8afd5d'
  on-secondary-container: '#257400'
  tertiary: '#2c0e05'
  on-tertiary: '#ffffff'
  tertiary-container: '#452216'
  on-tertiary-container: '#bb8776'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#beece3'
  primary-fixed-dim: '#a3cfc8'
  on-primary-fixed: '#00201d'
  on-primary-fixed-variant: '#234e48'
  secondary-fixed: '#8afd5d'
  secondary-fixed-dim: '#6fdf43'
  on-secondary-fixed: '#052100'
  on-secondary-fixed-variant: '#185200'
  tertiary-fixed: '#ffdbd0'
  tertiary-fixed-dim: '#f3b9a7'
  on-tertiary-fixed: '#311208'
  on-tertiary-fixed-variant: '#653c2f'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
  attendance-present: '#22C55E'
  attendance-absent: '#EF4444'
  attendance-late: '#F59E0B'
  attendance-justified: '#3B82F6'
  background-main: '#FFFFFF'
  surface-muted: '#F8FAFC'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  headline-md-mobile:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  touch-target: 48px
  container-max: 1280px
---

## Brand & Style

This design system is built for the fast-paced, high-stakes environment of vocational education and classroom management. The personality is **institutional yet modern**, balancing the formal authority of a government-backed educational body with the streamlined efficiency of a modern SaaS tool. 

The aesthetic follows a **Corporate / Modern** approach with a heavy emphasis on **Minimalism**. By prioritizing high-density information architecture and clean whitespace, the design ensures that instructors can navigate complex apprentice lists without cognitive fatigue. The visual language evokes a sense of reliability and speed, essential for capturing data accurately within the first few minutes of a session.

Key brand attributes:
- **Trustworthy:** Professional colors and structured layouts.
- **Efficient:** Minimal decorative elements; every pixel serves a functional purpose.
- **Accessible:** Large touch targets and high-contrast ratios for diverse hardware and lighting conditions.

## Colors

The palette is anchored by a **Deep Green** (Primary), symbolizing the institutional heritage and stability of the SENA-inspired aesthetic. This is paired with a **Crisp White** background to maintain a high-contrast environment suitable for diverse lighting conditions found in different "ambientes" (classrooms).

For the core functionality of the system—attendance tracking—a specific semantic palette is used:
- **Success (Green):** Indicates "Present" status.
- **Error (Red):** Indicates "Absent" status.
- **Warning (Amber):** Indicates "Late" status.
- **Info (Blue):** Indicates "Justified" status.

Slate gray serves as the neutral foundation for text and borders, ensuring that the primary brand colors and status indicators remain the focal points of the user experience.

## Typography

The design system utilizes **Inter** for all typographic needs. Chosen for its exceptional legibility and neutral tone, Inter excels in data-heavy environments where distinguishing between names and status codes is critical.

- **Headlines:** Use tighter letter spacing and heavier weights to create a clear hierarchy.
- **Body Text:** Standard weight for maximum readability in long lists of names.
- **Labels:** Used for status badges and metadata (e.g., Ficha numbers, timestamps). These use a slightly increased letter spacing to improve clarity at smaller sizes.
- **Mobile Scale:** For display sizes and headlines, the system scales down to prevent text wrapping on smaller smartphone screens used by instructors on the move.

## Layout & Spacing

The layout is based on a **Fluid Grid** system that prioritizes mobile-first interaction. 

### Layout Philosophy
- **Grid:** A 12-column grid is used for desktop views, collapsing to 4 columns for mobile.
- **Margins:** 24px margins on desktop, reducing to 16px on mobile to maximize horizontal space for student lists.
- **Touch Targets:** A strict adherence to a 48px minimum touch target ensures that instructors can quickly tap attendance buttons (Present/Absent) without errors, even while walking around a classroom.

### Vertical Rhythm
A 4px baseline grid governs all vertical spacing. This creates a predictable rhythm that helps users scan rows of information quickly. Components like list items for apprentices should have consistent 16px padding to maintain visual breathing room.

## Elevation & Depth

To maintain a professional, institutional feel, this design system uses **Tonal Layers** rather than heavy shadows.

- **Level 0 (Background):** The base canvas (`#FFFFFF`).
- **Level 1 (Cards/Lists):** Surface layers use a light gray background (`#F8FAFC`) or a 1px solid border (`#E2E8F0`) to define boundaries.
- **Level 2 (Interactive/Floating):** For elements like the QR code generator or floating action buttons, a very soft, low-opacity ambient shadow (Blur: 12px, Opacity: 8%) is used to suggest interactivity without breaking the clean, flat aesthetic.
- **Depth through Color:** Attendance status is communicated through solid color fills in badges, creating "depth" through visual prominence rather than physical elevation.

## Shapes

The shape language is **Soft**. This choice balances the seriousness of an institutional tool with the friendliness of modern software.

- **Buttons & Inputs:** Use the standard `rounded` (4px) setting for a crisp, organized appearance.
- **Status Badges:** Use `rounded-lg` or pill shapes to distinguish them from interactive buttons, making them feel like self-contained "stamps" of information.
- **QR Code Containers:** Should maintain a sharp or slightly rounded border to emphasize the technical nature of the scan session.

## Components

### Buttons
- **Primary:** Solid Deep Green (`#00322D`) with white text. Used for main actions like "Register Attendance" or "Generate QR."
- **Secondary:** Outlined with Slate Gray. Used for "Cancel" or "Edit" actions.
- **Attendance Toggles:** Large, high-contrast buttons that occupy the full 48px touch target height. When active, they use the semantic status color (e.g., Green for Present).

### Status Badges (Chips)
- High-contrast background with dark text or white text depending on the hue. 
- Example: "Presente" uses a light green background with dark green text for maximum legibility.

### List Items (Apprentice Row)
- Each row must be at least 64px tall to provide ample space for tapping.
- Includes the apprentice's name, a unique identifier (ID), and a horizontal group of status toggles.

### Input Fields
- Clean, 1px bordered boxes with Slate Gray. 
- Focus states must use the Primary Deep Green to clearly indicate the active field.

### QR Code Generator
- A prominent, centered card element.
- Includes a countdown timer for the "temporal" nature of the code and a "Refresh" button for security.

### Search & Filter
- Sticky top bar for "Ficha" or "Ambiente" selection, ensuring the instructor never loses context while scrolling through a long list of students.