# frozen_string_literal: true

require_relative 'game.rb'
require_relative 'display.rb'
require_relative 'human_solver.rb'
require_relative 'computer_solver.rb'
require_relative 'game_logic.rb'
require_relative 'text_content.rb'
require_relative 'text_instructions.rb'

Game.new.play
