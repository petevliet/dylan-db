Rails.application.routes.draw do

  root 'welcome#index'
  resources :albums do
    resources :tracks
  end
end
