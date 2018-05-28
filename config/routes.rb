Rails.application.routes.draw do
  resources :holdings
  resources :portfolios
  resources :stocks
  resources :industries
  resources :sectors
  get 'welcome/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'welcome#index'
end
