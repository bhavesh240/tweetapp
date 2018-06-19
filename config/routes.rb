Rails.application.routes.draw do
  get 'welcome/index'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'} 
    
    resources :posts do
      resources :comments
      get 'verify_post',on: :member 
    end

  root 'welcome#index'

end
