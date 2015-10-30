class Tile

  attr_accessor :revealed, :value, :flagged

  def initialize(value)
    @value = value #either :bomb or " " or adjacent_bombs
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true unless @flagged
  end

  def toggle_flag
    @flagged = !@flagged unless @revealed
  end

  def to_s

    return "F" if flagged
    return "_" if @revealed == false
    return "*" if value == :bomb

    return value
  end

  def is_bomb?
    @value == :bomb
  end

end
