class Admin < ActiveRecord::Base

  # make bcyrt availible..
  include BCrypt

  def password
    @password ||= Password.new(self.password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # def get_password_hash
  #   return self.password_hash
  # end
  #
  # def test_password_hash(password)
  #   new_hash = Password.create(password)
  #   puts "pw comparison"
  #   puts new_hash
  #   puts self.password
  #   if (self.password == new_hash)
  #     return true
  #   end
  #   return false
  # end

end
