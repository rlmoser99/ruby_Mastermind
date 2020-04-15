module Display

  def code_colors (number)
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

  def clue_colors (item)
    @clue_backgrounds = {
      "*" => "\e[32;1m\e[47m * \e[0m" " ",
      "?" => "\e[31m\e[47m ? \e[0m" " ",
    }
    @clue_backgrounds[item]
  end

  def show_code (array)
    array.each do | num |
      print code_colors (num)
    end
  end

  def show_clues (exact, same)
    print "  Clues: "
    exact.times {print clue_colors("*")}
    same.times {print clue_colors("?")}
    puts ""
  end

  def instructions
    @instructions_text = <<~HEREDOC


    #{formatting("underline", "How to play Mastermind:")}

    This is a 1-player game against the computer. 
    You can choose to be the code #{formatting("underline", "maker")} or the code #{formatting("underline", "breaker")}.

    There are six different number/color combinations:
    
    #{code_colors("1")}#{code_colors("2")}#{code_colors("3")}#{code_colors("4")}#{code_colors("5")}#{code_colors("6")}
    
    
    The code maker will choose four to create a 'master code'. For example,

    #{code_colors("1")}#{code_colors("3")}#{code_colors("4")}#{code_colors("1")}
    
    As you can see, there can be #{formatting("red", "more then one")} of the same number/color.
    In order to win, the code breaker needs to guess the 'master code' in 12 or less turns.
    
    
    #{formatting("underline", "Clues:")}
    After each guess, there will be up to four clues to help crack the code.
    
    #{clue_colors("*")} This clue means you have 1 correct number in the correct location.
    
    #{clue_colors("?")} This clue means you have 1 correct number, but in the wrong location.
    
    
    #{formatting("underline", "Clue Example:")}
    To continue the example, using the above 'master code' a guess of "1463" would produce 3 clues:
    
    #{code_colors("1")}#{code_colors("4")}#{code_colors("6")}#{code_colors("3")}  Clues: #{clue_colors("*")}#{clue_colors("?")}#{clue_colors("?")}
    
    
    The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location.
    
    #{formatting("underline", "It's time to play!")}
    Would you like to be the code MAKER or code BREAKER?

    Press '1' to be the code MAKER
    Press '2' to be the code BREAKER
    HEREDOC
    @instructions_text
  end

end

# Make different "computer_won" messages depending on the number of guesses

# Make 3 Different "Display" Modules
# 1. instructions 
# 2. game text (divide into human / shared / computer methods) 
# 3. color code/hints

# code_colors - 3
# clue_colors - 3
# show_code - 3
# show_clues - 3

# formatting - 2 
# content - 2 (divide into human / shared / computer methods) 

# instructions - 1