require_relative 'board'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new(9, 81)
  end

  def play
    @start = Time.now
    while true
      p board
      mode, position = get_user_move
      if mode == :reveal
        board[*position].reveal
      else
        board[*position].flagged = true
      end

      break if over?
    end

    if won?
      puts "You won!"
    else
      puts "You lost!"
    end

  end

  private

  def get_user_move
    while true
      print "Enter [r/f] [row],[col] -> "
      user_input = gets.chomp
      unless valid_input(user_input)
        puts "Invalid input."
        next
      end
      match_data = /\s*([rf])\s*(\d+)\s*,\s*(\d+)\s*/.match(user_input)
      mode = (match_data[1] == 'r') ? :reveal : :flagged
      position = [match_data[2].to_i, match_data[3].to_i]

      unless board.on_board?(position)
        puts "Position off board"
        next
      end

      return mode, position
    end
  end

  def valid_input(input_string)
    /\s*([rf])\s*(\d+)\s*,\s*(\d+)\s*/ =~ input_string
  end

  def over?
    all_tiles = board.grid.flatten

    # check if any bomb is revealed
    return false if all_tiles.any? { |el| el.bomb? && el.revealed? }

    # check if all squares are revealed or flagged
    return true if all_tiles.all? { |el| el.revealed? or el.flagged? }

    false
  end

  def won?
    return false unless over?

    # check if bomb squares are flagged
    board.grid.each do |row|
      row.each do |el|
        if el.bomb?
          return false unless el.flagged?
        end
      end
    end

    true
  end
end

if __FILE__  == $PROGRAM_NAME
  my_game = Game.new
  p my_game.play

end
