require './game_logic'

class HumanSolver
  include GameLogic

  def initialize(name)
    @name = name
  end

  def player_turns
    turn = 1
    @show = Display.new("show")
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

end