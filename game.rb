require './intro'

class Game
  include Intro
  
  def player_turns
    turn = 1
    while turn <= 12 do
      puts "Turn ##{turn}: Type in four numbers (1-6) to guess code, or 'q' to quit game"
      puts "Choose carefully. This is your last turn to win!".red if turn == 12
      turn += 1
      loop do
        @guess = gets.chomp
        break if @guess.match(/[1-6][1-6][1-6][1-6]/) && @guess.length == 4
        break if @guess.downcase == "q"
        puts "Your guess should only be 4 digits between 1-6.".red
      end
      break if @guess.downcase == "q"
      self.display(@guess.split(//))
      break if solved?(@master_code.numbers, @guess.split(//))
      self.compare(@guess.split(//))
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
        remove = master.find_index(guess[i])
        master[remove] = "?"
        guess[i]  = "?"
      end
      i += 1
    end
  end

  def solved? (master, guess)
    correct_guess = false
    correct_guess = true if master == guess
  end

  def end
    if solved?(@master_code.numbers, @guess.split(//))
      puts "  You broke the code! Congratulations, you win!"
      puts ""
    else
      puts "Game over. ¯\\_(ツ)_/¯ ".red
      puts ""
      puts "Here is the 'master code' that you were trying to break:"
      self.display(@master_code.numbers)
      puts ""
      puts ""
    end
  end

  def display (array)
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
    self.instructions 
    @master_code = Code.new
    # puts "MASTER CODE (for trouble-shooting):"
    # self.display(@master_code.numbers)
    # puts ""
    self.player_turns
    self.end
  end

end