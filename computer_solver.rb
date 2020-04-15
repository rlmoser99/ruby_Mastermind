require './game_logic'
require './display'
require './text_content'

class ComputerSolver
  include GameLogic
  include Display
  include TextContent

  def initialize(name)
    @name = name
  end

  def computer_turns
    puts turn_message("code_prompt")
    loop do
      @maker_input = gets.chomp
      break if @maker_input.match(/[1-6][1-6][1-6][1-6]/) && @maker_input.length == 4
      puts warning_message("code_error")
    end
    @maker_code = @maker_input.split(//)
    show_code(@maker_code)
    puts turn_message("code_displayed")
    find_code_numbers
  end

  def find_code_numbers
    options = ["1", "2", "3", "4", "5", "6"]
    options.shuffle!
    option_index = 0
    @turn_count = 1
    computer_guess = []
    until @total_number == 4 do
      puts turn_message(@turn_count, "computer")
      sleep(1)
      computer_guess.pop(4 - @total_number) if @turn_count != 1
      computer_guess << options[option_index] until computer_guess.length == 4
      show_code(computer_guess)
      compare(@maker_code, computer_guess)
      show_clues @exact_number, @same_number
      @turn_count += 1
      option_index += 1
    end
    find_code_order(computer_guess) if @exact_number > 0
    shuffle_guess(computer_guess) if @exact_number == 0
  end

  def shuffle_guess (array)
    until @exact_number > 0
      array.shuffle!
      puts turn_message(@turn_count, "computer")
      sleep(1)
      show_code(array)
      compare(@maker_code, array)
      show_clues @exact_number, @same_number
      @turn_count += 1
    end
    find_code_order (array)
  end

  def find_code_order (array)
    create_permutations (array)
    reduce_permutations (array)
    until @turn_count > 12 || solved?(@maker_code, array)
      puts turn_message(@turn_count, "computer")
      sleep(1)
      # Remove the last computer guess
      @code_permutations.shift
      show_code(@code_permutations[0])
      compare(@maker_code, @code_permutations[0])
      show_clues @exact_number, @same_number
      break if solved?(@maker_code, @code_permutations[0])
      reduce_permutations (@code_permutations[0])
      @turn_count += 1
    end
    game_over(@maker_code, @code_permutations[0], "computer", @turn_count)
  end

  def create_permutations (array)
    @code_permutations = array.permutation.to_a
  end

  def reduce_permutations (array)
    @code_permutations.filter! do | item |
      compare(@maker_code, item) >= compare(@maker_code, array)
    end
  end

end