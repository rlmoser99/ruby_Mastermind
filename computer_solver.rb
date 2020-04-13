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
    compare_two_guesses
    puts ""
    # Only 1 turn is needed to solve
    switch_first_and_second(1) if @guess_results[0][0] == 0 && @guess_results[1][0] == 2
    switch_first_and_second(0) if @guess_results[0][0] == 2 && @guess_results[1][0] == 0
    # Need to work on strategy:
    @solved_code = ["0", "0", "0", "0"]
    find_which_last_two_is_correct(1) if @guess_results[0][0] == 0 && @guess_results[1][0] == 1
    find_which_last_two_is_correct(0) if @guess_results[0][0] == 1 && @guess_results[1][0] == 0
    find_either_one_in_first_or_last_half_is_correct(1) if @guess_results[0][0] == 1 && @guess_results[1][0] == 2
    find_either_one_in_first_or_last_half_is_correct(0) if @guess_results[0][0] == 2 && @guess_results[1][0] == 1
    first_guess_one_01_or_duplicate_23 if @guess_results[0][0] == 1 && @guess_results[1][0] == 1
    switch_first_two_and_last_two if @guess_results[0][0] == 0 && @guess_results[1][0] == 0
    need_more_info if @guess_results[0][0] == 2 && @guess_results[1][0] == 2
    # until solved?(@maker_code, @computer_guess) || @turn_count > 12
    #   Everything inside find_code_order needs to go inside loop - until solved?
    # end
  end

  def compare_two_guesses
    puts ""
    puts "COMPARE TWO GUESSES"
    puts content(@turn_count, "computer_turn")
    # sleep(1)
    # @computer_guess.shuffle!
    # reveal(@computer_guess)
    # compare(@maker_code, @computer_guess)
    puts "Type in computer's numbers in any order..." #TEMP
    my_input = gets.chomp #TEMP
    my_array = my_input.split(//) #TEMP
    reveal(my_array) #TEMP
    compare(@maker_code, my_array) #TEMP
    @guess_results = []
    # @guess_results << [@exact_number, @computer_guess]
    @guess_results << [@exact_number, my_array] #TEMP
    @turn_count += 1
    puts content(@turn_count, "computer_turn")
    # sleep(1)
    # second_comparison = switch_positions @computer_guess, 2, 3
    second_comparison = switch_positions my_array, 2, 3 #TEMP
    reveal(second_comparison)
    compare(@maker_code, second_comparison)
    @guess_results << [@exact_number, second_comparison]
    @turn_count += 1
    puts "The guess results are #{@guess_results}"
  end

  def switch_positions (array, a, b)
    new_array = []
    array.each { |num | new_array << num }
    new_array[a], new_array[b] = new_array[b], new_array[a]
    new_array
  end

  def switch_first_and_second (index)
    puts "SWITCH FIRST AND SECOND"
    puts content(@turn_count, "computer_turn")
    guess = switch_positions @guess_results[index][1], 0, 1
    reveal(guess)
    compare(@maker_code, guess)
    @guess_results << [@exact_number, guess]
    puts "The guess results are #{@guess_results}"
    @turn_count += 1
  end

  def find_which_last_two_is_correct (index)
    # This method will switch [1,2] to determine whether [2 or 3] is correct
    puts "FIND WHICH LAST TWO IS CORRECT"
    puts content(@turn_count, "computer_turn")
    guess = switch_positions @guess_results[index][1], 1, 2
    reveal(guess)
    compare(@maker_code, guess)
    @guess_results << [@exact_number, guess]
    @turn_count += 1
    puts "The guess results are now #{@guess_results}"
    puts ""
    puts "The index [2] is correct. I think [1] is it's duplicate number." if @guess_results[index][0] == 1 && @guess_results[-1][0] == 1 
    # MAYBE? - I am almost positive that these would be duplicate numbers
    @solved_code[2] = @guess_results[index][1][2] if @guess_results[index][0] == 1 && @guess_results[-1][0] == 1 
    @solved_code[1] = @guess_results[-1][1][1] if @guess_results[index][0] == 1 && @guess_results[-1][0] == 1 
    puts "guess [3] is in the right spot and either [1 or 2] is in the right spot" if @guess_results[index][0] == 1 && @guess_results[-1][0] == 2
    puts "Will need to shuffle [0, 1, or 2]" if @guess_results[index][0] == 1 && @guess_results[-1][0] == 2
    @solved_code[3] = @guess_results[index][1][3] if @guess_results[index][0] == 1 && @guess_results[-1][0] == 2
    puts "index [2] is in the right spot" if @guess_results[index][0] == 1 && @guess_results[-1][0] == 0
    puts "Will need to shuffle [0, 1, or 3]" if @guess_results[index][0] == 1 && @guess_results[-1][0] == 0
    @solved_code[2] = @guess_results[index][1][2] if @guess_results[index][0] == 1 && @guess_results[-1][0] == 0
    puts "The solved code is now #{@solved_code}"
  end
  
  def find_either_one_in_first_or_last_half_is_correct (index)
    # This method will switch [1,2] to find the correct one(s)
    puts "FIND EITHER ONE IN FIRST OR LAST HALF IS CORRECT"
    puts content(@turn_count, "computer_turn")
    guess = switch_positions @guess_results[index][1], 1, 2
    reveal(guess)
    compare(@maker_code, guess)
    @guess_results << [@exact_number, guess]
    @turn_count += 1
    puts "The guess results are now #{@guess_results}"
    puts ""
    puts "Confirmed. Either index [1 and 3] or [0 and 2] are correct?" if @guess_results[index][0] == 2 && @guess_results[-1][0] == 1
    puts "Confirm possibility? [0] is correct?" if @guess_results[index][0] == 2 && @guess_results[-1][0] == 1
    puts "Confirm possibility? [0] is correct?" if @guess_results[index][0] == 2 && @guess_results[-1][0] == 1
    puts "Confirm possibility? either [2, 3] are duplicate?" if @guess_results[index][0] == 2 && @guess_results[-1][0] == 1
    puts "Are there any other possibilities that I'm missing?"
    puts "Confirmed. Index [1, 2] are correct. SOLVE: switch index [0 and 3]" if @guess_results[index][0] == 2 && @guess_results[-1][0] == 0
    switch_first_and_last(index) if @guess_results[index][0] == 2 && @guess_results[-1][0] == 0
  end

  def switch_first_and_last (index)
    puts "SWITCH FIRST AND LAST"
    puts content(@turn_count, "computer_turn")
    guess = switch_positions @guess_results[index][1], 0, 3
    reveal(guess)
    compare(@maker_code, guess)
    @guess_results << [@exact_number, guess]
    @turn_count += 1
    puts "The guess results are now #{@guess_results}"
    puts ""
  end

  def first_guess_one_01_or_duplicate_23
    puts "FIRST GUESS ONE 01 OR DUPLICATE 23"
    puts "The FIRST guess has 1 correct in [0,1] position or if [2,3] were duplicate numbers one of them is correct"
  end
  
  def switch_first_two_and_last_two
    puts "SWITCH FIRST TWO AND LAST TWO"
    puts content(@turn_count, "computer_turn")
    guess = switch_positions @guess_results[-1][1], 0, 2
    guess = switch_positions guess, 1, 3
    reveal(guess)
    compare(@maker_code, guess)
    @guess_results << [@exact_number, guess]
    @turn_count += 1
    puts "The guess results are now #{@guess_results}"
    puts ""
    puts "Either guess [0,1] or [2,3] is currect" if @guess_results[0][0] == 0 && @guess_results[1][0] == 0 && @guess_results[2][0] == 2
    switch_last_two if @guess_results[0][0] == 0 && @guess_results[1][0] == 0 && @guess_results[2][0] == 2
    # flip_01_and_23 if @guess_results[0][0] == 0 && @guess_results[1][0] == 0 && @guess_results[2][0] == 0
    # puts "The guess results are now #{@guess_results}"
  end

  # compare_two_guesses can be re-written to use this method too ??
  def switch_last_two
    puts content(@turn_count, "computer_turn")
    guess = switch_positions @guess_results[-1][1], 2, 3
    reveal(guess)
    compare(@maker_code, guess)
    @guess_results << [@exact_number, guess]
    @turn_count += 1
    puts "The guess results are now #{@guess_results}"
    puts ""
    # Working on seeing if below is a possibility:
    puts "Confirm possibility. Switch [2, 3] back and switch [0, 1]" if @guess_results[-1][0] == 0
  end

  # FOR THE WIN!
  def flip_01_and_23
    puts "FLIP 01 AND 23"
    puts "COMPLTELY all wrong, but know that it will be 100% correct if we switch 0 & 1 and 2 & 3"
    # puts content(@turn_count, "computer_turn")
    # @next_guess[0], @next_guess[1], @next_guess[2], @next_guess[3] = @next_guess[1], @next_guess[0], @next_guess[3], @next_guess[2]
    # puts "The next guess will be #{@next_guess}"
    # reveal(@next_guess)
    # compare(@maker_code, @next_guess)
  end

  def need_more_info
    puts "NEED MORE INFO"
    puts "HARDEST: Either 1 of [0, 1] and 1 of [2, 3] is correct (maybe duplicate numbers at end?) or both of [0,1] are correct, or if [2,3] were duplicate numbers and they could be correct." 
  end

end