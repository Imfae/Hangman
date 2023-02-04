class UserInput
  attr_reader :inputs_tried

  def initialize
    @inputs_tried = []
  end

  def prompt_input
    puts "\n Please enter a letter:"
    begin
      @input = gets.chomp.downcase
      raise "\n That is NOT a letter!" if @input.match(/[a-z]/).instance_of?(NilClass)
      raise "\n Please enter a single letter." unless @input.length == 1
      raise "\n You've entered this letter already. Try another one!" if @inputs_tried.include?(@input)
    rescue StandardError => e
      puts e
      retry
    end
    @inputs_tried.push(@input)
    return @input
  end 
end
# a = UserInput.new
# a.prompt_input
