# frozen_string_literal: true

require './game_logic'
require './display'
require './text_content'

# class for code_maker game option
class ComputerSolver
  attr_reader :maker_code, :turn_count, :exact_number, :same_number,
              :total_number, :find_code_guesses, :four_numbers

  include GameLogic
  include Display
  include TextContent

  def computer_start
    puts turn_message('code_prompt')
    @maker_code = create_code.split(//)
    show_code(maker_code)
    puts turn_message('code_displayed')
    find_code_numbers
    find_code_order
    computer_game_over(@code_permutations[0])
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
    @find_code_guesses = []
    @four_numbers = find_four_numbers(options)
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
    @find_code_guesses << [current_guess, exact_number, same_number]
  end

  def find_code_order
    @code_permutations = create_permutations(four_numbers)
    @code_permutations.uniq!
    compare_previous_guesses
    final_turns
  end

  def create_permutations(array)
    array.permutation.to_a
  end

  def compare_previous_guesses
    @find_code_guesses.each { |code| compare_permutations(code) }
  end

  def compare_permutations(code)
    run_permutations(code[0], code[1], code[2])
  end

  def run_permutations(code, exact, same)
    @code_permutations.each do |perm|
      compare(perm, code)
      reduce_perms(perm) unless exact_number == exact && same_number == same
    end
  end

  def reduce_perms(code)
    @code_permutations.reject! do |perm|
      perm == code
    end
  end

  def final_turns
    until @turn_count > 12
      computer_turn(maker_code, @code_permutations[0])
      @turn_count += 1
      break if solved?(maker_code, @code_permutations[0])

      run_permutations(@code_permutations[0], exact_number, same_number)
    end
  end

  def computer_game_over(guess)
    if solved?(maker_code, guess)
      computer_won
    else
      puts game_message('computer_lost')
    end
    repeat_game
  end

  def computer_won
    puts computer_won_message('inconceivable') if turn_count <= 6
    puts computer_won_message('won') if turn_count.between?(7, 11)
    puts computer_won_message('close') if turn_count == 12
  end
end
