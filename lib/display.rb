# Class for responsive display
class Display
  attr_accessor :progress

  def initialize;  end

  def number_of_lives(lives)
    "\n #{'♥ ' * lives}\n"
  end

  def guess_progress(word, input, letter_is_guessed)
    if letter_is_guessed
      word.split('').each_index { |i| @progress[i] = input if word[i] == input }
    end
    "\n #{@progress.join(' ')}"
  end

  def letters_guessed(letters)
    "\n Letters used: #{letters.join(', ')}"
  end
end
