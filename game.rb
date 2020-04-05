class Game

  def start
    puts ""
    puts "Let's play MASTERMIND!"
    @master_code = Code.new
    @options = ["1", "2", "3", "4", "5", "6"]
    puts "This game is played with the six number/color combinations:"
    self.reveal(@options)
    puts ""
    puts ""
    puts "The computer will randomly choose 4 to create a code for you to break. For example,"
    self.reveal(["5", "6", "2", "4"])
    puts ""
    puts ""
    puts "There can be more then one of the same number/color. For example,".red
    self.reveal(["2", "1", "3", "2"])
    puts ""
    puts ""
    puts "The computer may give you a clue to help you solve for each ONE EACH!!!"
    print " * ".bg_gray.green
    print " "
    puts "This clue means you have 1 correct number in the correct spot."
    puts ""
    print " ? ".bg_gray.red
    print " "
    puts "This clue means you have 1 correct number, but it is in the wrong spot."
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