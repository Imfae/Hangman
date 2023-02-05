require_relative 'hangman'
require_relative 'messages'
include Messages

# Class for consolidating new and saved games
class Game

  def self.play
    loop do
      puts starting_message
      game_type_input
      if @input == 's'
        saved_game_input
        old_game = Hangman.load_game(@filename)
        old_game.assemble_game
      else
        new_game = Hangman.new(7)
        new_game.assemble_game
      end
      puts closing_message
      play_again? ? redo : break
    end
  end

  private_class_method def self.game_type_input
    @input = gets.chomp.downcase[0]
    raise "\n Please enter 'n' or 's'" unless @input == 'n' || @input == 's'
  rescue StandardError => e
    puts e
    retry
  end

  def self.saved_game_input
    puts "\n Saved games stored:"
    Dir.each_child('saved_games') do |file|
      puts " #{file.delete('.yml')}"
    end
    puts "\n Enter the name of a saved game to resume:"
    @filename = gets.chomp
    unless File.exist?("saved_games/#{@filename}.yml")
      puts "\n No file with this name exists."
      saved_game_input
    end
  end

  private_class_method def self.play_again?
    play_again = gets.chomp.downcase
    if play_again.include?('y')
      true
    elsif play_again.include?('n')
      false
    else
      puts "\nPlease enter 'y' or 'n'."
      play_again?
    end
  end
end

Game.play
