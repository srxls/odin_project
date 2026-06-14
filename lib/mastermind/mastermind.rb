class Mastermind
  COLORS = {
    'red' => '🔴', 'green' => '🟢', 'blue' => '🔵',
    'yellow' => '🟡', 'purple' => '🟣', 'orange' => '🟠'
  }.freeze 

  attr_reader :secret_code, :attempts, :max_attempts

  def initialize(secret_code: nil)
    @secret_code = secret_code || generate_secret_code
    @attempts = 0
    @max_attempts = 12
  end

  def make_guess(guess)
    @attempts += 1
    return :win if guess == secret_code
    return :lose if attempts == max_attempts

    generate_feedback(guess)
  end

  def self.valid_guess?(guess)
    guess.length == 4 && guess.all? { |color| COLORS.key?(color) }
  end

  private

  def generate_feedback(guess)
    secret_remaining = []
    guess_remaining = []
    blacks = 0

    guess.each_with_index do |color, index|
      if color == secret_code[index]
        blacks += 1
      else
        secret_remaining << secret_code[index]
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

    (['⚫'] * blacks + ['⚪'] * whites).shuffle
  end

  def generate_secret_code
    Array.new(4) { COLORS.keys.sample }
  end

end
