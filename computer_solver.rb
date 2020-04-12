require './game_logic'
require './display'

class ComputerSolver
  include GameLogic
  include Display

  def initialize(name)
    @name = name
  end

  def computer_turns
    # FOLLOWING LINES CAME FROM GAME - REARRANGE?
    puts content("maker_start")
    loop do
      @maker_input = gets.chomp
      break if @maker_input.match(/[1-6][1-6][1-6][1-6]/) && @maker_input.length == 4
      puts content("maker_error")
    end
    @maker_code = @maker_input.split(//)
    reveal(@maker_code)
    puts content("maker_code")
    @turn_count = 1
    @number_guess = 1
    @computer_guess = []
    find_code_numbers
    find_code_order
  end

  def find_code_numbers
    until @total_number == 4 do
      puts content(@turn_count, "computer_turn")
      # sleep(1)
      @computer_guess.pop(4 - @total_number) if @turn_count != 1
      @computer_guess << @number_guess.to_s until @computer_guess.length == 4
      reveal(@computer_guess)
      compare(@maker_code, @computer_guess)
      @turn_count += 1
      @number_guess += 1
    end
  end

  # Easy shuffle method - likey to not break the code
  # def find_code_order
  #   until solved?(@maker_code, @computer_guess) || @turn_count > 12
  #     puts @show.content(@turn_count, "computer_turn")
  #     sleep(1)
  #     @computer_guess.shuffle!
  #     reveal(@computer_guess)
  #     compare(@maker_code, @computer_guess)
  #     @turn_count += 1
  #   end
  # end

  def find_code_order
    # until solved?(@maker_code, @computer_guess) || @turn_count > 12
    # Turn +1
      # puts @show.content(@turn_count, "computer_turn")
      puts content(@turn_count, "computer_turn")
      # sleep(1)
      @computer_guess.shuffle!
      reveal(@computer_guess)
      compare(@maker_code, @computer_guess)
      @guess_results = []
      @guess_results << [@exact_number, @computer_guess]
      # print @guess_results
      # puts ""
      @turn_count += 1
      # Turn +2
      # puts @show.content(@turn_count, "computer_turn")
      puts content(@turn_count, "computer_turn")
      @computer_guess[2], @computer_guess[3] = @computer_guess[3], @computer_guess[2]
      reveal(@computer_guess)
      compare(@maker_code, @computer_guess)
      @guess_results << [@exact_number, @computer_guess]
      # print @guess_results
      puts ""
      puts ""
      puts ""
      @turn_count += 1
      # Turn +3
      # puts @show.content(@turn_count, "computer_turn")
      if @guess_results[0][0] == 0 && @guess_results[1][0] == 0
        puts "[2,3] should be switched to [0,1]"
      end
      if @guess_results[0][0] == 0 && @guess_results[1][0] == 1
        puts "The SECOND guess has 1 correct in [2, 3] position"
      end
      if @guess_results[0][0] == 0 && @guess_results[1][0] == 2
        puts "The SECOND guess BOTH correct in [2, 3] position"
      end
      if @guess_results[0][0] == 1 && @guess_results[1][0] == 0
        puts "The FIRST guess has 1 correct in [2,3] position"
      end
      if @guess_results[0][0] == 1 && @guess_results[1][0] == 1
        puts "The FIRST guess has 1 correct in [0,1] position or if [2,3] were duplicate numbers one of them is correct"
      end
      if @guess_results[0][0] == 1 && @guess_results[1][0] == 2
        puts "The SECOND guess has 1 correct in [0,1] and 1 correct in [2,3] position"
      end
      if @guess_results[0][0] == 2 && @guess_results[1][0] == 0
        puts "The FIRST guess has 2 correct in [2,3]"
      end
      if @guess_results[0][0] == 2 && @guess_results[1][0] == 1
        puts "The FIRST guess has 1 correct in [0,1] and 1 correct in [2,3] position"
      end
      if @guess_results[0][0] == 2 && @guess_results[1][0] == 2
        puts "HARDEST: Either 1 of [0, 1] and 1 of [2, 3] is correct (maybe duplicate numbers at end?) or both of [0,1] are correct, or if [2,3] were duplicate numbers and they could be correct." 
      end
      # @computer_guess[2], @computer_guess[3] = @computer_guess[3], @computer_guess[2]
      # reveal(@computer_guess)
      # compare(@maker_code, @computer_guess)
      # @guess_results << [@exact_number, @computer_guess]
      # print @guess_results
      # puts ""
      # @turn_count += 1
    # end
  end

end