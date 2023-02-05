# Class for getting user input
class UserInput
  attr_accessor :inputs_tried

  def initialize
    @inputs_tried = []
  end

  def prompt_input
    puts "\n Please enter a letter or 'save' to save your progress:"
    begin
      @input = gets.chomp.downcase
      error_responses
    rescue StandardError => e
      puts e
      retry
    end
    @inputs_tried.push(@input) unless @input == 'save'
    @input
  end

  def prompt_filename
    puts "\n Please enter file name for your saved game:"
    filename = gets.chomp
    if File.exist?("saved_games/#{filename}.yml")
      puts "\n A file with this name already exists. Do you wish to overwrite it? (y/n)\n (If yes, your previously saved game will be lost.)"
      begin
        overwrite = gets.chomp.downcase
        raise "\n Please enter 'y' or 'n'" unless overwrite[0] == 'y' || overwrite[0] == 'n'
      rescue StandardError => e
        puts e
        retry
      end
      if overwrite[0] == 'n'
        prompt_filename
      end
    end
    filename
  end

  def error_responses
    raise "\n That is NOT a letter!" if @input.match(/[a-z]/).instance_of?(NilClass)
    raise "\n Please enter a single letter." unless @input.length == 1 || @input == 'save'
    raise "\n You've entered this letter already. Try another one!" if @inputs_tried.include?(@input)
  end
end
