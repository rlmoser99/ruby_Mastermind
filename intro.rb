module Intro

  def instructions
    puts ""
    puts "How to play Mastermind:".underline
    puts "There are six different number/color combinations:"
    puts ""
    self.display(["1", "2", "3", "4", "5", "6"])
    puts ""
    puts ""
    puts ""
    puts "The computer will randomly choose four to create a 'master code' for you to break. For example,"
    puts ""
    self.display(["1", "3", "4", "1"])
    puts ""
    puts ""
    puts ""
    puts "As you can see, there can be more then one of the same number/color.".red
    puts "In order to win, you must guess the 'master code' in 12 or less turns."
    puts ""
    puts "Clues:".underline
    puts "After each guess, you will be given up to four clues to help you crack the code."
    puts ""
    print " * ".bg_gray.green
    print " "
    puts "This clue means you have 1 correct number in the correct location."
    puts ""
    print " ? ".bg_gray.red
    print " "
    puts "This clue means you have 1 correct number, but in the wrong location."
    puts ""
    puts ""
    puts "Clue Example:".underline
    puts ""
    puts "To continue the example, using the above 'master code' a guess of"
    puts ""
    self.display(["1", "2", "3", "4"])
    print " would produce 3 clues: "
    print " * ".bg_gray.green
    print " "
    print " ? ".bg_gray.red
    print " "
    print " ? ".bg_gray.red
    puts ""
    puts ""
    puts ""
    puts "The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location."
    puts ""
    puts "It's time to play!".underline
    puts "The 'master code' has been set and it's your turn to guess the code."
    puts ""
    puts ""
  end
end