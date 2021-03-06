Rails.application.routes.draw do
  resources :timezones, only: [:index]
  resources :clocks, only: [:create, :destroy]
  root 'timezones#index'
  get '/set', to: 'timezones#set'
  get '/search', to: 'timezones#search', as: "search"
  get '/add/:city', to: 'clocks#add', as: "add"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
