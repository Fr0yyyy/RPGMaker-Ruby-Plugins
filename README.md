# PLATINUM-REPOSITORY

Repositorio principal para el proyecto "PLATINUM" basado en Pokémon Essentials v21.1.

Este repositorio agrupa scripts, plugins y recursos (gráficos, PBS, animaciones)
utilizados para el desarrollo y pruebas del proyecto. Contiene varios plugins
propios y adaptaciones de terceros (DBK, LA BASE DE SKY, Hotfixes).

Contenido destacado
- `Plugins/` — Plugins creados o integrados en el proyecto.
- `PBS/` — Definiciones de movimientos, habilidades, etc.
- `Data/` y `Graphics/` — Datos del juego y recursos gráficos.

Objetivo
=======
Mantener y desarrollar funcionalidades adicionales (movimientos, habilidades,
mejoras en editor de animaciones, parches de compatibilidad) sin modificar
el código base de Essentials, facilitando su compartición y revisión.

Requisitos
==========
- Pokémon Essentials v21.1
- v21.1 Hotfixes (1.0.9)
- Opcional: Deluxe Battle Kit (DBK) y LA BASE DE SKY si quieres todas las
	características integradas.

Cómo usar (rápido)
==================
1. Copia la carpeta del plugin deseado a `Plugins/` (ya está dentro del repo).
2. Abre el juego con `Game.exe` (está en la raíz cuando se compila).
3. Ve a `Debug > Compile` para compilar PBS y scripts.
4. Usa el Debug Menu para pruebas y comandos (p. ej. `pbTestCustomMoves`).

Plugins propios destacados
==========================
- `Plugins/[CUSTOM_000] Custom Moves` — Movimientos personalizados, handlers
	de IA y tests automatizados.
- `Plugins/[DBK_999] Custom Abilities` — Habilidad/es personalizadas con
	handlers de batalla no invasivos.
- `Plugins/[CUSTOM] Better Animation Editor` — Mejoras al editor de animaciones
	(selección, interpolación, herramientas en lote).

Contribuir
==========
Si quieres colaborar, crea un fork y abre un pull request. Revisa `README` del
plugin que quieras mejorar para instrucciones específicas.


Contacto
=======
Autor / responsable: Fr0yyyy

Más información
===============
Revisa las carpetas individuales de cada plugin para documentación más
detallada y scripts de prueba.

