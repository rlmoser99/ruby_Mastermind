class Pin
  COLOR_CODES = {
    "1" => 44,
    "2" => 42,
    "3" => 45,
    "4" => 46,
    "5" => 43,
    "6" => 41
  }

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def background (number)
    return "\e[97m\e[#{COLOR_CODES[number]}m  #{number}  \e[0m"
  end

end

blue = Pin.new("blue")
puts blue.background("1")
green = Pin.new("green")
puts green.background("2")
magenta = Pin.new("magenta")
puts magenta.background("3")
cyan = Pin.new("cyan")
puts cyan.background("4")
brown = Pin.new("brown")
puts brown.background("5")
red = Pin.new("red")
puts red.background("6")

# def red()
#   return "\e[31m#{self}\e[0m"
# end

# def underline
#   print "\e[4mCodemaker\e[0m"
# end

