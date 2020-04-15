module TextContent

  def formatting (description, string)
     {
      "underline" => "\e[4;1m#{string}\e[0m",
      "red" => "\e[31;1m#{string}\e[0m",
    }[description]  
  end

  def game_message (message)
    {
      "human_won" => "  You broke the code! Congratulations, you win! \n\n",
      "display_code" => "Here is the 'master code' that you were trying to break:",
      "computer_won" => "\nYou couldn't out-smart the computer, it broke the code.",
      "computer_lost" => "\nYou out-smarted the computer & won the game!",
      "repeat_prompt" => "\n\nDo you want to play again? Press 'y' for yes (or any other key for no).",
      "thanks" => "Thank you for playing Mastermind!"
    }[message]
  end

  def turn_message (number = nil, message)
    {
      "guess_prompt" => "Turn ##{number}: Type in four numbers (1-6) to guess code, or 'q' to quit game.",
      "computer" => "\nComputer Turn ##{number}:",
      "breaker_start" => "The computer has set the 'master code' and now it's time for you to break the code.\n\n",
      "code_prompt" => "Please enter a 4-digit 'master code' for the computer to break.",
      "code_displayed" => "is your 'master code'.\n",
    }[message]
  end
  
  def warning_message (message)
    {
      "answer_error" => "#{formatting("red", "Enter '1' to be the code MAKER or '2' to be the code BREAKER.")}",
      "turn_error" => "#{formatting("red", "Your guess should only be 4 digits between 1-6.")}",
      "last_turn" => "#{formatting("red", "Choose carefully. This is your last chance to win!")}",
      "code_error" => "#{formatting("red", "Your 'master code' must be 4 digits long, using numbers between 1-6.")}",
      "game_over" => "#{formatting("red", "Game over. That was a hard code to break! ¯\\_(ツ)_/¯ ")} \n\n"
    }[message]
  end
end