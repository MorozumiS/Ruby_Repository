Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects, only: [:create, :show ,:update, :destroy] do
    get '/search' => 'projects#name_search', on: :collection
  end
end
