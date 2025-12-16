# Custom Moves (Plugin)

Plugin: `[CUSTOM_000] Custom Moves`

Este plugin añade movimientos personalizados a Pokémon Essentials v21.1, con
function codes, integración con el sistema de IA y scripts de prueba. Está
pensado para ser instalado dentro de `Plugins/` y funcionar sin modificar el
código base del engine.

## Requisitos
- Pokémon Essentials v21.1
- v21.1 Hotfixes (1.0.9)
- Opcional: Deluxe Battle Kit (DBK) si quieres funcionalidades extendidas

## Qué contiene
- `[000] Config.rb` — Configuración general del plugin y logging.
- `[001] Move Effects.rb` — Function codes personalizados (clases `Battle::Move::*`).
- `[002] AI Effects.rb` — Handlers de IA para que la IA use y valore los movimientos.
- `[003] Test Script.rb` — Script `pbTestCustomMoves` y `pbTestBattle` para pruebas.
- `VALIDATION.rb` — Validador rápido.
- `README.rb` — Documentación larga en formato Ruby (opcional).

## Movimientos incluidos (resumen)
- ARANAZOIGNEO — Arañazo Ígneo (Fuego, físico)
- DANZAREAL — Danza Real (Bug, status): +Atk/+Def +1, +Spe +2
- DANZAFLAMIGERA — Danza Flamígera (FIRE): exclusivo Oricorio forma Pa'u
- DANZARELAMPAGO — Danza Relámpago (ELECTRIC): exclusivo Oricorio forma Pom-Pom
- DANZAESPECTRAL — Danza Espectral (GHOST): exclusivo Oricorio forma Sensu
- DANZAPSIQUE — Danza Psique (PSYCHIC): exclusivo Oricorio forma Baile
- HUESORAPIDO — Hueso Rápido: prioridad +1, tipo = tipo primario del usuario
- IMPULSOTAURO — Impulso Tauro: +Atk/+Def/+Spe +1
- ESTRELLATO — Estrellato: 90 Potencia, baja Sp.Def (100%)

## Instalación
1. Copia la carpeta `Plugins/[CUSTOM_000] Custom Moves` a la carpeta `Plugins/`
   de tu proyecto Essentials.
2. Abre el juego y ve a `Debug > Compile` para compilar PBS y scripts.
3. (Opcional) Reinicia el juego.

## Uso / Pruebas
- Desde la consola de debug (F12) ejecuta:
  - `pbTestCustomMoves` — Validación rápida de movimientos, clases y handlers.
  - `pbTestBattle(:TAUROS, 50, :ORICORIO_1, 50)` — Inicia una batalla de prueba.

## Notas técnicas
- Todos los function codes se implementan como subclases de `Battle::Move` o
  `Battle::Move::MultiStatUpMove` cuando procede.
- La IA usa handlers `Battle::AI::Handlers::MoveFailureCheck`,
  `MoveEffectScore` y `MoveEffectAgainstTargetScore` para valorar y evitar usos
  inútiles de movimientos.
- No se modifica código base; todo es un plugin independiente.

## Desarrollo y pruebas
- Ejemplos de funciones que puedes editar/añadir: nuevas `Move` classes,
  handlers IA o PBS entries.
- Para pruebas rápidas, usa `VALIDATION.rb` y `pbTestCustomMoves`.

## Licencia
- Añade un `LICENSE` (recomiendo MIT) si vas a publicar en GitHub.

## Contacto
Autor: Fr0yyyy

---

Si quieres, puedo preparar los archivos auxiliares (`LICENSE`, `.gitignore`),
un workflow de GitHub Actions para validar sintaxis Ruby y un `CHANGELOG`.
