# Module for messages in-game
module Messages
  def starting_message
    "\n Welcome to the game of Hangman!\n Press 'n' for new game and 's' for saved game."
  end

  def result_message(win, word)
    if win
      "\n Congratulations! You've discovered the computer's secret word!"
    else
      "\n Ouch, you lost! The computer's secret word is #{word.upcase}."
    end
  end

  def closing_message
    "\n Would you like to play again? (y/n)"
  end
end
