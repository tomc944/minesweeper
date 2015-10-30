require_relative "board.rb"

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end

  def play
    welcome_user
    until won?
      board.render
      user_move = prompt_input
      process_move(user_move)
    end

    # render board
    # welcome the user
      # new game or reload?
    # loop until game is over
      #prompt user for input, give example (flag/ position)
      #apply input
      #re-render board
    # congratulation or you suck

    # optional
      # save game
      # restart game
    #

  end

  def prompt_input
    puts "Would you like to reveal (r) a tile or flag/unflag (f) a tile?"
    choice = gets.chomp.downcase
    puts "Where would you like to do so? (x,y)"
    position = gets.chomp.split(",")
    {move_type: choice, x: position[0].to_i, y: position[1].to_i}
  end

  def get_tile(x,y)
    @board.grid[x][y]
  end

  def process_move(user_move)
    if user_move[:move_type] == "f"
      get_tile(user_move[:x], user_move[:y]).toggle_flag
    elsif user_move[:move_type] == "r"
      guessed_tile = get_tile(user_move[:x], user_move[:y])
      guessed_tile.reveal
      if guessed_tile.is_bomb?

      else
        reveal_neighbors(user_move[:x], user_move[:y])

      end
    else
      puts "c'mon dude"
    end
  end

  def reveal_neighbors(x, y)
    # queue = [self]
    queue = neighbors([x,y])
    until queue.empty?
       current_tile = queue.shift
    #   return value if current.value == target_value
        unless current_tile.is_bomb?
          current_tile.reveal
    #   queue += children
    # end
  end


  end

  def welcome_user
    puts "Welcome to Minesweeper"
  end

  def won?
    all_tiles = board.grid.flatten
    safe_tiles = all_tiles.count - board.bomb_count


    safe_tiles == all_tiles.count { |tile| tile.revealed }
  end

end
