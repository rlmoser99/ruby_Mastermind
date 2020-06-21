# frozen_string_literal: true

require './game_logic'
require './display'
require './text_content'

# class for code_maker game option
class ComputerSolver
  attr_reader :maker_code, :computer_guess, :turn_count, :exact_number,
              :same_number, :total_number

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
    @computer_guess = find_four_numbers(options)
    find_code_order(computer_guess) if exact_number.positive?
    shuffle_guess(computer_guess) if exact_number.zero?
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
  end

  def shuffle_guess(array)
    until exact_number.positive?
      array.shuffle!
      computer_turn(maker_code, array)
      @turn_count += 1
    end
    find_code_order(array)
  end

  def find_code_order(array)
    create_permutations(array)
    reduce_permutations(array)
    code_order_guess(array)
    computer_game_over(@code_permutations[0])
  end

  def create_permutations(array)
    @code_permutations = array.permutation.to_a
  end

  def reduce_permutations(array)
    @code_permutations.select! do |item|
      compare(maker_code, item) >= compare(maker_code, array)
    end
    @code_permutations.uniq!
  end

  def code_order_guess(array)
    until @turn_count > 12 || solved?(maker_code, array)
      @code_permutations.shift
      computer_turn(maker_code, @code_permutations[0])
      break if solved?(maker_code, @code_permutations[0])

      reduce_permutations(@code_permutations[0])
      @turn_count += 1
    end
  end

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
