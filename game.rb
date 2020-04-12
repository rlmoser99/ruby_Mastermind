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
      compare(@master_code.numbers, @guess.split(//))
    end
  end

  def compare (master, guess)
    temp_master = []
    master.each { |num| temp_master << num }
    temp_guess = []
    guess.each { |num| temp_guess << num }
    print @show.content("clues")
    @exact_number = exact_matches(temp_master, temp_guess)
    @same_number = right_numbers(temp_master, temp_guess)
    @total_number = @exact_number + @same_number
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
    puts @show.instructions
    loop do
      @answer = gets.chomp
      break if @answer == "1" || @answer == "2"
      puts @show.content("answer_error")
    end
    code_maker if @answer == "1"
    code_breaker if @answer == "2"
  end

  def code_maker
    puts @show.content("maker_start")
    loop do
      @maker_input = gets.chomp
      break if @maker_input.match(/[1-6][1-6][1-6][1-6]/) && @maker_input.length == 4
      puts @show.content("maker_error")
    end
    @maker_code = @maker_input.split(//)
    reveal(@maker_code)
    puts @show.content("maker_code")
    computer_turns
  end
  
  def code_breaker
    @master_code = Code.new
    puts @show.content("breaker_start")
    # @player = Player.new("human")
    # @player.player_turns
    player_turns
    game_over
  end

  def computer_turns
    @turn_count = 1
    @number_guess = 1
    @computer_guess = []
    find_code_numbers
    find_code_order
  end

  def find_code_numbers
    until @total_number == 4 do
      puts @show.content(@turn_count, "computer_turn")
      # sleep(1)
      @computer_guess.pop(4 - @total_number) if @turn_count != 1
      @computer_guess << @number_guess.to_s until @computer_guess.length == 4
      reveal(@computer_guess)
      compare(@maker_code, @computer_guess)
      @turn_count += 1
      @number_guess += 1
    end
  end

  # def find_code_order
  #   until solved?(@maker_code, @computer_guess) || @turn_count > 12
  #     puts @show.content(@turn_count, "computer_turn")
  #     sleep(1)
  #     @computer_guess.shuffle!
  #     reveal(@computer_guess)
  #     compare(@maker_code, @computer_guess)
  #     @turn_count += 1
  #   end
  # end

  def find_code_order
    # until solved?(@maker_code, @computer_guess) || @turn_count > 12
    # Turn +1
      puts @show.content(@turn_count, "computer_turn")
      # sleep(1)
      @computer_guess.shuffle!
      reveal(@computer_guess)
      compare(@maker_code, @computer_guess)
      @guess_results = []
      @guess_results << [@exact_number, @computer_guess]
      # print @guess_results
      # puts ""
      @turn_count += 1
      # Turn +2
      puts @show.content(@turn_count, "computer_turn")
      @computer_guess[2], @computer_guess[3] = @computer_guess[3], @computer_guess[2]
      reveal(@computer_guess)
      compare(@maker_code, @computer_guess)
      @guess_results << [@exact_number, @computer_guess]
      # print @guess_results
      puts ""
      puts ""
      puts ""
      @turn_count += 1
      # Turn +3
      # puts @show.content(@turn_count, "computer_turn")
      if @guess_results[0][0] == 0 && @guess_results[1][0] == 0
        puts "[2,3] should be switched to [0,1]"
      end
      if @guess_results[0][0] == 0 && @guess_results[1][0] == 1
        puts "The SECOND guess has 1 correct in [2, 3] position"
      end
      if @guess_results[0][0] == 0 && @guess_results[1][0] == 2
        puts "The SECOND guess BOTH correct in [2, 3] position"
      end
      if @guess_results[0][0] == 1 && @guess_results[1][0] == 0
        puts "The FIRST guess has 1 correct in [2,3] position"
      end
      if @guess_results[0][0] == 1 && @guess_results[1][0] == 1
        puts "The FIRST guess has 1 correct in [0,1] position or if [2,3] were duplicate numbers one of them is correct"
      end
      if @guess_results[0][0] == 1 && @guess_results[1][0] == 2
        puts "The SECOND guess has 1 correct in [0,1] and 1 correct in [2,3] position"
      end
      if @guess_results[0][0] == 2 && @guess_results[1][0] == 0
        puts "The FIRST guess has 2 correct in [0,1]"
      end
      if @guess_results[0][0] == 2 && @guess_results[1][0] == 1
        puts "The FIRST guess has 1 correct in [0,1] and 1 correct in [2,3] position"
      end
      if @guess_results[0][0] == 2 && @guess_results[1][0] == 2
        puts "HARDEST: Either 1 of [0, 1] and 1 of [2, 3] is correct (maybe duplicate numbers at end?) or both of [0,1] are correct, or if [2,3] were duplicate numbers and they could be correct." 
      end
      # @computer_guess[2], @computer_guess[3] = @computer_guess[3], @computer_guess[2]
      # reveal(@computer_guess)
      # compare(@maker_code, @computer_guess)
      # @guess_results << [@exact_number, @computer_guess]
      # print @guess_results
      # puts ""
      # @turn_count += 1
    # end
  end

end