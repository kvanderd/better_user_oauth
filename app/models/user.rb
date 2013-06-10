

class User < ActiveRecord::Base


  attr_accessor :password

  before_create :encrypt_password

  validates_uniqueness_of :email
  validates :password, :length => { :in => 5..20 }, :confirmation => true
  validates :password_confirmation, :presence => true


  
  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user
      temp_encryption = Digest::SHA1.hexdigest("#{password}")
      user.password == temp_encryption ? user : nil
    else
      false
    end
  end

  def encrypt_password
    encrypted_password = Digest::SHA1.hexdigest("#{password}")
    self.password = encrypted_password
    password = nil
  end

end
