class Board
  attr_reader :size

  def initialize(length)
    @grid = Array.new(length){ Array.new(length, :N) }
    @size = length * length
    @length = length
  end

  def [](idx_pair)
    @grid[idx_pair[0]][idx_pair[1]]
  end

  def []=(idx_pair, value)
    @grid[idx_pair[0]][idx_pair[1]] = value
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
      self[idx_pair] = :H
      puts 'you sunk my battleship!'
      return true
    end
      self[idx_pair] = :X
      false
  end

  def place_random_ships
    quarter = @size / 4
    i = 0
    while self.num_ships < quarter
      sub_arr = @grid[i]
      sub_arr[rand(0...@length)] = :S
      i += 1
      i = 0 if i == @length
    end
  end

  def hidden_ships_grid
    hidden_grid = []

    @grid.each do |sub_arr|
      new_sub_arr = []

      sub_arr.each do |pos|
        if pos == :X || pos == :N
          new_sub_arr << pos
        else
          new_sub_arr << :N
        end
      end

      hidden_grid << new_sub_arr
    end

    hidden_grid
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
