Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects, only: [:create, :show ,:update, :destroy] do
    get 'name/:name', to: 'projects#show_by_name', on: :collection
  end
end
