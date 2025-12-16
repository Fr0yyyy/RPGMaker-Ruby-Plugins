#===============================================================================
# Custom Moves Plugin - README
#===============================================================================
# Versión: 1.0.0
# Autor: Fr0yyyy
# Compatible con: Pokémon Essentials v21.1 + Deluxe Battle Kit
#===============================================================================

=begin

DESCRIPCIÓN
===========
Este plugin añade movimientos personalizados al juego con function codes 
completamente funcionales e integración completa con el sistema de IA de combate.

MOVIMIENTOS INCLUIDOS
=====================

1. ARAÑAZO ÍGNEO (ARANAZOIGNEO)
   - Tipo: Fire
   - Categoría: Physical
   - Potencia: 40
   - Precisión: 100%
   - PP: 35
   - Efecto: Ataque físico básico de tipo Fuego con contacto.
   
2. DANZA REAL (DANZAREAL)
   - Tipo: Bug
   - Categoría: Status
   - PP: 15
   - Efecto: Aumenta Ataque y Defensa en 1 nivel, Velocidad en 2 niveles.
   - Flags: Dance
   - Function Code: RaiseUserAtkDef1Spd2
   
3. DANZA FLAMÍGERA (DANZAFLAMIGERA)
   - Tipo: Fire
   - Categoría: Special
   - Potencia: 90
   - Precisión: 100%
   - PP: 15
   - Target: AllNearFoes
   - Efecto: Solo puede ser usado por Oricorio Estilo Apasionado (Forma 0).
   - Flags: Dance
   - Function Code: FailsIfUserNotOriPau
   
4. DANZA RELÁMPAGO (DANZARELAMPAGO)
   - Tipo: Electric
   - Categoría: Special
   - Potencia: 90
   - Precisión: 100%
   - PP: 15
   - Target: AllNearFoes
   - Efecto: Solo puede ser usado por Oricorio Estilo Animado (Forma 1).
   - Flags: Dance
   - Function Code: FailsIfUserNotOriPomPom
   
5. DANZA ESPECTRAL (DANZAESPECTRAL)
   - Tipo: Ghost
   - Categoría: Special
   - Potencia: 90
   - Precisión: 100%
   - PP: 15
   - Target: AllNearFoes
   - Efecto: Solo puede ser usado por Oricorio Estilo Refinado (Forma 2).
   - Flags: Dance
   - Function Code: FailsIfUserNotOriSensu
   
6. DANZA PSIQUE (DANZAPSIQUE)
   - Tipo: Psychic
   - Categoría: Special
   - Potencia: 90
   - Precisión: 100%
   - PP: 15
   - Target: AllNearFoes
   - Efecto: Solo puede ser usado por Oricorio Estilo Plácido (Forma 3).
   - Flags: Dance
   - Function Code: FailsIfUserNotOriBaile
   
7. HUESO RÁPIDO (HUESORAPIDO)
   - Tipo: Normal (cambia al tipo primario del usuario)
   - Categoría: Physical
   - Potencia: 40
   - Precisión: 100%
   - PP: 30
   - Prioridad: +1
   - Efecto: Ataque de prioridad alta cuyo tipo coincide con el tipo primario del usuario.
   - Flags: Contact, Bone
   - Function Code: TypeIsUserFirstTypePriority
   
8. IMPULSO TAURO (IMPULSOTAURO)
   - Tipo: Fighting
   - Categoría: Status
   - PP: 10
   - Efecto: Aumenta Ataque, Defensa y Velocidad en 1 nivel cada uno.
   - Function Code: RaiseUserAtkDefSpd1
   
9. ESTRELLATO (ESTRELLATO)
   - Tipo: Psychic
   - Categoría: Special
   - Potencia: 90
   - Precisión: 100%
   - PP: 10
   - Efecto: SIEMPRE baja la Defensa Especial del objetivo en 1 nivel (100% de probabilidad).
   - Function Code: LowerTargetSpDef1
   - EffectChance: 100

ESTRUCTURA DEL PLUGIN
======================
[CUSTOM_000] Custom Moves/
├── [000] Config.rb          - Configuración y constantes del plugin
├── [001] Move Effects.rb    - Function codes de los movimientos
├── [002] AI Effects.rb      - Handlers de IA para los movimientos
└── README.rb                - Este archivo (documentación)

FUNCTION CODES IMPLEMENTADOS
=============================

1. RaiseUserAtkDefSpd1
   - Aumenta Ataque, Defensa y Velocidad del usuario en 1 nivel.
   - Hereda de: Battle::Move::MultiStatUpMove
   
2. RaiseUserAtkDef1Spd2
   - Aumenta Ataque y Defensa en 1 nivel, Velocidad en 2 niveles.
   - Hereda de: Battle::Move::MultiStatUpMove
   
3. FailsIfUserNotOricorioStyle (clase base)
   - Clase base para los movimientos exclusivos de Oricorio.
   - Verifica especie y forma del usuario.
   
4. FailsIfUserNotOriPau
   - Falla si no es Oricorio Forma 0 (Pa'u - Fire/Flying).
   
5. FailsIfUserNotOriPomPom
   - Falla si no es Oricorio Forma 1 (Pom-Pom - Electric/Flying).
   
6. FailsIfUserNotOriSensu
   - Falla si no es Oricorio Forma 2 (Sensu - Ghost/Flying).
   
7. FailsIfUserNotOriBaile
   - Falla si no es Oricorio Forma 3 (Baile - Psychic/Flying).
   
8. TypeIsUserFirstTypePriority
   - El tipo del movimiento es el tipo primario del usuario.
   - Tiene prioridad +1 (similar a Quick Attack).
   - Hereda de: Battle::Move

INTEGRACIÓN CON LA IA
======================

Todos los movimientos incluyen handlers completos para el sistema de IA:

- MoveFailureCheck: Detecta si el movimiento fallará antes de usarlo.
- MoveEffectScore: Calcula el valor estratégico del movimiento.
- MoveEffectAgainstTargetScore: Evalúa el movimiento contra objetivos específicos.

La IA considera:
- Niveles de habilidad del entrenador (medium_skill?, has_skill_flag?)
- Estado del combate (HP, stats, velocidad)
- Sinergia con otros movimientos y aliados
- Ventajas de tipo y situacionales

INSTALACIÓN
============

1. Copia la carpeta [CUSTOM_000] Custom Moves a tu carpeta Plugins/.
2. Los movimientos ya están definidos en PBS/moves.txt.
3. Compila el juego (Debug > Compile).
4. Los movimientos estarán disponibles inmediatamente.

COMPATIBILIDAD
==============

✓ Pokémon Essentials v21.1
✓ Deluxe Battle Kit (DBK)
✓ Sistema de IA estándar de Essentials
✓ Hotfixes 1.0.9
✓ LA BASE DE SKY v1.1.1

EXTENSIÓN Y PERSONALIZACIÓN
============================

Para añadir nuevos movimientos:

1. Define el movimiento en PBS/moves.txt
2. Si necesitas un nuevo function code:
   - Añádelo en [001] Move Effects.rb
   - Hereda de la clase base apropiada (Battle::Move o sus subclases)
3. Añade los handlers de IA en [002] AI Effects.rb:
   - MoveFailureCheck (opcional)
   - MoveEffectScore (recomendado)
   - MoveEffectAgainstTargetScore (para movimientos con efectos en el objetivo)

EJEMPLO DE NUEVO MOVIMIENTO:
-----------------------------

# En PBS/moves.txt:
[NUEVOMOVIMIENTO]
Name = Nuevo Movimiento
Type = NORMAL
Category = Physical
Power = 50
Accuracy = 100
TotalPP = 20
Target = NearOther
FunctionCode = MiNuevoFunctionCode
Flags = Contact,CanProtect,CanMirrorMove
Description = Descripción del movimiento.

# En [001] Move Effects.rb:
class Battle::Move::MiNuevoFunctionCode < Battle::Move
  def pbEffectAfterAllHits(user, target)
    # Tu lógica aquí
  end
end

# En [002] AI Effects.rb:
Battle::AI::Handlers::MoveEffectScore.add("MiNuevoFunctionCode",
  proc { |score, move, user, ai, battle|
    # Tu scoring aquí
    next score
  }
)

CHANGELOG
=========

v1.0.0 (2025-12-11)
-------------------
- Lanzamiento inicial
- 9 movimientos personalizados implementados
- 8 function codes nuevos
- Integración completa con sistema de IA
- Documentación completa

CRÉDITOS
========

Desarrollado por: Fr0yyyy
Basado en: Pokémon Essentials v21.1
Compatible con: Deluxe Battle Kit

SOPORTE
=======

Para reportar bugs o sugerir mejoras, contacta con el desarrollador.

=end
