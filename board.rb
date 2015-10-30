class Board
  attr_accessor :grid

  def initialize(bombs = 10)
    @grid = populate(bombs)
  end

  def populate(bombs)
    grid = Array.new(9) { Array.new(9) { Tile.new(0)} }
    bombs_left = bombs

    while bombs_left > 0
      x_pos, y_pos = rand(9), rand(9)

      unless grid[x_pos][y_pos].value == :bomb
        grid[x_pos][y_pos].value = :bomb
        bombs_left -= 1
      end
    end


  end

  def neighbors(pos)
    current_tile = @grid[pos[0]][pos[1]]
    #loop through some shit
    #check if valid
    #return array
  end

  def neighbor_bomb_count(pos)
    neighbors(pos)#count bomb values
  end


end
