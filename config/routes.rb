Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :houses, only: %i{create show} do
    collection do
      get :manage
    end
  end
  resources :house_members, only: %i[create destroy]
  resource :current_houses, only: [] do
    member do
      post :set
    end
  end
end