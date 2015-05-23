class Volunteer < ActiveRecord::Base


  # make bcyrt availible..
  include BCrypt

  def password(password)
    @password = password  Password.new(self.password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
