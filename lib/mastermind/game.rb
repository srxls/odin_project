require_relative 'mastermind'
require_relative 'knuth_solver'

class Game
  def play
    puts "Welcome to Mastermind!"
    puts "Available colors: #{Mastermind::COLORS.keys.join(', ')}"
    loop do
      puts "Would you like to be the codebreaker (1) or the codemaster (2)?"
      case gets.chomp.downcase
      when '1', 'codebreaker' then return play_as_codebreaker
      when '2', 'codemaster'  then return play_as_codemaster
      else puts "Invalid choice. Please enter 1 or 2."
      end
    end
  end

  private

  def play_as_codebreaker
    game = Mastermind.new
    puts "I've set a secret code. You have #{game.max_attempts} attempts to guess it."

    while game.attempts < game.max_attempts
      print "Guess #{game.attempts + 1}: "
      guess = gets.downcase.chomp.split
      unless Mastermind.valid_guess?(guess)
        puts "Invalid. Enter 4 colors from: #{Mastermind::COLORS.keys.join(', ')}"
        next
      end

      result = game.make_guess(guess)
      case result
      when :win
        puts "You cracked it! The code was: #{format_code(game.secret_code)}"
        return
      when :lose
        puts "Out of attempts! The code was: #{format_code(game.secret_code)}"
        return
      else
        puts "Your guess: #{format_code(guess)} | Feedback: #{result.join(' ')}"
      end
    end
  end

  def play_as_codemaster
    puts "Think of a secret 4-color code!"
    puts "Enter it now (it won't be shown again): "
    secret = gets.downcase.chomp.split

    unless Mastermind.valid_guess?(secret)
      puts "Invalid code. Enter 4 colors from: #{Mastermind::COLORS.keys.join(', ')}"
      return play_as_codemaster
    end

    game = Mastermind.new(secret_code: secret)
    solver = KnuthSolver.new
    puts "Got it. Now I'll try to guess your code in #{game.max_attempts} attempts."

    while game.attempts < game.max_attempts
      guess = solver.next_guess
      puts "My guess #{game.attempts + 1}: #{format_code(guess)}"

      result = game.make_guess(guess)
      case result
      when :win
        puts "I cracked your code in #{game.attempts} attempts!"
        return
      when :lose
        puts "I couldn't crack it. Your code was: #{format_code(secret)}"
        return
      else
        puts "Feedback: #{result.join(' ')}"
        solver.eliminate(guess, result)
      end
    end
  end

  def format_code(code)
    code.map { |color| Mastermind::COLORS[color] }.join(' ')
  end
end
