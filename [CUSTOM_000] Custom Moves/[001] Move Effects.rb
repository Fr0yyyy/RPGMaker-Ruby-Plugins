#===============================================================================
# Custom Move Effects
#===============================================================================
# Este archivo contiene los function codes personalizados para los movimientos
# Basados en la estructura de Pokemon Essentials v21.1
#===============================================================================

#===============================================================================
# RaiseUserAtkDefSpd1 - Aumenta Ataque, Defensa y Velocidad del usuario en 1 nivel
# Usado por: IMPULSOTAURO
#===============================================================================
class Battle::Move::RaiseUserAtkDefSpd1 < Battle::Move::MultiStatUpMove
  def initialize(battle, move)
    super
    @statUp = [:ATTACK, 1, :DEFENSE, 1, :SPEED, 1]
  end
end

#===============================================================================
# RaiseUserAtkDef2Spd2 - Aumenta Ataque y Defensa en 1 nivel, Velocidad en 2 niveles
# Usado por: DANZAREAL
#===============================================================================
class Battle::Move::RaiseUserAtkDef1Spd2 < Battle::Move::MultiStatUpMove
  def initialize(battle, move)
    super
    @statUp = [:ATTACK, 1, :DEFENSE, 1, :SPEED, 2]
  end
end

#===============================================================================
# FailsIfUserNotOricorioStyle - Falla si el usuario no es Oricorio de un estilo específico
# Base para las Danzas de Oricorio (Flamígera, Relámpago, Espectral, Psique)
#===============================================================================
class Battle::Move::FailsIfUserNotOricorioStyle < Battle::Move
  # Override this in subclasses with the required form index
  def requiredForm
    return 0 # Pa'u (Baile Apasionado)
  end
  
  def requiredSpecies
    return :ORICORIO
  end
  
  def pbMoveFailed?(user, targets, show_message)
    if user.isSpecies?(requiredSpecies)
      if user.form == requiredForm
        return false
      else
        @battle.pbDisplay(_INTL("¡Pero falló!")) if show_message
        return true
      end
    else
      @battle.pbDisplay(_INTL("¡Pero falló!")) if show_message
      return true
    end
  end
end

#===============================================================================
# DANZAFLAMIGERA - Solo funciona con Oricorio Estilo Apasionado (Forma 0)
#===============================================================================
class Battle::Move::FailsIfUserNotOriPau < Battle::Move::FailsIfUserNotOricorioStyle
  def requiredForm
    return 0 # Pa'u (Fire)
  end
end

#===============================================================================
# DANZARELAMPAGO - Solo funciona con Oricorio Estilo Animado (Forma 1)
#===============================================================================
class Battle::Move::FailsIfUserNotOriPomPom < Battle::Move::FailsIfUserNotOricorioStyle
  def requiredForm
    return 1 # Pom-Pom (Electric)
  end
end

#===============================================================================
# DANZAESPECTRAL - Solo funciona con Oricorio Estilo Refinado (Forma 2)
#===============================================================================
class Battle::Move::FailsIfUserNotOriSensu < Battle::Move::FailsIfUserNotOricorioStyle
  def requiredForm
    return 2 # Sensu (Ghost)
  end
end

#===============================================================================
# DANZAPSIQUE - Solo funciona con Oricorio Estilo Plácido (Forma 3)
#===============================================================================
class Battle::Move::FailsIfUserNotOriBaile < Battle::Move::FailsIfUserNotOricorioStyle
  def requiredForm
    return 3 # Baile (Psychic)
  end
end

#===============================================================================
# TypeIsUserFirstTypePriority - Tipo es el del usuario y tiene prioridad
# Usado por: HUESORAPIDO
#===============================================================================
class Battle::Move::TypeIsUserFirstTypePriority < Battle::Move
  def pbBaseType(user)
    userTypes = user.pbTypes(true)
    return userTypes[0] || @type
  end
  
  def pbPriority(user)
    return 1 # Prioridad alta, similar a Quick Attack
  end
end

CustomMoves.log("Move Effects loaded successfully")
