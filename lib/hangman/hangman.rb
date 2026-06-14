class Hangman
  WORD_LIST = File.readlines("google-10000-english-no-swears.txt")
                  .map(&:chomp)
                  .select { |w| w.length.between?(5, 12) }
                  .freeze

  MAX_WRONG_GUESSES = 6

  attr_reader :word, :wrong_guesses, :display_word

  def initialize
    @word = WORD_LIST.sample
    @guessed_letters = []
    @wrong_guesses = 0
  end

  def make_guess(letter)
    return nil if @guessed_letters.include?(letter)

    if @word.include?(letter)
      @guessed_letters << letter
      won? ? :win : :correct
    else
      @wrong_guesses += 1
      @wrong_guesses >= MAX_WRONG_GUESSES ? :lose : :incorrect
    end
  end

  def display_word
    @word.chars.map { |c| @guessed_letters.include?(c) ? c : "_" }.join
  end

  private

  def won?
    @word.chars.uniq.all? { |c| @guessed_letters.include?(c) }
  end
end
