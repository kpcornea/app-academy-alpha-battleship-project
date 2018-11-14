require "byebug"

class Board
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n){ Array.new(n, :N) }
    @size = n * n
    @length = n
  end

  def [](idx_pair)
    @grid[idx_pair[0]][idx_pair[1]]
  end

  def []=(idx_pair, value)
    @grid[idx_pair[0]][idx_pair[1]] = value
    # calling itself here so that's why have to define explicitly here, but not in additional methods?
    # self[idx_pair] = value
    # self.[](idx_pair) = value
    # pos = self.[](idx_pair)
    # pos = value
  end

  def num_ships
    count = 0
    @grid.each do |sub_arr|
      count += sub_arr.count(:S)
    end
    count
  end

  def attack(idx_pair)
    if self[idx_pair] == :S
      # @grid[idx_pair[0]][idx_pair[1]] = :H
      # self.[]=(idx_pair, :H)
      self[idx_pair] = :H
      puts 'you sunk my battleship!'
      return true
    end
      # @grid[idx_pair[0]][idx_pair[1]] = :X
      # self.[]=(idx_pair, :X)
      self[idx_pair] = :X
      false
  end

  def place_random_ships
    quarter = @size / 4
    i = 0
    # byebug
    while self.num_ships < quarter
      # byebug
      sub_arr = @grid[i]
      sub_arr[rand(0...@length)] = :S
      # byebug
      i += 1
      i = 0 if i == @length
    end
    # i didn't reset i lol
    # @grid.each do |sub_arr|
    #   sub_arr[1..n.sample] = :S
    # end
  end

end

# b1 = Board.new(10)
# b1.place_random_ships
