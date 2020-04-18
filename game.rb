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
      @game_mode = gets.chomp
      break if @game_mode == "1" || @game_mode == "2"
      puts warning_message("answer_error")
    end
    code_maker if @game_mode == "1"
    code_breaker if @game_mode == "2"
  end

  def code_maker
    maker = ComputerSolver.new("maker")
    maker.computer_start
  end
  
  def code_breaker
    breaker = HumanSolver.new("breaker")
    breaker.player_turns
  end  

end