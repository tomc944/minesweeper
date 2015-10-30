require_relative 'tile.rb'

class Board
  attr_accessor :grid

  def initialize(bombs = 10)
    @grid = populate(bombs)
  end

  def populate(bombs)
    grid = Array.new(9) { Array.new(9) { Tile.new(0)} }
    disperse_bombs(grid, bombs)
    assign_bomb_counts(grid)
  end

  private

  def disperse_bombs(grid, bombs)
    bombs_left = bombs

    while bombs_left > 0
      x_pos, y_pos = rand(9), rand(9)

      unless grid[x_pos][y_pos].value == :bomb
        grid[x_pos][y_pos].value = :bomb
        bombs_left -= 1
      end
    end
    grid
  end

  def assign_bomb_counts(grid)
    grid.each_with_index do |row, row_i|
      row.each_with_index do |tile, col|
        unless tile.value == :bomb
          tile.value = neighbor_bomb_count(row_i, col)
        end
      end
    end
    grid
  end

  def neighbors(pos)
    neighbors = []
    x_pos = pos[0]
    y_pos = pos[1]

    current_tile = @grid[x_pos][y_pos]

    #loop through some shit
    (-1..1).each do |x|
      (-1..1).each do |y|
        new_x = x_pos + x
        new_y = y_pos + y
        unless (x == 0 && y == 0) || new_x.between?(0,8) || new_y.between?(0,8)
          neighbors << @grid[new_x][new_y]
        end
      end
    end

    neighbors
  end

  def neighbor_bomb_count(pos)
    neighbors(pos).count{ |tile| tile.value == :bomb }
  end


end
