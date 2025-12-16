#===============================================================================
# Custom Moves Plugin - Configuration
#===============================================================================
# Este plugin añade movimientos personalizados compatibles con
# Pokemon Essentials v21.1 y Deluxe Battle Kit
#===============================================================================

module CustomMoves
  VERSION = "1.0.0"
  
  # Logging method for debug
  def self.log(message)
    echoln("[Custom Moves] #{message}") if $DEBUG
  end
  
  # Check DBK compatibility (optional)
  def self.dbk_installed?
    return defined?(ZMove) || defined?(Settings::DYNAMAX_STYLE)
  end
end

# Loading message
CustomMoves.log("Initializing Custom Moves v#{CustomMoves::VERSION}")
CustomMoves.log("Deluxe Battle Kit detected: #{CustomMoves.dbk_installed?}")
