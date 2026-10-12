# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Stack

Static HTML/CSS/JS in a single `index.html` (mockups as single `.html` files). No frameworks, no build step, no npm. Opens by double-click, works offline. Later published with GitHub Pages and added to the phone home screen. (Source: `pambol-spec.md`, `pambol-decisiones.md`.)

## Users

One person: the owner, an amateur fútbol 5 player. Uses it at home, after a match or while studying, never during play. Spanish-speaking (Mexico; "pambol" is the local word for football).

## Product Purpose

A tactical board for fútbol 5. The user sets up a game situation (ten players' positions, direction, speed and intensity; the ball; which player is "me") and Pambol tells them the best thing *they* can do in the next one or two seconds, draws it on the pitch, and can animate what happens next.

Two jobs: review a real play from a match ("what should I have done?") and study typical situations to learn patterns. Success: the recommendation is believable, recalculates instantly when anything moves, and the user learns the pattern.

## Positioning

It answers for one player, not the team: given who has the ball, it picks the user's single best action (with ball, without ball, or defending) from a transparent, local physics model (time-to-reach races, interception, a value map), and labels each answer as a fixed **Rule** or a **Calculation**. It is a model, not the truth, but its rules must leave no doubt.

## Operating Context

- Mobile-first (portrait, finger), tested now on desktop.
- Starts from prebuilt scenarios, then adjusted by dragging. Default players stand still at normal intensity; only 2–4 players get touched.
- Three automatic modes from who has the ball: Con balón / Sin balón / Defensa.

## Capabilities and Constraints

Confirmed interaction for the mock (interview, 2026-10-12):

- **Drag** a player to move it; **drag** the tip of its arrow to change direction.
- **Click a player** cycles intensity 1→2→3. **Click the tip of its arrow** cycles speed parado→trote→media→sprint (the arrow length follows).
- **Click the ball** picks it up; the next click on a player gives it to them, on the grass leaves it loose.
- **Who is "me"**: a selector row of dorsals above the pitch.
- Any change recomputes the recommendation live and moves the gold arrow.
- With the ball, pass or shot recommendations draw as a **dotted line**.
- **Animar** plays ~3–4 s and chains 2–3 actions (e.g. I move into space → teammate passes → I receive → next action recomputed). Rivals react (chase ball / their mark); teammates follow their arrows.

Pitch 40 × 20 m, my team attacks upward. All physics and scoring parameters live in a `CONFIG` object. Rules live in a separate data structure. No Claude API in v1.

Open: the definitive rule list (current list is provisional).

## Brand Commitments

- Name **Pambol** in header and `<title>`.
- Recommended play in **gold**, dashed; alternative in light grey; play to avoid in **pink** with ✕ and interception zone. "Tú" marked with a gold ring. Direction arrows in white. Mown-stripe grass.
- System font stack (SF Pro / SF Pro Rounded on Apple devices, `system-ui` elsewhere); no web fonts, so it works offline. Apple-style dark UI with translucent materials and a background tinted by both team colours (user request, 2026-10-12).
- All UI copy in Spanish.

## Evidence on Hand

`pambol-spec.md`, `pambol-decisiones.md`. No real match data, users, or testimonials; scenarios are authored examples.

## Product Principles

1. One answer, for me, now: a single next action, not a playbook.
2. Show the reason: every recommendation carries its numbers (advantage, risk, distance) and a Rule/Calculation label.
3. Touch the few players that matter; everything else stays sensible by default.
4. Instant feedback: moving anything re-answers immediately, and motion explains what happens next.
