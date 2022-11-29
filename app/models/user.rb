class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_commit :async_update

  private

  def sync_update
    UpdateUserJob.perform_now(self)
  end

  def async_update
    UpdateUserJob.perform_later(self)
  end
end
