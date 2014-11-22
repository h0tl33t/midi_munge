Rails.application.routes.draw do
  root 'midis#new'

  resources :midis, only: [:new, :create, :show]
end
