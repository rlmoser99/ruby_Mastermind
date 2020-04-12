require_relative 'game.rb'
require_relative 'display.rb'
require_relative 'human_solver.rb'
require_relative 'computer_solver.rb'
require_relative 'game_logic.rb'

Game.new.play


# TO DO:
# 2 separate display modules - turn related vs. game logic display?
# keep game_end in the game class
# remove game logic module from game?
# remove @ from instance variables only used within method


# DONE:
# Move code into human solver ???
# move shared game logic into module
# include in both human & computer solver
# move code creation into human solver
# Game init and it kicks off play