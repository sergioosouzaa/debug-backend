class Employee < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }  
  validates :email, presence: true, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }

  before_create :downcase_email

  private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end
end 