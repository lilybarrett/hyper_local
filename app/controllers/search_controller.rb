class SearchController < ApplicationController
  def index
    @opportunities = Opportunity.all
    if params[:city_query].present?
      @opportunities = @opportunities.search_by_city(params[:city_query])
    end

    if params[:cause_query].present?
      @opportunities = @opportunities.search_by_cause(params[:cause_query])
    end

    if params[:city_query].blank? && params[:cause_query].blank?
      @opportunities = @opportunities.none
    end

    flash[:notice] = "No results." unless @opportunities.any?
  end
end
