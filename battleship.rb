class Board
  INITIAL_VALUE = " "
  attr_reader :squres
  def initialize
    @squres = {}
    reset
  end

  def reset
    (1..5).each do |x|
      (1..5).each do |y|
        @squres[[x, y]] = INITIAL_VALUE
      end
    end
  end

  def display
    puts "    1   2   3   4   5  "
    puts "  +---+---+---+---+---+"
    puts "1 | #{@squres[[1,1]]} | #{@squres[[2,1]]} | #{@squres[[3,1]]} | #{@squres[[4,1]]} | #{@squres[[5,1]]} |"
    puts "  +---+---+---+---+---+"
    puts "2 | #{@squres[[1,2]]} | #{@squres[[2,2]]} | #{@squres[[3,2]]} | #{@squres[[4,2]]} | #{@squres[[5,2]]} |"
    puts "  +---+---+---+---+---+"
    puts "3 | #{@squres[[1,3]]} | #{@squres[[2,3]]} | #{@squres[[3,3]]} | #{@squres[[4,3]]} | #{@squres[[5,3]]} |"
    puts "  +---+---+---+---+---+"
    puts "4 | #{@squres[[1,4]]} | #{@squres[[2,4]]} | #{@squres[[3,4]]} | #{@squres[[4,4]]} | #{@squres[[5,4]]} |"
    puts "  +---+---+---+---+---+"
    puts "5 | #{@squres[[1,5]]} | #{@squres[[2,5]]} | #{@squres[[3,5]]} | #{@squres[[4,5]]} | #{@squres[[5,5]]} |"
    puts "  +---+---+---+---+---+"
  end
end

class Ship
  attr_accessor :life
  def initialize(life)
    @life = life
  end

  def to_s
    " "
  end

  def sunk
    if @life == 0
      @life = 'sunk'
    end
  end
end

class Player
  attr_accessor :name, :destroyer, :cruiser, :battleship, :board
  def initialize
    @board = Board.new
    @destroyer = Ship.new(1)
    @cruiser = Ship.new(2)
    @battleship = Ship.new(3)
  end
  
  def computer_name
    @name = ['R2D2', 'BB-8', 'C3P0', 'T-800'].sample
  end

  def human_name
    name = nil
    loop do
      puts 'Please enter your name.'
      name = gets.chomp
      break unless name.empty?
      puts 'You did not enter anything, it\'s empty.' 
    end
    @name = name
  end

  def set_ship
    set_destroyer
    set_cruiser
    set_battleship
  end

  def count_ship
    @cruiser.life = board.squres.values.count(@cruiser)
    @cruiser.sunk
    @destroyer.life = board.squres.values.count(@destroyer)
    @destroyer.sunk
    @battleship.life = board.squres.values.count(@battleship)
    @battleship.sunk
  end

  def lost_all_ships?
    if @cruiser.life == 'sunk' && @destroyer.life == 'sunk' && @battleship.life == 'sunk'
      true
    end
  end

  def correct_board?
    all_ships = board.squres.values
    if all_ships.count(@destroyer) == 1 && all_ships.count(@cruiser) == 2 && all_ships.count(@battleship) == 3
      return true
    end
  end

  def valid_target?(target)
    if board.squres[target] == Board::INITIAL_VALUE || board.squres[target].class == Ship
      return true
    end
  end

  private
  def set_destroyer
    destroyer_position = empty_squres.keys.sample
    board.squres[destroyer_position] = @destroyer
  end

  def set_cruiser
    # There will be 2 same cruiser objects on the board
    # The first position will be randomly picked, the 2nd will one of the 4 position next to the 1st. 
    position = empty_squres.keys.sample
    board.squres[position] = @cruiser
    board.squres[pick_position2(@cruiser)] = @cruiser
  end

  def set_battleship
    # There will be 3 same battleship objects on the board.
    # The first position will be picked randomly.
    # The second will be one of the 4 position near it.
    # The third will be the the one next to the second with the same x or y value with the first and the second
    position = empty_squres.keys.sample
    board.squres[position] = @battleship
    board.squres[pick_position2(@battleship)] = @battleship
    board.squres[pick_position3(@battleship)] = @battleship
  end

  def empty_squres
    board.squres.reject { |_ , v| v != Board::INITIAL_VALUE}
  end

  def pick_position2(ship)
    position = board.squres.key(ship)
    possible_positions2 = []
    empty_squres.keys.each do |squre|
      if squre[0] == position[0] - 1 && squre[1] == position[1] ||
        squre[0] == position[0] + 1 && squre[1] == position[1] ||
        squre[0] == position[0] && squre[1] == position[1] - 1 ||
        squre[0] == position[0] && squre[1] == position[1] + 1
        possible_positions2 << squre
      end
    end
    position2 = possible_positions2.sample
    position2
  end

  def pick_position3(ship)
    position3 = nil
    positions = []
    board.squres.each { |key, value| positions << key if value == ship }
    empty_squres.keys.each do |squre|
      if squre[0] == positions[0][0] && squre[0] == positions[1][0] && squre[1] == positions[0][1] + 1
        position3 = squre
      elsif squre[0] == positions[0][0] && squre[0] == positions[1][0] && squre[1] == positions[0][1] -1
        position3 = squre
      elsif squre[1] == positions[0][1] && squre[1] == positions[1][1] && squre[0] == positions[0][0] + 1
        position3 = squre
      elsif squre[1] == positions[0][1] && squre[1] == positions[1][1] && squre[0] == positions[0][0] - 1
        position3 = squre
      end
    end
    position3
  end
end

class Game
  HIT = "*"
  MISS = "/"
  attr_accessor :computer, :human
  def initialize
    @computer = Player.new
    @human = Player.new
  end

  def play
    set_name
    loop do
      setup
      break if @human.correct_board? && @computer.correct_board?
      redeploy
    end
    display_board
    loop do
      player_hit
      update_game
      display_board
      break if someone_won?
      computer_hit
      update_game
      display_board
      break if someone_won?
    end
    winner
  end

  private
  def set_name
    @computer.computer_name
    @human.human_name
  end
  
  def setup
    @human.set_ship
    @computer.set_ship
  end

  def display_board
    system 'clear'
    puts "This is #{@computer.name}'s board."
    @computer.board.display
    puts "Destroyer: #{@computer.destroyer.life} Cruiser: #{@computer.cruiser.life} Battleship: #{@computer.battleship.life}"
    puts " "
    puts "This is #{@human.name}'s board."
    @human.board.display
    puts "Destroyer: #{@human.destroyer.life} Cruiser: #{@human.cruiser.life} Battleship: #{@human.battleship.life}"
  end

  def hit?(board, target)
    if board.squres[target] != Board::INITIAL_VALUE
      true
    else
      false
    end
  end

  def computer_hit
    squres = @human.board.squres.dup
    possible_targets = squres.keep_if { |_, v| v != HIT && v != MISS }
    target = possible_targets.keys.sample
    if hit?(@human.board, target)
      @human.board.squres[target] = HIT
    else
      @human.board.squres[target] = MISS
    end
  end

  def target_validation(input)
    array = transform_command(input)
    if (1..5).include?(array[0]) && (1..5).include?(array[1]) &&
      @computer.valid_target?(array)
      true
    else
      false
    end
  end

  def transform_command(input)
    array = input.chars
    array.delete(" ")
    array.map!(&:to_i)
    array
  end

  def player_hit
    target = nil
    loop do
      puts 'Please enter your target coordination like (4 4).'
      target = gets.chomp
      break if target_validation(target)
      puts 'You did not enter an valide target or the target has already been hitted.' 
    end
    command = transform_command(target)
    if hit?(@computer.board, command)
      @computer.board.squres[command] = HIT
    else
      @computer.board.squres[command] = MISS
    end
  end

  def update_game
    @human.count_ship
    @computer.count_ship
  end

  def someone_won?
    @human.lost_all_ships? || @computer.lost_all_ships?
  end

  def winner
    if @computer.lost_all_ships?
      puts "#{human.name} is the winner."
    elsif @human.lost_all_ships?
      puts "#{computer.name} is the winner."
    end
  end

  def redeploy
    @human.board.reset
    @computer.board.rest
  end
end

game = Game.new
game.play