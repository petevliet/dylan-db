Rails.application.routes.draw do

  root 'welcome#index'
  get '/albums/:album_id/tracks/:track_id/comments/new' => 'tracks#new_comment', :as => :new_comment
  resources :albums, only: [:index, :show] do
    resources :tracks, only: [:index, :show] do
      resources :comments
    end
  end

  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
