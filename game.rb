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
      # EDIT!!!
      self.reveal(@guess.split(//))
      # self.reveal
      break if solved?(@master_code.numbers, @guess.split(//))
      self.compare(@guess.split(//))
    end
  end

  def compare (guess)
    temp_master = []
    @master_code.numbers.each { |num| temp_master << num }
    print @show.content("clues")
    self.exact_matches(temp_master, guess)
    self.right_numbers(temp_master, guess)
    puts ""
  end

  def exact_matches(master, guess)
    index = 0
    4.times do
      if master[index] == guess[index]
        print " * ".bg_gray.green
        print " "
        master[index] = "*"
        guess[index]  = "*"
      end
      index += 1
    end
  end

  def right_numbers(master, guess)
    i = 0
    4.times do
      if guess[i] != "*" && master.include?(guess[i])
        print " ? ".bg_gray.red
        print " "
        remove = master.find_index(guess[i])
        master[remove] = "?"
        guess[i]  = "?"
      end
      i += 1
    end
  end

  def solved? (master, guess)
    correct_guess = false
    correct_guess = true if master == guess
  end

  def end
    if solved?(@master_code.numbers, @guess.split(//))
      puts @show.content("won")
    else
      puts @show.content("lost")
      puts @show.content("reveal_code")
      self.reveal(@master_code.numbers)
      puts ""
      puts ""
    end
  end

  def reveal (array)
    array.each do | num |
      print @show.color_code (num)
      print " "
    end
  end

  def play
    @show = Display.new("show")
    @master_code = Code.new
    puts @show.instructions
    # puts "MASTER CODE (for trouble-shooting):"
    # self.show(@master_code.numbers)
    # puts ""
    self.player_turns
    self.end
  end

end
