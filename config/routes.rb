RpiaRfidRails::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  
  get "/users/:id/edit_card_details", to: "users#edit_card_details", as: "edit_card"
  post "/users/:id/edit_card_details", to: "users#update_card_details", as: "update_card"
  
  match '/authenticate/:facility_code/:id_code', to: 'users#authenticate', via: [:get, :post]
end
