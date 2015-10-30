class Tile

  attr_accessor :revealed, :value, :flagged

  def initialize(value)
    @value = value #either :bomb or " " or adjacent_bombs
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def toggle_flag
    @flagged = !@flagged
  end

end


class Board

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



class Game



end
