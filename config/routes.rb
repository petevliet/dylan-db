Rails.application.routes.draw do

  root 'welcome#index'
  get '/albums/:album_id/tracks/:track_id/comments/new' => 'tracks#new_comment', :as => :new_comment
  resources :albums do
    resources :tracks do
      resources :comments
    end
  end

  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
