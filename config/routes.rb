Rails.application.routes.draw do
  resources :blogs
  root 'blogs#index'
  devise_for :users
end
