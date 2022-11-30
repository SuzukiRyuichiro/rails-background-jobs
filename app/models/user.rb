class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_commit :async_update
  # after_create :send_welcome_email

  private

  def sync_update
    UpdateUserJob.perform_now(self)
  end

  def async_update
    UpdateUserJob.perform_later(self)
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
