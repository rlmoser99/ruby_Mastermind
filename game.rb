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
    guess.each do |num|
      print " ? ".reverse_color if @master_code.numbers.include?(num)
      print " " if @master_code.numbers.include?(num)
    end
    puts ""
    # puts "Game Clues:"
    # print " * ".bg_black.gray
    # print " Correct Color & Correct Spot"
    # puts ""
    # print " ? ".reverse_color
    # print " Correct Color"
    # puts ""
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