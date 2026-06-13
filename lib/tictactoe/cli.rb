require_relative "tictactoe"
require_relative "player"

def ttt_cli
  puts "Welcome to Tic Tac Toe!"
  puts "Player 1, please enter your name:"
  player1_name = gets.chomp
  puts "Player 2, please enter your name:"
  player2_name = gets.chomp
  game = TicTacToe.new(player1_name, player2_name)
  game.play
end

ttt_cli
