class Code
  attr_accessor :numbers
  # def initialize
  #   num = Random.new
  #   @numbers = [num.rand(1..6), num.rand(1..6), num.rand(1..6), num.rand(1..6)]
  # end

  def initialize
    @numbers = []
    num = Random.new
    4.times {@numbers << num.rand(1..6).to_s}
  end

end

# Use shovel into array

# puts ""
# puts "Game Pieces:"
# print "  1  ".bg_red.bold
# print " "
# print "  2  ".bg_green.bold
# print " "
# print "  3  ".bg_blue.bold
# print " "
# print "  4  ".bg_magenta.bold
# print " "
# print "  5  ".bg_cyan.bold
# print " "
# print "  6  ".bg_gray.bold
# puts ""
# puts ""
# puts "Game Clues:"
# print " * ".bg_black.gray
# print " Correct Color & Correct Spot"
# puts ""
# print " ? ".reverse_color
# print " Correct Color"
# puts ""