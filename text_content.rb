module TextContent

  # def formatting (description, string)
  #   @text_formatting = {
  #     "underline" => "\e[4;1m#{string}\e[0m",
  #     "red" => "\e[31;1m#{string}\e[0m",
  #   }
  #   @text_formatting[description]  
  # end

  def formatting (description, string)
     {
      "underline" => "\e[4;1m#{string}\e[0m",
      "red" => "\e[31;1m#{string}\e[0m",
    }[description]  
  end
  
end