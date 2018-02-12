class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :access, :contact, :jobs]

  def home
    if current_user
      redirect_to flats_path
    end
  end

  def about
  end

  def access
  end
end
