require_relative 'game.rb'
require_relative 'display.rb'
require_relative 'human_solver.rb'
require_relative 'computer_solver.rb'
require_relative 'game_logic.rb'
require_relative 'text_content.rb'
require_relative 'text_instructions.rb'

Game.new.play


# TO DO:
# remove @ from instance variables only used within method
# Make different "computer_won" messages depending on the number of guesses
# Create "turn_order" method and put all methods in one place for computer_solver. 
# Could it work for human_solver too. ??
# Computer Solver - when code has duplicate numbers, there will be duplicate permutations. Remove them.


# DONE:
# Move code into human solver ???
# move shared game logic into module
# include in both human & computer solver
# move code creation into human solver
# Game init and it kicks off play
# keep game_end in the game class
# 2 separate display modules - turn related vs. game logic display?
# remove game logic module from game?