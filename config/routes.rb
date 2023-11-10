Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :create, :show ,:update, :destroy] do
        get '/search' => 'projects#search'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index]
    end
  end
end
