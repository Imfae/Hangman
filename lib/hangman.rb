require_relative 'input'
require_relative 'display'
require_relative 'getword'
require_relative 'messages'
class Hangman
  include Messages

  def initialize
    @word = ''
    @input = ''
    @lives = 7
    @userinput = UserInput.new
    @display = Display.new
  end

  def gameplay
    @word = GetWord.random_word
    @display.progress = Array.new(@word.length) { '_ ' }
    loop do
      assemble_display
      break if @lives.zero? || word_guessed?

      @input = @userinput.prompt_input
      letter_guessed?
      reduce_lives
    end
    puts result_message(word_guessed?, @word)
  end

  def assemble_display
    puts @display.number_of_lives(@lives)
    puts @display.guess_progress(@word, @input, letter_guessed?)
    puts @display.letters_guessed(@userinput.inputs_tried)
  end

  def letter_guessed?
    @word.split('').include?(@input) ? true : false
  end

  def reduce_lives
    @lives -= 1 unless letter_guessed?
  end

  def word_guessed?
    @display.progress.include?('_ ') ? false : true
  end
end

game = Hangman.new
game.gameplay
