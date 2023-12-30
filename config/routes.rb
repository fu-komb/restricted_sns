Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations',
  }

  namespace :auth do
    resources :sessions, only: %i[index]
  end

  resources :home, :only => [:index]

  resources :post, :only => [:index, :create] do
    collection do
      get :timeline
    end
  end

  post '/user/follow', to: 'user#follow'
  delete '/user/unfollow', to: 'user#unfollow'
  post '/user/block', to: 'user#block'
  delete '/user/unblock', to: 'user#unblock'
end
