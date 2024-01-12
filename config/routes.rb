Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/auth', to: 'sessions#create'
      resources :projects do
        get '/search', to: 'projects#search' , on: :collection
        resources :lost_items
        # TODO: master確認しましたが、ここなくなっていますので追加して下さい
      end
    end
  end
end
