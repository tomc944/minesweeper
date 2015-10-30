require_relative "board.rb"

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
  end

  def play
    board.render
    welcome_user
    until won?
      user_move = prompt_input
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
    puts "Would you like to reveal (r) a tile or flag (f) a tile?"
    choice = gets.chomp
    
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
