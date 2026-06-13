require_relative "player"

class TicTacToe
  def initialize(player1, player2)
    @player1 = Player.new(player1, "X")
    @player2 = Player.new(player2, "O")
    @board = Array.new(3) { Array.new(3, " ") }
    @current_player = @player1
  end

  attr_accessor :current_player, :board

  def make_move(move)
    row, col = move
    if valid_move?(row, col)
      @board[row][col] = @current_player.symbol
      switch_player
    else
      puts "Invalid move. Try again."
    end
  end

  def display_board
    @board.each do |row|
      puts row.join(" | ")
      puts "---------"
    end
  end

  def valid_move?(row, col)
    row.between?(0, 2) && col.between?(0, 2) && @board[row][col] == " "
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def winner?
    @board.each do |row|
      return row[0] if row.uniq.length == 1 && row[0] != " "
    end

    @board.transpose.each do |col|
      return col[0] if col.uniq.length == 1 && col[0] != " "
    end

    diag1 = [0, 1, 2].map { |i| @board[i][i] }
    return diag1[0] if diag1.uniq.length == 1 && diag1[0] != " "

    diag2 = [0, 1, 2].map { |i| @board[i][2 - i] }
    return diag2[0] if diag2.uniq.length == 1 && diag2[0] != " "

    nil
  end

  def game_over?
    winner? || @board.flatten.none? { |cell| cell == " " }
  end

  def reset_game
    @board = Array.new(3) { Array.new(3, " ") }
    @current_player = @player1
  end

  def play
    until game_over?
      display_board
      puts "#{@current_player.name}, it's your turn. Enter your move (row col, 1-3):"
      begin
        parts = gets.chomp.split(/[\s,]+/)
        raise ArgumentError unless parts.length == 2

        move = parts.map { |s| Integer(s) - 1 }
      rescue ArgumentError
        puts "Invalid input. Please enter two numbers separated by a space or comma (e.g. 1 2 or 1,2)."
        retry
      end
      make_move(move)
    end
    display_board
    winning_symbol = winner?
    if winning_symbol
      winner = [@player1, @player2].find { |p| p.symbol == winning_symbol }
      puts "#{winner.name} wins!"
    else
      puts "It's a draw!"
    end

    puts "Do you want to play again? (y)"
    play_again = gets.chomp.downcase
    if play_again == "y"
      reset_game
      play
    else
      puts "Thanks for playing!"
    end
  end
end
