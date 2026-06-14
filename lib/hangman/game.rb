require_relative "hangman"

class Game
  def play
    puts "Welcome to Hangman!"
    puts "You have #{Hangman::MAX_WRONG_GUESSES} attempts to guess the word."
    game = Hangman.new
    loop do
      puts "Current word: #{game.display_word}"
      print "Enter a letter to guess: "
      letter = gets.chomp.downcase

      unless letter.length != 1 || !letter.match?(/[a-z]/)
        puts "Invalid input. Please enter a single letter."
        next
      end

      result = game.make_guess(letter)

      if result.nil?
        puts "You've already guessed '#{letter}'. Try a different letter."
        next
      end

      case result
      when :correct
        puts "Good guess! The letter '#{letter}' is in the word. You have #{Hangman::MAX_WRONG_GUESSES - game.wrong_guesses} attempts left."
      when :win
        puts "Congratulations! You've guessed the word: #{game.word}"
        return
      when :lose
        puts "Sorry, you've run out of attempts. The word was: #{game.word}"
        return
      when :incorrect
        puts "Incorrect guess. You have #{Hangman::MAX_WRONG_GUESSES - game.wrong_guesses} attempts left."
      end
    end
  end
end
