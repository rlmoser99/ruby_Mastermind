class Game

  def start
    puts "Let's play Mastermind"
    @master_code = Code.new
    @options = ["1", "2", "3", "4", "5", "6"]
    puts "The computer will choose 4 random color/numbers to make a code"
    self.reveal(@options)
  end

  def show
    puts "TEMPORARILY REVEALED MASTER CODE:"
    self.reveal(@master_code.numbers)
  end 
  
  def turn
    puts "Type in four numbers (1-6) to guess code"
    loop do
      @guess = gets.chomp
      break if @guess.match(/[1-6][1-6][1-6][1-6]/) && @guess.length == 4
      puts "Your guess should only be 4 digits between 1-6.".red
    end
    self.reveal(@guess.split(//))
    puts "Figure out the comparision logic:"
    self.compare(@guess.split(//))
  end

  def compare (guess)
    temp_master = []
    @master_code.numbers.each { |num| temp_master << num }
    index = 0
    4.times do
      if temp_master[index] == guess[index]
        print " * ".bg_black.gray
        print " "
        temp_master[index] = "X"
        guess[index]  = "X"
      end
      index += 1
    end
    i = 0
    4.times do
      if guess[i] != "X" && temp_master.include?(guess[i])
        print " ? ".reverse_color
        print " "
        delete = temp_master.find_index(guess[i])
        temp_master[delete] = "X"
        guess[i]  = "X"
      end
      i += 1
    end
    puts ""
    # puts "#{guess} is the new guess"
    # puts "#{temp_master} is the new temp master"
    # puts "#{@master_code.numbers} should be unchanged"
  end

  def reveal (array)
    array.each do | num |
      print "  #{num}  ".bg_red.bold if num == 1 || num == "1"
      print "  #{num}  ".bg_green.bold if num == 2 || num == "2"
      print "  #{num}  ".bg_blue.bold if num == 3 || num == "3"
      print "  #{num}  ".bg_magenta.bold if num == 4 || num == "4"
      print "  #{num}  ".bg_cyan.bold if num == 5 || num == "5"
      print "  #{num}  ".bg_gray.bold if num == 6 || num == "6"
      print " "
    end
    puts ""
  end

  def play
    self.start
    self.show
    self.turn
  end

end

# method: instructions
# method: get user code guesses
# method: process code guess
# method: show code & clues

# CODE:  3234
# guess: 2335
# Check for index values that match
# CODE:  32X4
# guess: 23X5
# Check for same number
# 2
# CODE:  3XX4
# guess: X3X5
# 3
# CODE:  XXX4
# guess: XXX5
# 5
# CODE:  XXX4
# guess: XXXX

# CODE:  1422
# guess: 2344
# Check for index values that match
# CODE:  1422
# guess: 2344
# Check for same number
# 2
# CODE:  14X2
# guess: X344
# 3
# CODE:  14X2
# guess: XX44
# 4
# CODE:  1XX2
# guess: XXX4
# 4
# CODE:  1XX2
# guess: XXXX
