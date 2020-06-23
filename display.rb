# frozen_string_literal: true

# module with display information for game
module Display
  def code_colors(number)
    {
      '1' => "\e[101m  1  \e[0m ",
      '2' => "\e[43m  2  \e[0m ",
      '3' => "\e[44m  3  \e[0m ",
      '4' => "\e[45m  4  \e[0m ",
      '5' => "\e[46m  5  \e[0m ",
      '6' => "\e[41m  6  \e[0m ",
    }[number]
  end

  def clue_colors(clue)
    {
      '*' => "\e[91m\u25CF\e[0m ",
      '?' => "\e[37m\u25CB\e[0m "
    }[clue]
  end

  def show_code(array)
    array.each do |num|
      print code_colors num
    end
  end

  def show_clues(exact, same)
    print '  Clues: '
    exact.times { print clue_colors('*') }
    same.times { print clue_colors('?') }
    puts ''
  end
end
