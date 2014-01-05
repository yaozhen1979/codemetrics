require "fileutils"

class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password

  # 
  after_save :create_and_update_user_directory

  # 
  after_destroy :ensure_an_admin_remains, :destroy_user_directory

  private
    
    def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last user"
      end
    end

    def create_and_update_user_directory
      FileUtils.mkdir_p Rails.root + "public/#{self.name}"
    end

    def destroy_user_directory
      FileUtils.rmtree Rails.root + "public/#{self.name}"
    end

end