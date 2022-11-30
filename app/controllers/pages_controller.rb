class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home sent]

  def home
  end

  def sent
    GetContributionsJob.perform_later
  end
end
