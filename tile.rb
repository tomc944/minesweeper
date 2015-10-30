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






class Game



end
