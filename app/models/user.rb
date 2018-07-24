class User < ActiveRecord::Base
  has_secure_password
  before_validation :downcase_email
  validates :first_name, :last_name, :email, :password_digest, presence: true
  validates :email, uniqueness: true, case_sensitive: false
  validates :password, :password_confirmation, presence: true, length: { minimum: 6 }

  def authenticate_with_credentials(email, password)
    if User.find_by(email: email.downcase.strip).try(:authenticate, password)
      @user = User.find_by_email(email.downcase.strip)
    else
      nil
    end
  end

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
