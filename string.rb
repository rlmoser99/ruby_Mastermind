class String
  def red;            "\e[31m#{self}\e[0m" end
  def black;          "\e[30m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end
  
  def bold;           "\e[1m#{self}\e[22m" end
  def underline;      "\e[4m#{self}\e[24m" end
end



# print "  #{num}  ".bg_blue if num == "1"
# print "  #{num}  ".bg_green if num == "2"
# print "  #{num}  ".bg_magenta if num == "3"
# print "  #{num}  ".bg_cyan.black.bold if num == "4"
# print "  #{num}  ".bg_brown.black.bold if num == "5"
# print "  #{num}  ".bg_red.black.bold if num == "6"