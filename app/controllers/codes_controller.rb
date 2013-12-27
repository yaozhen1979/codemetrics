require "rouge"

class CodesController < ApplicationController
  
  def index
    @message = 'hello rails'
  end

  def new
    @code = Code.new
  end

  def show
    
    @code = Code.find(params[:id])
    # make some nice lexed html
    source = File.read(Rails.root + @code.code_path)
    formatter = Rouge::Formatters::HTML.new({:css_class => 'highlight', :line_numbers => true, :wrap => true})
    lexer = Rouge::Lexers::Shell.new
    # @code_css = Rouge::Themes::ThankfulEyes.render(:scope => '.highlight')
    @code_content = formatter.format(lexer.lex(source))

  end

  def create

    # @book = Book.new(params[:book].permit(:title, :sub_title, :author, :publish_date))
    # debugger
    # @code = Code.new(code_params)
    @code = Code.new

    # 
    upload_path = upload
    set_code_file_path(upload_path)

    logger.info "saveing..."

    if @code.save
      redirect_to @code
    else
      render 'new'
    end
  end

  private
    def code_params
      # logger.info "upload code file name:" + params[:code][:code_file].to_s
      # params.require(:code).permit(:code_file)
    end

  private
    def upload
      logger.info "uploading file..." 
      uploaded_io = params[:code][:code_file]

      # 
      @code.code_name = uploaded_io.original_filename
      @code.code_fmt = uploaded_io.original_filename.split(".")[1]

      # 單檔上傳
      if !uploaded_io.nil?
        File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file| 
          file.write(uploaded_io.read)
        end
        logger.info "uploading file path:" + "public/uploads/" + uploaded_io.original_filename
        upload_path = "public/uploads/" + uploaded_io.original_filename
      end
    end

  private
    def set_code_file_path (upload_path)
      if upload_path.to_s.strip.length != 0
        @code.code_path = upload_path
      end
    end

end
