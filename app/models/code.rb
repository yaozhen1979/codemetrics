class Code < ActiveRecord::Base
  validates :code_fmt, format: { with: /(rb|java|js|coffee)/,
    message: "upload file format error !!!" }
end
