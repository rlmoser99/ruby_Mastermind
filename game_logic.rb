module GameLogic

  def compare (master, guess)
    temp_master = []
    master.each { |num| temp_master << num }
    temp_guess = []
    guess.each { |num| temp_guess << num }
    print content("clues")
    @exact_number = exact_matches(temp_master, temp_guess)
    @same_number = right_numbers(temp_master, temp_guess)
    @total_number = @exact_number + @same_number
    print clues(@exact_number, @same_number)
  end

  # Need to re-factor code, so this only happens once.
  def computer_compare (master, guess)
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

  def game_over (master, guess)
    if solved?(master, guess)
      puts content("won")
    else
      puts content("lost")
      puts content("reveal_code")
      reveal(master)
    end
    puts content("end")
    @replay = gets.chomp until @replay == "y" || @replay == "n"
    Game.new.play if @replay.downcase == "y"
  end

  def reveal (array)
    array.each do | num |
      print color_code (num)
    end
  end
  
end