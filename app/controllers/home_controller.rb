class HomeController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:index]
  skip_load_and_authorize_resource
  skip_before_action :verify_authenticity_token, only: [:index]

  def index
    city_ids = Event.all_city_ids_that_have_event
    @cities = Sac::City.has_event(city_ids)
  end

end
