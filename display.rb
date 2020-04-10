class Display

  def initialize(name)
    @name = name
  end

  def color_code (number)
    @code_backgrounds = {
      "1" => "\e[44m  1  \e[0m",
      "2" => "\e[42m  2  \e[0m",
      "3" => "\e[45m  3  \e[0m",
      "4" => "\e[30;1m\e[46m  4  \e[0m",
      "5" => "\e[30;1m\e[43m  5  \e[0m",
      "6" => "\e[30;1m\e[41m  6  \e[0m"
    }
    @code_backgrounds[number]
  end

  # def color_code (number)
  #   @code_backgrounds = {
  #     "1" => "44"\e[m  1  \e[0m",
  #     "2" => "42",
  #     "3" => "45",
  #     "4" => "30;1m\e[46",
  #     "5" => "30;1m\e[43",
  #     "6" => "30;1m\e[41"
  #   }
  #   return "\e[#{@code_backgrounds[number]}m  #{number}  \e[0m"
  # end

  def color_clue (item)
    @clue_backgrounds = {
      "*" => "32;1m\e[47",
      "?" => "31m\e[47",
    }
    return "\e[#{@clue_backgrounds[item]}m #{item} \e[0m"
    
  end

  def formatting (number, string)
    @text_formatting = {
      "underline" => "4;1",
      "red" => "31;1",
    }
    return "\e[#{@text_formatting[number]}m#{string}\e[0m"
    
  end

  def instructions
    @instructions_text = <<~HEREDOC
    #{formatting("underline", "How to play Mastermind:")}
    There are six different number/color combinations:
    
    #{color_code("1")} #{color_code("2")} #{color_code("3")} #{color_code("4")} #{color_code("5")} #{color_code("6")}
    
    
    The computer will randomly choose four to create a 'master code' for you to break. For example,
    
    #{color_code("1")} #{color_code("3")} #{color_code("4")} #{color_code("1")}
    
    As you can see, there can be #{formatting("red", "more then one")} of the same number/color.
    In order to win, you must guess the 'master code' in 12 or less turns.
    
    #{formatting("underline", "Clues:")}
    After each guess, you will be given up to four clues to help you crack the code.
    
    #{color_clue("*")} This clue means you have 1 correct number in the correct location.
    
    #{color_clue("?")} This clue means you have 1 correct number, but in the wrong location.
    
    
    #{formatting("underline", "Clue Example:")}
    To continue the example, using the above 'master code' a guess of "1463" would produce 3 clues:
    
    #{color_code("1")} #{color_code("4")} #{color_code("6")} #{color_code("3")}  Clues: #{color_clue("*")} #{color_clue("?")} #{color_clue("?")}
    
    
    The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location.
    
    #{formatting("underline", "It's time to play!")}
    The 'master code' has been set and it's your turn to guess the code.
    
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
      "reveal_code" => "Here is the 'master code' that you were trying to break:"
    }
    @prompts[item]
  end

end




