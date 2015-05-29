Rails.application.routes.draw do

  root 'welcome#index'
  resources :albums do
    resources :tracks do
      resources :comments
    end
  end

  get '/auth/twitter/callback', to: 'sessions#create'
end
