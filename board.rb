require_relative 'tile.rb'
require 'byebug'
class Board
  attr_accessor :grid, :bomb_count

  def initialize(bomb_count = 10)
    @grid = Array.new(9) { Array.new(9) { Tile.new(0)} }
    @bomb_count = bomb_count
    populate_grid
  end

  def populate_grid
    disperse_bombs(@grid, @bomb_count)
    assign_bomb_counts(@grid)
  end

#  private

  def render
    @grid.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      puts
    end
  end

  def disperse_bombs(grid, bomb_count)
    bombs_left = bomb_count

    while bombs_left > 0
      x_pos, y_pos = rand(9), rand(9)

      unless grid[x_pos][y_pos].is_bomb?
        grid[x_pos][y_pos].value = :bomb
        bombs_left -= 1
      end
    end
  end

  def assign_bomb_counts(grid)
    grid.each_with_index do |row, row_i|
      #debugger
      row.each_with_index do |tile, col|
        unless tile.is_bomb?
          grid[row_i][col].value = neighbor_bomb_count([row_i, col])
        end
      end
    end
    grid
  end

  def neighbors(pos)
    neighbors = []
    x_pos = pos[0]
    y_pos = pos[1]
    #debugger
    current_tile = @grid[x_pos][y_pos]

    #loop through some shit
    (-1..1).each do |x|
      (-1..1).each do |y|
        new_x = x_pos + x
        new_y = y_pos + y
        unless (x == 0 && y == 0) || !new_x.between?(0,8) || !new_y.between?(0,8)
          neighbors << {tile: @grid[new_x][new_y], x: new_x, y: new_y}
        end
      end
    end

    neighbors
  end

  def neighbor_bomb_count(pos)
    # debugger
    new_neighbors = neighbors(pos)
    new_neighbors.count { |neighbor| neighbor[:tile].is_bomb? }
  end


end
