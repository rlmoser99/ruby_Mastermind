require './text_content'
require './display'

class Game
  include TextContent
  include Display

  def play
    # puts instructions
    puts "'1' to MAKE and '2' to BREAK - removed instructions temporarily"
    loop do
      @answer = gets.chomp
      break if @answer == "1" || @answer == "2"
      puts content("answer_error")
    end
    code_maker if @answer == "1"
    code_breaker if @answer == "2"
  end

  def code_maker
    @computer = ComputerSolver.new("cpu")
    @computer.computer_turns
  end
  
  def code_breaker
    @breaker = HumanSolver.new("person")
    @breaker.player_turns
    # Where does game_over belong?
    # game_over
  end  

end