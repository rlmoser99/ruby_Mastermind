class Game

  def start
    @master_code = Code.new
    puts ""
    puts "Instructions:".underline
    puts "Mastermind has six different number/color combinations:"
    puts ""
    self.reveal(["1", "2", "3", "4", "5", "6"])
    puts ""
    puts ""
    puts ""
    puts "The computer will randomly choose four to create a 'master code' for you to break. For example,"
    puts ""
    self.reveal(["1", "3", "4", "1"])
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
    self.reveal(["1", "2", "3", "4"])
    print " would produce 3 clues: "
    print " * ".bg_gray.green
    print " "
    print " ? ".bg_gray.red
    print " "
    print " ? ".bg_gray.red
    puts ""
    puts ""
    puts "The guess had 1 correct number in the correct location and 2 correct numbers in a wrong location."
    puts ""
    puts "Are you ready to PLAY???"
    puts ""
    puts ""
    puts ""
    puts ""
    puts ""
    puts ""
    puts ""
  end

  def show
    puts "TEMPORARILY REVEALED MASTER CODE:"
    self.reveal(@master_code.numbers)
    puts ""
  end 
  
  def turn
    turn = 1
    12.times do
      puts "Turn ##{turn}: Type in four numbers (1-6) to guess code"
      puts "Think carefully. This is your last turn to win!".red if turn == 12
      turn += 1
      loop do
        @guess = gets.chomp
        break if @guess.match(/[1-6][1-6][1-6][1-6]/) && @guess.length == 4
        puts "Your guess should only be 4 digits between 1-6.".red
      end
      self.reveal(@guess.split(//))
      break if solved?(@master_code.numbers, @guess.split(//))
      self.compare(@guess.split(//))
    end
    if solved?(@master_code.numbers, @guess.split(//))
      puts "  You broke the code! Congratulations, you win!"
    else
      puts "Game over. You ran out of turns. ¯\\_(ツ)_/¯ ".red
      puts "Here is the code that you were trying to break:"
      self.reveal(@master_code.numbers)
      puts ""
    end
  end

  def compare (guess)
    temp_master = []
    @master_code.numbers.each { |num| temp_master << num }
    print "  Clues: "
    self.exact_matches(temp_master, guess)
    self.right_numbers(temp_master, guess)
    puts ""
  end

  def exact_matches(master, guess)
    index = 0
    4.times do
      if master[index] == guess[index]
        print " * ".bg_gray.green
        print " "
        master[index] = "*"
        guess[index]  = "*"
      end
      index += 1
    end
  end

  def right_numbers(master, guess)
    i = 0
    4.times do
      if guess[i] != "*" && master.include?(guess[i])
        print " ? ".bg_gray.red
        print " "
        delete = master.find_index(guess[i])
        master[delete] = "?"
        guess[i]  = "?"
      end
      i += 1
    end
  end

  def solved? (master, guess)
    game_over = false
    if master[0] == guess[0] && master[1] == guess[1] && master[2] == guess[2] && master[3] == guess[3]
      game_over = true
    end
    game_over
  end

  def reveal (array)
    array.each do | num |
      print "  #{num}  ".bg_blue if num == "1"
      print "  #{num}  ".bg_green if num == "2"
      print "  #{num}  ".bg_magenta if num == "3"
      print "  #{num}  ".bg_cyan.black.bold if num == "4"
      print "  #{num}  ".bg_brown.black.bold if num == "5"
      print "  #{num}  ".bg_red.black.bold if num == "6"
      print " "
    end
  end

  def play
    self.start
    # Temporary reveal master code, to trouble-shoot clues
    self.show
    self.turn
  end

end

# Put code examples on same line?
# Clarify one clue per number
# Where to put instructions 
# Prompt user if they want instructions
# Prompt user if they want clue example
# Put game.show for in CODE class
# Put 12-turn logic in play method
# Clean up code for solved?
# Remove end game logic from turn