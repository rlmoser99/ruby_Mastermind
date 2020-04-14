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
    find_code_numbers
  end

  def find_code_numbers
    options = ["1", "2", "3", "4", "5", "6"]
    options.shuffle!
    option_index = 0
    computer_guess = []
    until @total_number == 4 do
      puts content(@turn_count, "computer_turn")
      # sleep(1)
      computer_guess.pop(4 - @total_number) if @turn_count != 1
      computer_guess << options[option_index] until computer_guess.length == 4
      reveal(computer_guess)
      compare(@maker_code, computer_guess)
      @turn_count += 1
      option_index += 1
    end
    find_code_order(computer_guess) if @exact_number > 0
    shuffle_guess(computer_guess) if @exact_number == 0
  end

  def create_permutations (array)
    @code_permutations = array.permutation.to_a
    # puts "CODE PERMUTATIONS:"
    # @code_permutations.each do | array |
    #   print array
    #   puts ""
    # end
  end

  def shuffle_guess (array)
    until @exact_number > 0
      array.shuffle!
      puts content(@turn_count, "computer_turn")
      reveal(array)
      compare(@maker_code, array)
      @turn_count += 1
    end
    find_code_order (array)
  end

  def find_code_order (array)
    create_permutations (array)
    reduce_permutations (array)
    until @turn_count > 12 || solved?(@maker_code, array)
      # Remove the first permutation, since it was the last guess.
      @code_permutations.shift
      puts content(@turn_count, "computer_turn")
      reveal(@code_permutations[0])
      compare(@maker_code, @code_permutations[0])
      break if solved?(@maker_code, @code_permutations[0])
      reduce_permutations (@code_permutations[0])
      @turn_count += 1
    end
  end

  # WHAT HAPPENS IF GAME SOLVES SUPER EARLY!?!??

  def reduce_permutations (array)
    # puts "reduce permutations"
    @code_permutations.filter! do | item |
      computer_compare(@maker_code, item) >= computer_compare(@maker_code, array)
    end
    # puts "REDUCED:"
    # @code_permutations.each do | code |
    #   print code
    #   puts ""
    # end
  end

end