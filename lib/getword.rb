# Class for random word selection

class GetWord
  def initialize
  end

  def self.random_word
    dict = []
    File.readlines('dictionary.txt').each do |i|
      dict.push(i.chomp) if i.length >= 5 && i.length <= 12
    end
    dict[rand(dict.length)]
  end
end
# GetWord.random_word
