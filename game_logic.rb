module GameLogic

  def compare (master, guess)
    temp_master = []
    master.each { |num| temp_master << num }
    temp_guess = []
    guess.each { |num| temp_guess << num }
    @exact_number = exact_matches(temp_master, temp_guess)
    @same_number = right_numbers(temp_master, temp_guess)
    @total_number = @exact_number + @same_number
    @exact_number
  end

  def exact_matches(master, guess)
    exact = 0
    master.each_with_index do | item, index |
      if item == guess[index]
        exact += 1 
        master[index] = "*"
        guess[index]  = "*"
      end
    end
    exact
  end

  def right_numbers(master, guess)
    same = 0
    guess.each_with_index do | item, index |
      if guess[index] != "*" && master.include?(guess[index])
        same += 1
        remove = master.find_index(guess[index])
        master[remove] = "?"
        guess[index]  = "?"
      end
    end
    same
  end

  def solved? (master, guess)
    correct_guess = false
    correct_guess = true if master == guess
  end

  def game_over (master, guess, solver)
    puts game_message("computer_won") if solver == "computer" && solved?(master, guess)
    puts game_message("computer_lost") if solver == "computer" && !solved?(master, guess)
    puts game_message("human_won") if solver == "human" && solved?(master, guess)
    human_lost(master) if solver == "human" && !solved?(master, guess)
    puts game_message("repeat_prompt")
    @replay = gets.chomp
    puts game_message("thanks") if @replay.downcase != "y"
    Game.new.play if @replay.downcase == "y"
  end

  def human_lost (master)
    puts warning_message("game_over")
    puts game_message("display_code") 
    show_code(master)
  end

end