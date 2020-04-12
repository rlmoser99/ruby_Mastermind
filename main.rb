require_relative 'game.rb'
require_relative 'code.rb'
require_relative 'display.rb'
require_relative 'player.rb'

Game.new.play

# Move code into human solver
# move shared game logic into module
# include in both human & computer solver
# display logic into module
# turn related vs. game logic display? game display and turn display modules
# move code creation into human solver

# remove @ from instance variables only used within method
