Ticketapp::Application.routes.draw do
  root to: "sessions#new"

  resources :users, only: [:create, :new]
  resource :session, only: [:create, :new, :destroy]
  resources :tickets
end
