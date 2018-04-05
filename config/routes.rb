Rails.application.routes.draw do
  resources :instruments
  devise_for :users, conrollers: {
    registrations: 'registrations'
  }
  root 'instruments#index'
end
