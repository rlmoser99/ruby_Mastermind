require './game_logic'
require './display'

class HumanSolver
  include GameLogic
  include Display

  def initialize(name)
    @name = name
    @computer_code = []
    num = Random.new
    4.times {@computer_code << num.rand(1..6).to_s}
  end

  def player_turns
    puts "player_turns inside HumanSolver"
    puts content("breaker_start")
    turn = 1
    while turn <= 12 do
      puts content(turn, "turn_prompt")
      puts content("last_turn") if turn == 12
      turn += 1
      loop do
        @guess = gets.chomp
        break if @guess.match(/[1-6][1-6][1-6][1-6]/) && @guess.length == 4
        break if @guess.downcase == "q"
        puts content("turn_error")
      end
      break if @guess.downcase == "q"
      reveal(@guess.split(//))
      break if solved?(@computer_code, @guess.split(//))
      compare(@computer_code, @guess.split(//))
    end
    game_over(@computer_code, @guess.split(//))
  end

end