require "rouge"
require "erb"

# build data class

class Listings

  attr_reader :html

  def initialize( html = "" )
    @html = html
  end

  def build(file_path)

    # make some nice lexed html
    source = File.read(file_path)

    # formatter = Rouge::Formatters::HTML.new({:css_class => 'highlight', :line_numbers => false, 
    #   :inline_theme => Rouge::Themes::ThankfulEyes.new, :wrap => true})
    
    formatter = Rouge::Formatters::HTML.new({:css_class => 'highlight', :line_numbers => true, :wrap => true})
    
    lexer = Rouge::Lexers::Shell.new
    body_content = formatter.format(lexer.lex(source))

    # Get some CSS
    # css_content = Rouge::Themes::ThankfulEyes.render(:scope => '.highlight')
    # Base16::Solarized
    css_content = Rouge::Themes::ThankfulEyes.render(:scope => '.highlight')

    b = binding
    # create and run templates, filling member data variables
    ERB.new(<<-'END_HTML'.gsub(/^\s+/, ""), 0, "", "@html").result b
    <!doctype html>
    <html lang="en">
    <head>
    <title>Document</title>
    <style type="text/css">
      <%= css_content %>
    </style>
    </head>
    <body>
    <%= body_content %>
    </body>
    </html>

    END_HTML

  end
end

# setup template data
listings = Listings.new
listings.build('rouge_hello_world.rb')

puts listings.html
