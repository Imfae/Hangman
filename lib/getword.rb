# Class for random word selection
class GetWord
  def self.random_word
    dict = []
    File.readlines('dictionary.txt').each do |i|
      i.chomp!
      dict.push(i) if i.length >= 5 && i.length <= 12
    end
    dict[rand(dict.length)]
  end
end
