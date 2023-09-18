Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'welcome#index'

  get "reservation/index", to: "reservation#index"
  post "update_seat_state", to: "seat#update_state"
  post "create_reservation", to: "seat#create_reservation"
  post '/reset_all_seats', to: 'seat#reset_all_seats'
  delete '/delete_all_reservations', to: 'reservation#delete_all_reservations'

  mount ActionCable.server => "/cable"
end
