class SearchController < ApplicationController
  def index
    if params[:query]
      @opportunities = Opportunity.where("city ILIKE ?", "%#{params[:query]}%")
    end

    if @opportunities.empty? || params[:query].empty?
      flash[:notice] = "Sorry, no results."
    end
  end
end
