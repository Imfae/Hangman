module Messages
  def starting_message
    "\n Welcome to the game of Hangman!"
  end

  def result_message(win, word)
    if win
      "\n Congratulations! You've discovered the computer's secret word!"
    else
      "\n Ouch, you lost! The computer's secret word is #{word.upcase}."
    end
  end

  
end