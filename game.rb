require './text_instructions'
require './text_content'
require './display'

class Game
  include TextInstructions
  include TextContent
  include Display

  def play
    puts instructions
    loop do
      @answer = gets.chomp
      break if @answer == "1" || @answer == "2"
      puts warning_message("answer_error")
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
  end  

end