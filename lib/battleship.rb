require_relative "board"
require_relative "player"

class Battleship
  attr_reader :board, :player

  def initialize(length)
    @player = Player.new
    @board = Board.new(length)
    @remaining_misses = @board.size / 2
  end

  def start_game
    @board.place_random_ships
    puts @board.num_ships
    @board.print
  end

  def lose?
    if @remaining_misses <= 0
      puts "you lose"
      return true
    end
    false
  end

  def win?
    if @board.num_ships == 0
      puts "you win"
      return true
    end
    false
  end

  def game_over?
    if win? || lose?
      return true
    end
    false
  end

  def turn
    pos = @player.get_move
    @remaining_misses -= 1 unless @board.attack(pos)
    @board.print
    puts @remaining_misses
  end
end
