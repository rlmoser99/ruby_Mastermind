def colorify_white (number)
  @backgrounds = {
    "1" => 44,
    "2" => 42,
    "3" => 45,
    "4" => 46,
    "5" => 43,
    "6" => 41
  }
  # This line works
  # return "\e[97m\e[#{@backgrounds[number]}m  #{number}  \e[0m"
  # So does this line:
  return "\e[#{@backgrounds[number]}m  #{number}  \e[0m"
  
end

def colorify_black (number)
  @backgrounds = {
    "1" => 44,
    "2" => 42,
    "3" => 45,
    "4" => 46,
    "5" => 43,
    "6" => 41
  }
  # This produces all 6 colors with black BOLD text
  return "\e[30;1m\e[#{@backgrounds[number]}m  #{number}  \e[0m"
  
end

# puts colorify_white("1")
# puts colorify_white("2")
# puts colorify_white("3")
# puts colorify_white("4")
# puts colorify_white("5")
# puts colorify_white("6")

# puts colorify_black("1")
# puts colorify_black("2")
# puts colorify_black("3")
# puts colorify_black("4")
# puts colorify_black("5")
# puts colorify_black("6")

# def color
#   @color_code = {
#     "1" => "\e[44m#{number}\e[0m",
#     "2" => "\e[42m#{number}\e[0m",
#     "3" => "\e[45m#{number}\e[0m",
#     "4" => "\e[46m#{number}\e[0m",
#     "5" => "\e[47m#{number}\e[0m",
#     "6" => "\e[41m#{number}\e[0m"
#   }
# end