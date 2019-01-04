Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    match "/auth/:provider/callback", to: "sessions#create",via: [:get, :post]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  get 'items/seach', to: 'items#search'
  get 'mypage' => 'users#mypage'
  get 'mypage/card' => 'users#card'
  get 'mypage/card/add' => 'users#add'
  get 'mypage/profile' => 'users#profile'
  get 'mypage/identification', to: 'users#identification'
  get 'mypage/favorite', to: 'users#favorite'
  get 'users/signup', to: 'users#signup'
  get 'users/logout', to: 'users#logout'
  get 'users/registration_card' => 'users#registration_card'
  resources :items, only: [:new, :show, :create, :destroy, :edit, :update] do
    resources :comments, only: [:create , :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  resources :transaction, only: [:new]
  get 'mypage/identification', to: 'users#identification'
  resources :categories, only: [:index, :show] do
    collection do
      get 'size_brand'
    end
  end
  resources :postage_selects, only: [:index]
  post 'items/upload_image', to: 'items#upload_image'

end
