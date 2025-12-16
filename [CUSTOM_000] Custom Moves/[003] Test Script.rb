#===============================================================================
# Custom Moves - Test Script
#===============================================================================
# Este script prueba todos los movimientos personalizados y verifica su funcionalidad
# Ejecutar desde Debug Menu o consola: pbTestCustomMoves
#===============================================================================

def pbTestCustomMoves
  puts "\n" + "="*80
  puts "CUSTOM MOVES - TEST SUITE"
  puts "="*80
  
  # Test 1: Verificar que los movimientos existen
  puts "\n[TEST 1] Verificando existencia de movimientos..."
  custom_moves = [
    :ARANAZOIGNEO, :DANZAREAL, :DANZAFLAMIGERA, :DANZARELAMPAGO,
    :DANZAESPECTRAL, :DANZAPSIQUE, :HUESORAPIDO, :IMPULSOTAURO, :ESTRELLATO
  ]
  
  all_exist = true
  custom_moves.each do |move_id|
    if GameData::Move.exists?(move_id)
      move = GameData::Move.get(move_id)
      puts "  ✓ #{move.name} (#{move_id}) - Tipo: #{move.type}, Categoría: #{move.category}"
    else
      puts "  ✗ #{move_id} NO ENCONTRADO"
      all_exist = false
    end
  end
  
  if all_exist
    puts "\n  → Resultado: TODOS LOS MOVIMIENTOS EXISTEN ✓"
  else
    puts "\n  → Resultado: FALTAN MOVIMIENTOS ✗"
    puts "  → Acción requerida: Compila el juego (Debug > Compile)"
    return
  end
  
  # Test 2: Verificar Function Codes
  puts "\n[TEST 2] Verificando Function Codes..."
  function_codes = {
    :ARANAZOIGNEO => "None",
    :DANZAREAL => "RaiseUserAtkDef1Spd2",
    :DANZAFLAMIGERA => "FailsIfUserNotOriPau",
    :DANZARELAMPAGO => "FailsIfUserNotOriPomPom",
    :DANZAESPECTRAL => "FailsIfUserNotOriSensu",
    :DANZAPSIQUE => "FailsIfUserNotOriBaile",
    :HUESORAPIDO => "TypeIsUserFirstTypePriority",
    :IMPULSOTAURO => "RaiseUserAtkDefSpd1",
    :ESTRELLATO => "LowerTargetSpDef1"
  }
  
  function_codes.each do |move_id, expected_code|
    move = GameData::Move.get(move_id)
    if move.function_code == expected_code
      puts "  ✓ #{move.name}: #{expected_code}"
    else
      puts "  ✗ #{move.name}: Esperado '#{expected_code}', encontrado '#{move.function_code}'"
    end
  end
  
  # Test 3: Verificar clases de movimientos
  puts "\n[TEST 3] Verificando clases de Function Codes..."
  classes_to_check = [
    "Battle::Move::RaiseUserAtkDefSpd1",
    "Battle::Move::RaiseUserAtkDef1Spd2",
    "Battle::Move::FailsIfUserNotOriPau",
    "Battle::Move::FailsIfUserNotOriPomPom",
    "Battle::Move::FailsIfUserNotOriSensu",
    "Battle::Move::FailsIfUserNotOriBaile",
    "Battle::Move::TypeIsUserFirstTypePriority"
  ]
  
  classes_to_check.each do |class_name|
    begin
      klass = Object.const_get(class_name)
      puts "  ✓ #{class_name} existe"
    rescue NameError
      puts "  ✗ #{class_name} NO EXISTE"
    end
  end
  
  # Test 4: Verificar AI Handlers
  puts "\n[TEST 4] Verificando AI Handlers..."
  ai_function_codes = [
    "RaiseUserAtkDefSpd1",
    "RaiseUserAtkDef1Spd2",
    "FailsIfUserNotOriPau",
    "FailsIfUserNotOriPomPom",
    "FailsIfUserNotOriSensu",
    "FailsIfUserNotOriBaile",
    "TypeIsUserFirstTypePriority"
  ]
  
  ai_function_codes.each do |code|
    has_failure = Battle::AI::Handlers.trigger_handler_check(:MoveFailureCheck, code)
    has_score = Battle::AI::Handlers.trigger_handler_check(:MoveEffectScore, code)
    
    status = []
    status << "FailureCheck" if has_failure
    status << "EffectScore" if has_score
    
    if status.any?
      puts "  ✓ #{code}: #{status.join(', ')}"
    else
      puts "  ⚠ #{code}: Sin handlers de IA"
    end
  end
  
  # Test 5: Simulación de batalla básica
  puts "\n[TEST 5] Simulación de batalla (IMPULSOTAURO)..."
  
  begin
    # Crear un Pokémon de prueba
    pkmn = Pokemon.new(:TAUROS, 50)
    pkmn.learn_move(:IMPULSOTAURO)
    
    puts "  ✓ Pokémon creado: #{pkmn.name} Lv.#{pkmn.level}"
    puts "  ✓ Movimiento aprendido: #{pkmn.moves[0].name}"
    puts "  → El movimiento está listo para usarse en batalla"
  rescue => e
    puts "  ✗ Error en simulación: #{e.message}"
  end
  
  # Test 6: Verificar HUESORAPIDO (prioridad)
  puts "\n[TEST 6] Verificando prioridad de HUESORAPIDO..."
  move_data = GameData::Move.get(:HUESORAPIDO)
  if move_data.priority == 1
    puts "  ✓ HUESORAPIDO tiene prioridad +1"
  else
    puts "  ✗ HUESORAPIDO tiene prioridad #{move_data.priority} (esperado: 1)"
  end
  
  # Test 7: Verificar ESTRELLATO (effect chance)
  puts "\n[TEST 7] Verificando EffectChance de ESTRELLATO..."
  move_data = GameData::Move.get(:ESTRELLATO)
  if move_data.effect_chance == 100
    puts "  ✓ ESTRELLATO tiene 100% de probabilidad de efecto"
  else
    puts "  ✗ ESTRELLATO tiene #{move_data.effect_chance}% de probabilidad (esperado: 100%)"
  end
  
  # Resumen final
  puts "\n" + "="*80
  puts "TESTS COMPLETADOS"
  puts "="*80
  puts "\nPara probar en batalla real:"
  puts "1. Ve al Debug Menu (F12 o menú pausa)"
  puts "2. Selecciona 'Battle...' > 'Wild battle'"
  puts "3. Crea un Pokémon con los movimientos personalizados"
  puts "4. Usa los movimientos en batalla para verificar efectos visuales y lógica"
  puts "\nEjemplo rápido:"
  puts "  pbTestBattle(:TAUROS, 50, :ORICORIO_1, 50)"
  puts "="*80
  
  return true
end

def pbTestBattle(species1 = :TAUROS, level1 = 50, species2 = :ORICORIO, level2 = 50)
  # Crear equipo del jugador
  pkmn1 = Pokemon.new(species1, level1)
  pkmn1.learn_move(:IMPULSOTAURO)
  pkmn1.learn_move(:HUESORAPIDO)
  pkmn1.learn_move(:ARANAZOIGNEO)
  pkmn1.learn_move(:ESTRELLATO)
  pkmn1.reset_moves
  
  # Crear enemigo
  pkmn2 = Pokemon.new(species2, level2)
  pkmn2.learn_move(:DANZAFLAMIGERA) if species2 == :ORICORIO || species2 == :ORICORIO_0
  pkmn2.learn_move(:DANZARELAMPAGO) if species2 == :ORICORIO_1
  pkmn2.learn_move(:DANZAESPECTRAL) if species2 == :ORICORIO_2
  pkmn2.learn_move(:DANZAPSIQUE) if species2 == :ORICORIO_3
  pkmn2.learn_move(:DANZAREAL)
  
  # Guardar equipo actual
  old_party = $player.party.clone
  
  # Configurar batalla
  $player.party = [pkmn1]
  
  # Iniciar batalla
  pbWildBattle(species2, level2)
  
  # Restaurar equipo
  $player.party = old_party
end

# Registrar el comando en el menú de debug
module Battle
  class Scene
    alias custom_moves_test_pbDebugMenu pbDebugMenu
    
    def pbDebugMenu
      custom_moves_test_pbDebugMenu
      
      commands = []
      commands.push(_INTL("Test Custom Moves"))
      
      cmd = pbShowCommands(_INTL("Custom Moves Debug"), commands, -1)
      
      case cmd
      when 0  # Test Custom Moves
        pbTestCustomMoves
      end
    end
  end
end

puts "[Custom Moves] Test script loaded. Use: pbTestCustomMoves"
