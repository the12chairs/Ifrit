module ApplicationHelper

  def spoiler text
    "<span class='spoiler'>#{text}</span>"
  end

  
  def parser(text)
    text = auto_link(text)
    text = markdown(text)
    text.gsub! /%%(.+?)%%/, spoiler('\1')
    text = simple_format(text)
  end

end
