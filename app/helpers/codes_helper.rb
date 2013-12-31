module CodesHelper
  def hello_world(name)
    "hello #{name}"
    content_tag(:div, "Hello #{name}!")
  end
end
