class Board
  attr_reader :size

  def initialize(length)
    @grid = Array.new(length) { Array.new(length, :N) }
    @size = length * length
    @length = length
  end

  def [](idx_pair)
    row, col = idx_pair
    @grid[row][col]
  end

  def []=(idx_pair, value)
    row, col = idx_pair
    @grid[row][col] = value
  end

  def num_ships
    @grid.flatten.count { |ele| ele == :S }
  end

  def attack(idx_pair)
    if self[idx_pair] == :S
      self[idx_pair] = :H
      puts "you sunk my battleship!"
      return true
    elsif self[idx_pair] == :H
      puts "you already sunk that one!"
      return true
    elsif self[idx_pair] == :X
      puts "you already missed there!"
      return true
    elsif self[idx_pair] == nil
      puts "that's not even on the map..."
      return true
    end
      self[idx_pair] = :X
      puts "you missed!"
      false
  end

  def place_random_ships
    quarter = @size / 4
    while self.num_ships < quarter
      rand_row = rand(0...@length)
      rand_col = rand(0...@length)
      self[[rand_row, rand_col]] = :S
    end
  end

  def hidden_ships_grid
    @grid.map do |sub_arr|
      sub_arr.map do |ele|
        if ele == :S
          :N
        else
          ele
        end
      end
    end
  end

  def self.print_grid(grid)
    grid.each do |sub_arr|
      puts sub_arr.join(" ")
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end
end
