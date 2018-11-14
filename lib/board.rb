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
    hidden_grid = Marshal.load(Marshal.dump(@grid))
    hidden_grid.each do |sub_arr|
      sub_arr.each_with_index do |pos, i|
        sub_arr[i] = :N if pos == :S
      end
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

b1 = Board.new(2)
# b1.place_random_ships
p b1
b1.place_random_ships
p b1
h = b1.hidden_ships_grid
p h
p b1
