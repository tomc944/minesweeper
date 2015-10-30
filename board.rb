require_relative 'tile.rb'

class Board
  attr_accessor :grid, :bomb_count

  def initialize(bomb_count = 10)
    @grid = populate(bomb_count)
    @bomb_count = bomb_count
  end

  def populate(bomb_count)
    grid = Array.new(9) { Array.new(9) { Tile.new(0)} }
    disperse_bombs(grid, bomb_count)
    assign_bomb_counts(grid)
  end

  private

  def render(grid)

    grid.each do |row|
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
    grid
  end

  def assign_bomb_counts(grid)
    grid.each_with_index do |row, row_i|
      row.each_with_index do |tile, col|
        unless tile.is_bomb?
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
    neighbors(pos).count{ |tile| tile.is_bomb? }
  end


end
