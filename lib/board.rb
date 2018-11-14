class Board
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n){ Array.new(n, :N) }
    @size = n * n
  end

  def [](idx_pair)
    @grid[idx_pair[0]][idx_pair[1]]
  end

  def []=(idx_pair, value)
    @grid[idx_pair[0]][idx_pair[1]] = value
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

end
