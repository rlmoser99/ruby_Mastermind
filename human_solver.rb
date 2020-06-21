# frozen_string_literal: true

require './game_logic'
require './display'
require './text_content'

# class for code_breaker game option
class HumanSolver
  attr_reader :computer_code, :guess, :exact_number, :same_number

  include GameLogic
  include Display
  include TextContent

  def initialize
    random_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    @computer_code = random_numbers.map(&:to_s)
  end

  def player_turns
    puts turn_message('breaker_start')
    turn_order
    human_game_over(computer_code, guess)
  end

  def turn_order
    turn = 1
    while turn <= 12
      turn_messages(turn)
      @guess = player_input.split(//)
      turn += 1

      break if guess[0].downcase == 'q'

      show_code(guess)
      break if solved?(computer_code, guess)

      turn_outcome
    end
  end

  def turn_messages(turn)
    puts turn_message('guess_prompt', turn)
    puts warning_message('last_turn') if turn == 12
  end

  def player_input
    input = gets.chomp
    return input if input.match(/^[1-6]{4}$/)
    return input if input.downcase == 'q'

    puts warning_message('turn_error')
    player_input
  end

  def turn_outcome
    compare(computer_code, guess)
    show_clues(exact_number, same_number)
  end

  def human_game_over(master, guess)
    if solved?(master, guess)
      puts game_message('human_won')
    else
      puts warning_message('game_over')
      puts game_message('display_code')
      show_code(master)
    end
    repeat_game
  end
end
