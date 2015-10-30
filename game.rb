require_relative "board.rb"

def reload
  load 'game.rb'
  load 'board.rb'
  load 'tile.rb'
end

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end

  def play
    welcome_user
    until won? || lost?
      board.render
      user_move = prompt_input
      process_move(user_move)
    end

    board.render
    puts "You win" if won?
    puts "You lose!"

    # optional
      # save game
      # restart game
    #

  end

  def prompt_input
    puts "Would you like to reveal (r) a tile or flag/unflag (f) a tile?"
    choice = gets.strip.downcase
    puts "Where would you like to do so? (x,y)"
    position = gets.strip.split(",")
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
      unless guessed_tile.is_bomb?
        reveal_neighbors(user_move[:x], user_move[:y])
      end
    else
      puts "c'mon dude"
    end
  end

  def reveal_neighbors(x, y)
    queue = board.neighbors([x,y])
    until queue.empty?
      neighbor = queue.shift
      unless neighbor[:tile].is_bomb? || neighbor[:tile].revealed
        neighbor[:tile].reveal
        queue += board.neighbors([neighbor[:x], neighbor[:y]])
      end
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

  def lost?
    all_tiles = board.grid.flatten
    all_tiles.any?{|tile| tile.is_bomb? && tile.revealed}
  end

end
