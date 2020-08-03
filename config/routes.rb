Rails.application.routes.draw do
  resources :technical_services
  scope '/occurrences' do
    get '/:service_station_id/new/', to: 'occurrences#new'
    get '/:service_station_id/index/', to: 'occurrences#index'
    get '/:event_id/report/', to: 'occurrences#report'
    get '/report_by_ome_and_date', to: 'occurrences#report_by_ome_and_date'
  end  
  resources :occurrences
  resources :service_stations
  get '/service_stations/:event_id/index', to: 'service_stations#index'
  get '/:service_station_id/get_available_intervals/:occurrence_nature_id', to: 'occurrences#get_available_intervals'
  
  resources :events
  scope '/events' do
    get '/:id/occurrence_amount_by_service_station', to: 'events#occurrence_amount_by_service_station'
    get '/:id/occurrence_amount_by_interval', to: 'events#occurrence_amount_by_interval'
  end
  resources :home, only: [:index]
  root to: 'home#index'
  post '/', to: 'home#index'
  get '/home/events/new', to: 'events#home_new'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, skip: [:registrations, :passwords]
  resources :users
  post '/password_update', to: 'users#password_update'
  
  resources :profiles

  resources :technical_services
  get 'qrcode_generate', to: 'technical_services#qrcode_generate'
  get 'qrcode_verify/:protocol', to: 'technical_services#qrcode_verify'
end
