Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :projects do
        get '/search' => 'projects#search' , on: :collection
        resources :lost_person do
          post 'create_with_image', to: 'lost_person#create_with_image', on: :member
        end
      end
    end
  end
end
