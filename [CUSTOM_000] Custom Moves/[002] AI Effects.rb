#===============================================================================
# Custom Move AI Effects
#===============================================================================
# Este archivo contiene los handlers de IA para los movimientos personalizados
# Basados en la estructura de Pokemon Essentials v21.1 AI system
#===============================================================================

#===============================================================================
# RaiseUserAtkDefSpd1 - IMPULSOTAURO
# Aumenta Ataque, Defensa y Velocidad del usuario en 1 nivel
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaiseUserAtkDefSpd1",
  proc { |move, user, ai, battle|
    # Falla si no puede subir ninguna de las estadísticas
    will_fail = true
    [:ATTACK, :DEFENSE, :SPEED].each do |stat|
      if user.battler.pbCanRaiseStatStage?(stat, user.battler, move.move)
        will_fail = false
        break
      end
    end
    next will_fail
  }
)

Battle::AI::Handlers::MoveEffectScore.add("RaiseUserAtkDefSpd1",
  proc { |score, move, user, ai, battle|
    # Suma el valor de subir cada estadística
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    # Bonus adicional por subir múltiples stats útiles
    if ai.trainer.medium_skill?
      score += 15 # Bonus por ser multi-stat boost
    end
    next score
  }
)

#===============================================================================
# RaiseUserAtkDef1Spd2 - DANZAREAL
# Aumenta Ataque y Defensa en 1 nivel, Velocidad en 2 niveles
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaiseUserAtkDef1Spd2",
  proc { |move, user, ai, battle|
    # Falla si no puede subir ninguna de las estadísticas
    will_fail = true
    [:ATTACK, :DEFENSE, :SPEED].each do |stat|
      if user.battler.pbCanRaiseStatStage?(stat, user.battler, move.move)
        will_fail = false
        break
      end
    end
    next will_fail
  }
)

Battle::AI::Handlers::MoveEffectScore.add("RaiseUserAtkDef1Spd2",
  proc { |score, move, user, ai, battle|
    # Suma el valor de subir cada estadística
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    # Bonus adicional por subir velocidad x2 (muy valioso)
    if ai.trainer.medium_skill?
      score += 20 # Bonus extra por el +2 en Speed
    end
    next score
  }
)

#===============================================================================
# FailsIfUserNotOriPau - DANZAFLAMIGERA
# Solo funciona con Oricorio Estilo Apasionado (Fire/Flying)
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("FailsIfUserNotOriPau",
  proc { |move, user, ai, battle|
    next !user.battler.isSpecies?(:ORICORIO) || user.battler.form != 0
  }
)

Battle::AI::Handlers::MoveEffectScore.add("FailsIfUserNotOriPau",
  proc { |score, move, user, ai, battle|
    # Es un ataque especial multi-target de 90 de potencia, tipo Fire
    # La IA ya lo valorará correctamente por sí sola
    next score
  }
)

#===============================================================================
# FailsIfUserNotOriPomPom - DANZARELAMPAGO
# Solo funciona con Oricorio Estilo Animado (Electric/Flying)
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("FailsIfUserNotOriPomPom",
  proc { |move, user, ai, battle|
    next !user.battler.isSpecies?(:ORICORIO) || user.battler.form != 1
  }
)

Battle::AI::Handlers::MoveEffectScore.copy("FailsIfUserNotOriPau",
                                           "FailsIfUserNotOriPomPom")

#===============================================================================
# FailsIfUserNotOriSensu - DANZAESPECTRAL
# Solo funciona con Oricorio Estilo Refinado (Ghost/Flying)
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("FailsIfUserNotOriSensu",
  proc { |move, user, ai, battle|
    next !user.battler.isSpecies?(:ORICORIO) || user.battler.form != 2
  }
)

Battle::AI::Handlers::MoveEffectScore.copy("FailsIfUserNotOriPau",
                                           "FailsIfUserNotOriSensu")

#===============================================================================
# FailsIfUserNotOriBaile - DANZAPSIQUE
# Solo funciona con Oricorio Estilo Plácido (Psychic/Flying)
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("FailsIfUserNotOriBaile",
  proc { |move, user, ai, battle|
    next !user.battler.isSpecies?(:ORICORIO) || user.battler.form != 3
  }
)

Battle::AI::Handlers::MoveEffectScore.copy("FailsIfUserNotOriPau",
                                           "FailsIfUserNotOriBaile")

#===============================================================================
# TypeIsUserFirstTypePriority - HUESORAPIDO
# Tipo es el del usuario y tiene prioridad alta
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.add("TypeIsUserFirstTypePriority",
  proc { |score, move, user, ai, battle|
    # Bonus por tener prioridad (similar a Quick Attack)
    if ai.trainer.medium_skill?
      score += 15
    end
    # Bonus adicional si el objetivo es más rápido
    target = user.battler.pbDirectOpposing(true)
    if target && target.pbSpeed > user.battler.pbSpeed
      score += 10
    end
    # Bonus si el objetivo está bajo en HP y podemos rematarlo
    if ai.trainer.has_skill_flag?("HPAware")
      target = user.battler.pbDirectOpposing(true)
      if target && move.rough_damage >= target.hp * 0.8
        score += 25
      end
    end
    next score
  }
)

#===============================================================================
# LowerTargetSpDef1 - Ya existe en el juego base, pero añadimos scoring mejorado
# para ESTRELLATO que SIEMPRE baja la Defensa Especial (100% chance)
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("LowerTargetSpDef1",
  proc { |score, move, user, target, ai, battle|
    # Si el movimiento tiene 100% de efecto (como ESTRELLATO)
    if move.move.effect_chance == 100
      # La IA valorará más este movimiento porque SIEMPRE baja la stat
      score = ai.get_score_for_target_stat_drop(score, target, move.move.statDown, false)
      # Bonus adicional si el usuario o un aliado tiene ataques especiales
      if ai.trainer.medium_skill?
        has_special_attacks = false
        user.battler.eachAlly do |b|
          if b.check_for_move { |m| m.specialMove? }
            has_special_attacks = true
            break
          end
        end
        if has_special_attacks || user.check_for_move { |m| m.specialMove? }
          score += 15
        end
      end
    else
      # Comportamiento estándar para otros movimientos con este effect
      if move.move.effect_chance > 0
        score = ai.get_score_for_target_stat_drop(score, target, move.move.statDown, false)
      end
    end
    next score
  }
)

CustomMoves.log("AI Effects loaded successfully")
