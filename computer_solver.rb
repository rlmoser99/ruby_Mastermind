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

  def find_code_order(array)
    @code_permutations = create_permutations(array)
    @code_permutations.uniq!
    # TEMPORARY - WILL DELETE THIS LINE AFTER THE CODE IS WORKING BUT NEED TO SEE IT
    puts 'Previous Guesses'
    @code_tracker.each_with_index { |code, index| puts "#{index}: #{code}" }
    puts ''
    # puts 'Possible Combinations'
    # @code_permutations.each_with_index { |code, ind| puts "#{ind}: #{code}" }
    compare_previous_guesses
  end

  def create_permutations(array)
    array.permutation.to_a
  end

  def compare_previous_guesses
    remove_zero_exact
    remove_one_exact if at_least_one_exact?
    remove_one_exact if zero_then_one_exact?
    puts 'Permutations after compare_previous_guesses'
    @code_permutations.each_with_index { |code, ind| puts "#{ind}: #{code}" }
  end

  def remove_zero_exact
    @code_tracker.each do |code|
      next unless code[1].zero? && code[2].positive?

      puts "remove_zero_exact for: #{code}"
      examine_previous_guess(code[0])
    end
  end

  def examine_previous_guess(code)
    code.each_with_index do |number, index|
      reject_permutations(number, index) if computer_guess.include?(number.to_s)
    end
  end

  def reject_permutations(number, index)
    puts "Removing number: #{number} from index: #{index}"
    @code_permutations.reject! do |code|
      code[index] == number.to_s
    end
  end

  def remove_one_exact
    first_possibility = code_tracker[-1][0][0]
    second_possibility = code_tracker[-1][0][1]
    keep_code_if_matches(first_possibility, second_possibility)
  end

  def at_least_one_exact?
    @code_tracker.all? { |code| code[1] >= 1 }
  end

  def zero_then_one_exact?
    result = []
    @code_tracker.each { |code| result << code[1] }
    loop do
      result.shift if result[0].zero?
      break if result[0].positive?
    end
    result.all? { |number| number >= 1 }
  end

  def keep_code_if_matches(first, second)
    puts "Keeping numbers: #{first} and #{second} in 0 or 1 position"
    @code_permutations.select! do |code|
      code[0] == first.to_s || code[1] == second.to_s
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
