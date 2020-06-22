# frozen_string_literal: true

# game logic for human_solver and computer_solver
module GameLogic
  def compare(master, guess)
    temp_master = master.clone
    temp_guess = guess.clone
    @exact_number = exact_matches(temp_master, temp_guess)
    @same_number = right_numbers(temp_master, temp_guess)
    @total_number = exact_number + same_number
  end

  def exact_matches(master, guess)
    exact = 0
    master.each_with_index do |item, index|
      next unless item == guess[index]

      exact += 1
      master[index] = '*'
      guess[index]  = '*'
    end
    exact
  end

  def right_numbers(master, guess)
    same = 0
    guess.each_index do |index|
      next unless guess[index] != '*' && master.include?(guess[index])

      same += 1
      remove = master.find_index(guess[index])
      master[remove] = '?'
      guess[index] = '?'
    end
    same
  end

  def solved?(master, guess)
    master == guess
  end

  def repeat_game
    puts game_message('repeat_prompt')
    replay = gets.chomp
    puts game_message('thanks') if replay.downcase != 'y'
    Game.new.play if replay.downcase == 'y'
  end
end
