require "rouge"
require "code_statistics_calculator.rb"

class CodesController < ApplicationController
  
  def index

    @message = 'hello rails'
    logger.debug "query params:" + params.inspect

    if params[:code_name].nil?
      @codes = Code.all
    else
      # TODO:sql injection ???
      @codes = Code.where("code_name like ?", '%' + params[:code_name].strip + '%')
    end

  end

  def new
    @code = Code.new
  end

  def show
    
    @code = Code.find(params[:id])
    # make some nice lexed html
    path = Rails.root + @code.code_path
    source = File.read(path)
    formatter = Rouge::Formatters::HTML.new({:css_class => 'highlight', :line_numbers => true, :wrap => true})
    lexer = Rouge::Lexers::Shell.new
    # @code_css = Rouge::Themes::ThankfulEyes.render(:scope => '.highlight')
    @code_content = formatter.format(lexer.lex(source))

    # 
    @stat = calculate_directory_statistics(path)
    logger.debug "Code stats:" + @stat.inspect

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
      debugger
      redirect_to @code
    else
      render 'new'
    end
  end

  def destroy
    @code = Code.find(params[:id])
    @code.destroy
    redirect_to codes_path
  end

  # TODO:refactor ???
  def ajax_query
    
    logger.info "ajax test"
    logger.info "params[:code_name]" + params[:code_name]
    options = {}
    # 
    find_options = { 
          :conditions => [ "LOWER(codes.code_name) LIKE (?)", '%' + params[:code_name].downcase + '%' ], 
          :order => "codes.id ASC",
          :limit => 10 }.merge!(options)

    @ajax_codes = Code.find(:all, find_options)

    render json: @ajax_codes
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

      @code.code_name = uploaded_io.original_filename
      # @code.code_fmt = uploaded_io.original_filename.split(".")[1]
      @code.code_fmt = File.extname(uploaded_io.original_filename).sub(/\A\./, '').downcase

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

  public
    def calculate_directory_statistics(path, pattern = /.*\.(rb|js|coffee|java)$/)
      stats = CodeStatisticsCalculator.new
      stats.add_by_file_path(path)
      stats
    end

end

# test = CodesController.new
# aaa = test.calculate_directory_statistics("welcome_controller.rb")
# puts aaa.lines
