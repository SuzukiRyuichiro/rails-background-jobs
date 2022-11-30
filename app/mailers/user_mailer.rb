class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @user = params[:user]
    @greeting = "Hi"

    mail to: @user.email, subject: 'Welcome to Le Wagon'
  end

  def contribution
    @students = params[:students]

    mail to: "dragon.aka.scooter@gmail.com", subject: "This month's contribution"
  end
end
