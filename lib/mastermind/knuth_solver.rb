require 'set'
require_relative 'mastermind'

class KnuthSolver
  ALL_CODES     = Mastermind::COLORS.keys.repeated_permutation(4).to_a.freeze
  INITIAL_GUESS = ['red', 'red', 'green', 'green'].freeze

  def initialize
    @remaining = Set.new(ALL_CODES)
    @first_guess = true
  end

  def next_guess
    if @first_guess
      @first_guess = false
      return INITIAL_GUESS
    end

    return @remaining.first if @remaining.size <= 2

    best_guess = nil
    best_worst_case = Float::INFINITY

    ALL_CODES.each do |guess|
      freq = Hash.new(0)
      @remaining.each do |candidate|
        feedback = simulate_feedback(candidate, guess).sort
        freq[feedback] += 1
      end
      worst_case = freq.values.max
      if worst_case < best_worst_case || (worst_case == best_worst_case && @remaining.include?(guess))
        best_worst_case = worst_case
        best_guess = guess
      end
    end

    best_guess
  end

  def eliminate(guess, feedback)
    @remaining.keep_if { |candidate| simulate_feedback(candidate, guess).sort == feedback.sort }
  end

  private

  def simulate_feedback(secret, guess)
    secret_remaining = []
    guess_remaining = []
    blacks = 0

    guess.each_with_index do |color, index|
      if color == secret[index]
        blacks += 1
      else
        secret_remaining << secret[index]
        guess_remaining << color
      end
    end

    whites = 0
    guess_remaining.each do |color|
      idx = secret_remaining.index(color)
      if idx
        whites += 1
        secret_remaining.delete_at(idx)
      end
    end

    ['⚫'] * blacks + ['⚪'] * whites
  end
end
