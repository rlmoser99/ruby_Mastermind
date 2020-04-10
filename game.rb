class Game
  def player_turns
    turn = 1
    while turn <= 12 do
      puts @show.content(turn, "turn_prompt")
      puts @show.content("last_turn") if turn == 12
      turn += 1
      loop do
        @guess = gets.chomp
        break if @guess.match(/[1-6][1-6][1-6][1-6]/) && @guess.length == 4
        break if @guess.downcase == "q"
        puts @show.content("turn_error")
      end
      break if @guess.downcase == "q"
      reveal(@guess.split(//))
      break if solved?(@master_code.numbers, @guess.split(//))
      compare(@guess.split(//))
    end
  end

  def compare (guess)
    temp_master = []
    @master_code.numbers.each { |num| temp_master << num }
    print @show.content("clues")
    @exact_number = exact_matches(temp_master, guess)
    @same_number = right_numbers(temp_master, guess)
    print @show.clues(@exact_number, @same_number)
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

  def game_over
    if solved?(@master_code.numbers, @guess.split(//))
      puts @show.content("won")
    else
      puts @show.content("lost")
      puts @show.content("reveal_code")
      reveal(@master_code.numbers)
    end
    puts @show.content("end")
    @replay = gets.chomp until @replay == "y" || @replay == "n"
    Game.new.play if @replay.downcase == "y"
  end

  def reveal (array)
    array.each do | num |
      print @show.color_code (num)
    end
  end

  def play
    @show = Display.new("show")
    @master_code = Code.new
    puts @show.instructions
    player_turns
    game_over
  end

end