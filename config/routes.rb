Rails.application.routes.draw do
  resources :favorites
  resources :direct_messages
  resources :tweets
  resources :follows
  resources :authors
  resources :users do
    member do
      get 'follow'
      get 'follower'
      get 'direct_message'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :practice

end
