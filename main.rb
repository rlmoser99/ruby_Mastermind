class String
  def gray;           "\e[37m#{self}\e[0m" end
  
  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end
  
  def bold;           "\e[1m#{self}\e[22m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

puts ""
puts "Game Pieces:"
print "  1  ".bg_red.bold
print " "
print "  2  ".bg_green.bold
print " "
print "  3  ".bg_blue.bold
print " "
print "  4  ".bg_magenta.bold
print " "
print "  5  ".bg_cyan.bold
print " "
print "  6  ".bg_gray.bold
puts ""
puts ""
puts "Game Clues:"
print " * ".bg_black.gray
print " Correct Color & Correct Spot"
puts ""
print " ? ".reverse_color
print " Correct Color"
puts ""
