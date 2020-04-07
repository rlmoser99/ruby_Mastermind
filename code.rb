class Code
  attr_accessor :numbers

  def initialize
    @numbers = []
    num = Random.new
    4.times {@numbers << num.rand(1..6).to_s}
  end

end