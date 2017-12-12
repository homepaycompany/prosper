class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :access, :contact, :jobs]

  def home
  end

  def about
  end

  def access
  end

  def contact
  end

  def jobs
  end
end
