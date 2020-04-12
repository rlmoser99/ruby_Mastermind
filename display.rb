class Display

  def initialize(name)
    @name = name
  end

  def color_code (number)
    @code_backgrounds = {
      "1" => "\e[44m  1  \e[0m" " ",
      "2" => "\e[42m  2  \e[0m" " ",
      "3" => "\e[45m  3  \e[0m" " ",
      "4" => "\e[30;1m\e[46m  4  \e[0m" " ",
      "5" => "\e[30;1m\e[43m  5  \e[0m" " ",
      "6" => "\e[30;1m\e[41m  6  \e[0m" " "
    }
    @code_backgrounds[number]
  end

  def color_clue (item)
    @clue_backgrounds = {
      "*" => "\e[32;1m\e[47m * \e[0m" " ",
      "?" => "\e[31m\e[47m ? \e[0m" " ",
    }
    @clue_backgrounds[item]
  end

  def clues (exact, same)
    exact.times {print color_clue("*")}
    same.times {print color_clue("?")}
    puts ""
  end

  def formatting (description, string)
    @text_formatting = {
      "underline" => "\e[4;1m#{string}\e[0m",
      "red" => "\e[31;1m#{string}\e[0m",
    }
    @text_formatting[description]  
  end

  def instructions
    @instructions_text = <<~HEREDOC


    #{formatting("underline", "How to play Mastermind:")}

    This is a 1-player game against the computer. 
    You can choose to be the code #{formatting("underline", "maker")} or the code #{formatting("underline", "breaker")}.

    There are six different number/color combinations:
    
    #{color_code("1")}#{color_code("2")}#{color_code("3")}#{color_code("4")}#{color_code("5")}#{color_code("6")}
    
    
    The code maker will choose four to create a 'master code'. For example,

    #{color_code("1")}#{color_code("3")}#{color_code("4")}#{color_code("1")}
    
    As you can see, there can be #{formatting("red", "more then one")} of the same number/color.
    In order to win, the code breaker needs to guess the 'master code' in 12 or less turns.
    
    
    #{formatting("underline", "Clues:")}
    After each guess, there will be up to four clues to help crack the code.
    
    #{color_clue("*")} This clue means you have 1 correct number in the correct location.
    
    #{color_clue("?")} This clue means you have 1 correct number, but in the wrong location.
    
    
    #{formatting("underline", "Clue Example:")}
    To continue the example, using the above 'master code' a guess of "1463" would produce 3 clues:
    
    #{color_code("1")}#{color_code("4")}#{color_code("6")}#{color_code("3")}  Clues: #{color_clue("*")}#{color_clue("?")}#{color_clue("?")}
    
    
    The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location.
    
    #{formatting("underline", "It's time to play!")}
    Would you like to be the code MAKER or code BREAKER?

    Press '1' to be the code MAKER
    Press '2' to be the code BREAKER
    HEREDOC
    @instructions_text
  end

  def content (number = nil, item)
    @prompts = {
      "turn_prompt" => "Turn ##{number}: Type in four numbers (1-6) to guess code, or 'q' to quit game.",
      "last_turn" => "#{formatting("red", "Choose carefully. This is your last chance to win!")}",
      "turn_error" => "#{formatting("red", "Your guess should only be 4 digits between 1-6.")}",
      "clues" => "  Clues: ",
      "won" => "  You broke the code! Congratulations, you win! \n\n",
      "lost" => "#{formatting("red", "Game over. ¯\\_(ツ)_/¯ ")} \n\n",
      "reveal_code" => "Here is the 'master code' that you were trying to break:",
      "end" => "\n\n\nDo you want to play again? Press 'y' for yes or 'n' for no.",
      "answer_error" => "#{formatting("red", "Enter '1' to be the code MAKER or '2' to be the code BREAKER.")}",
      "breaker_start" => "The computer has set the 'master code' and now it's time for you to break the code.\n\n",
      "maker_start" => "Please enter a 4-digit 'master code' for the computer to break.",
      "maker_error" => "#{formatting("red", "Your 'master code' must be 4 digits long, using numbers between 1-6.")}",
      "maker_code" => "is your 'master code'.\n\n",
      "computer_turn" => "Computer Turn ##{number}:"
    }
    @prompts[item]
  end

end
