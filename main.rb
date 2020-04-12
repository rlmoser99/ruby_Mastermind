require_relative 'game.rb'
require_relative 'code.rb'
require_relative 'display.rb'
# require_relative 'player.rb'
require_relative 'game_logic.rb'

Game.new.play



# include in both human & computer solver
# display logic into module
# turn related vs. game logic display? game display and turn display modules
# move code creation into human solver
# Game init and it kicks off play
# can i remove logic module from game?

# remove @ from instance variables only used within method

# Move code into human solver ???
# move shared game logic into module