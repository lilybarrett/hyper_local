class HomeController < ApplicationController
  def show
    @causes = Cause.all
  end
end
