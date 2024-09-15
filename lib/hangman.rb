require_relative 'input'
require_relative 'display'
require_relative 'getword'
require_relative 'messages'
require 'yaml'

# Class for the game Hangman
class Hangman
  include Messages

  def initialize(lives, word = '', tried = [], progress = [])
    @word = word
    @input = ''
    @lives = lives
    @userinput = UserInput.new
    @display = Display.new
    @tried = tried
    @game_progress = progress
  end

  def assemble_game
    set_variables
    loop do
      assemble_display
      break if @lives.zero? || word_guessed? || @input == 'save'

      @input = @userinput.prompt_input
      letter_guessed?
      reduce_lives
    end
    if @input == 'save'
      save_game(@userinput.prompt_filename)
    else
      puts result_message(word_guessed?, @word)
    end
  end

  def self.load_game(filename)
    data = YAML.load_file("saved_games/#{filename}.yml")
    new(data[:lives], data[:word], data[:tried], data[:progress])
  end

  private

  # Initialize variables according to whether the game is a new game or a saved game
  def set_variables
    @userinput.inputs_tried = @tried
    @word = GetWord.random_word if @word.empty?
    @game_progress = Array.new(@word.length) { '_' } if @game_progress.empty?
    @display.progress = @game_progress
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
    @lives -= 1 unless letter_guessed? || @input == 'save'
  end

  def word_guessed?
    @display.progress.include?('_') ? false : true
  end

  def save_game(filename)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    File.open("saved_games/#{filename}.yml", 'w') do |file|
      file.puts YAML.dump({
        lives: @lives,
        word: @word,
        tried: @tried,
        progress: @game_progress
      })
    end
  end
end

