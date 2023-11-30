Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :projects do
        get '/search' => 'projects#search' , on: :collection
        resources :lost_items do
          post 'create_with_image', to: 'lost_items#create_with_image', on: :member
        end
        resources :lost_person do
        end
      end
    end
  end
end
