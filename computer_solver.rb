# frozen_string_literal: true

require './game_logic'
require './display'
require './text_content'

# class for code_maker game option
class ComputerSolver
  attr_reader :maker_code, :computer_guess, :turn_count, :exact_number,
              :same_number, :total_number, :code_tracker

  include GameLogic
  include Display
  include TextContent

  def computer_start
    puts turn_message('code_prompt')
    @maker_code = create_code.split(//)
    show_code(maker_code)
    puts turn_message('code_displayed')
    find_code_numbers
  end

  def create_code
    input = gets.chomp
    return input if input.match(/^[1-6]{4}$/)

    puts warning_message('code_error')
    create_code
  end

  def find_code_numbers
    numbers = %w[1 2 3 4 5 6]
    options = numbers.shuffle
    @turn_count = 1
    @code_tracker = []
    @computer_guess = find_four_numbers(options)
    find_code_order(computer_guess)
    # find_code_order(computer_guess) if exact_number.positive?
    # shuffle_guess(computer_guess) if exact_number.zero?
  end

  def find_four_numbers(options, index = 0, guess = [])
    guess.pop(4 - total_number) unless turn_count == 1
    guess << options[index] until guess.length == 4
    computer_turn(maker_code, guess)
    @turn_count += 1
    return guess if total_number == 4

    find_four_numbers(options, index + 1, guess)
  end

  def computer_turn(master, guess)
    puts turn_message('computer', turn_count)
    sleep(1)
    show_code(guess)
    compare(master, guess)
    show_clues(exact_number, same_number)
    current_guess = guess.clone
    @code_tracker << [current_guess, exact_number, same_number]
  end

  # def shuffle_guess(array)
  #   until exact_number.positive?
  #     array.shuffle!
  #     computer_turn(maker_code, array)
  #     @turn_count += 1
  #   end
  #   find_code_order(array)
  # end

  # def find_code_order(array)
  #   create_permutations(array)
  #   reduce_permutations(array)
  #   code_order_guess(array)
  #   computer_game_over(@code_permutations[0])
  # end

  # def find_code_order(array)
  #   @code_permutations = create_permutations(array)
  #   @code_permutations.uniq!
  #   # TEMPORARY - WILL DELETE THIS LINE AFTER THE CODE IS WORKING BUT NEED TO SEE IT
  #   puts 'Previous Guesses'
  #   @code_tracker.each_with_index { |code, index| puts "#{index}: #{code}" }
  #   puts ''
  #   # puts 'Possible Combinations'
  #   # @code_permutations.each_with_index { |code, ind| puts "#{ind}: #{code}" }
  #   compare_previous_guesses
  # end

  def find_code_order(array)
    @code_permutations = create_permutations(array)
    @code_permutations.uniq!
    # TEMPORARY - WILL DELETE THIS LINE AFTER THE CODE IS WORKING BUT NEED TO SEE IT
    # puts 'Previous Guesses'
    # @code_tracker.each_with_index { |code, index| puts "#{index}: #{code}" }
    # puts ''
    # puts 'Possible Combinations'
    # @code_permutations.each_with_index { |code, ind| puts "#{ind}: #{code}" }
    compare_previous_guesses
  end

  def create_permutations(array)
    array.permutation.to_a
  end

  def compare_previous_guesses
    @code_tracker.each { |code| compare_permutations(code) }
    # puts 'Permutations after compare_previous_guesses'
    # @code_permutations.each_with_index { |code, ind| puts "#{ind}: #{code}" }
    final_turns
  end

  def compare_permutations(code)
    # puts "Code is: #{code[0]}"
    # puts "Exact Matches are: #{code[1]}"
    # puts "Same Matches are: #{code[2]}"
    # puts ''
    run_permutations(code[0], code[1], code[2])
  end

  def run_permutations(code, exact, same)
    @code_permutations.each do |perm|
      # puts "compare #{perm} to earlier guess"
      compare(perm, code)
      # puts "Exact: #{exact_number} and Same: #{same_number}"
      reduce_perms(perm) unless exact_number == exact && same_number == same
    end
  end

  def reduce_perms(code)
    # puts "need to remove #{code}"
    @code_permutations.reject! do |perm|
      perm == code
    end
  end

  def final_turns
    until @turn_count > 12
      computer_turn(maker_code, @code_permutations[0])
      @turn_count += 1
      break if solved?(maker_code, @code_permutations[0])

      @code_permutations.shift
    end
  end

  # def reduce_permutations(array)
  #   @code_permutations.select! do |item|
  #     compare(maker_code, item) >= compare(maker_code, array)
  #   end
  #   @code_permutations.uniq!
  # end

  # def code_order_guess(array)
  #   until @turn_count > 12 || solved?(maker_code, array)
  #     @code_permutations.shift
  #     computer_turn(maker_code, @code_permutations[0])
  #     break if solved?(maker_code, @code_permutations[0])

  #     reduce_permutations(@code_permutations[0])
  #     @turn_count += 1
  #   end
  # end

  def computer_game_over(guess)
    if solved?(maker_code, guess)
      puts computer_won
    else
      puts game_message('computer_lost')
    end
    repeat_game
  end

  def computer_won
    computer_won_message('inconceivable') if turn_count <= 6
    computer_won_message('won') if turn_count.between?(7, 11)
    computer_won_message('close') if turn_count == 12
  end
end
