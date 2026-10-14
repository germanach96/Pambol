---
version: 1
slug: "jugada-mockup-html"
primary_target: "jugada-mockup.html"
related_targets: []
---

# Surface: jugada-mockup.html — situación "Sin balón"

Mode: operate. Audience/job: the owner studies a 5v5 off-ball situation; drags players, sees where to move, presses Animar to watch the next 3–4 s.

## Direction contract

THESIS: A tactical board that feels like a native iPhone app in dark mode: the pitch is a flat card floating on a night tinted by the two teams' colours, and every control is a translucent iOS material. Refuses fake lighting, mesh textures and costume fonts.

OWN-WORLD: Near-black night (#0a0a0c) tinted by radial gradients of the rival colour (top, behind their goal) and my team colour (bottom). Flat mown-stripe pitch as a rounded card. Flat kit tokens with a visible outline ring. System font stack (SF Pro; SF Pro Rounded for wordmark and figures where the platform offers it, i.e. Safari/WebKit; plain system sans elsewhere). iOS dark tokens, translucent materials, segmented controls, grouped lists. One accent, system orange #ff9f0a, for everything that is "what you do".

STORY: The user sees who has the ball, sees cleat prints leading to a cone where to stand, nudges a player (it grows slightly while held), watches the answer move, picks a prebuilt play from "Jugadas y equipos" and watches the players slide into place, dresses each team (style, base, outline), presses Animar and sees each player drag a fading comet tail.

FIRST VIEWPORT: Mobile 390: top bar (pambol, kit selector), full-width pitch, bottom sheet peek (mode, title, one big figure, Animar + 3 icon buttons). Desktop: pitch left, floating sheet right.

FORM: iOS dark app, redirected by the user from the earlier night-pitch world (amendments 2 and 3). seed: none (unavailable). Signature moves: team-tinted night, cleat prints + cone, comet-tail replay, light thin arrows, real kits.

AMENDMENT (2026-10-12, user request): "Cambiar las estelas de la repetición: que se desvanezcan como cola de cometa en lugar de quedarse dibujadas" and "Flechas más ligeras: una línea fina con punta pequeña, sin cuña ni líneas de velocidad. La velocidad se ve por el largo." Long-exposure replay and brush-wedge arrows are retired. Kits are user-configurable per team (lisa, rayas, bandas, mitades; base + outline color, dorsal ink picked for contrast).

FINISH: unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance

AMENDMENT 2 (2026-10-12, user request): "quitame las luces que hay en las esquinas y el efecto que hay de sombras, no me gusta. la iluminación falsa que hay tanto en los jugadores como en la cancha está fea. hazlo simple". Corner lamps, lamp shadows, token/ball sheen, turf lighting, vignette, grain and fibers are retired.

AMENDMENT 3 (2026-10-12, user request via /apple-design): "metete en el diseño y hazlo como si fuera una app de apple. el fondo de red de futbol se me hace horrible. podrias hacer algun juego de degradado con los colores de los equipos". The cage mesh is retired; the night background is tinted by radial gradients of both team colours (rival top, mine bottom) that animate when kits change. UI follows iOS dark: system font stack (SF Pro / SF Pro Rounded for figures and wordmark), translucent materials on sheet, hint and toasts, iOS segmented controls and grouped lists, system orange accent #ff9f0a, pitch as a rounded card.
