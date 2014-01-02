class Code < ActiveRecord::Base

  self.per_page = 5

  validates :code_fmt, format: { with: /(rb|java|js|coffee)/,
    message: "upload file format error !!!" }
    
end
