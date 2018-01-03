Rails.application.routes.draw do
  get 'static_page/main'
  post 'static_page/search'
  get 'reservation/new'

  get 'reservation/edit'

  get 'reservation/index'

  get 'reservation/show'

  get 'reservation/checkin'

  get 'reservation/checkout'

  get 'reservation/destroy'
  delete 'reservation/destroy'

  get 'appl/rnew'
  post 'appl/rnew', to: 'appl#rcreate'
  get 'appl/cnew'
  post 'appl/cnew', to: 'appl#ccreate'
  get 'appl/show'
  get 'appl/index'
  delete 'appl/destroy'

  get 'client/new'
  get 'client/show'
  get 'client/edit'
  post 'client/new', to: 'client#create'
  delete 'client/destroy'

  get 'worker/new'
  post 'worker/new', to: 'worker#create'
  get 'worker/show'
  delete 'worker/destroy'

  root 'user#index'
  get 'sessions/new'
  post 'sessions/new', to: 'sessions#create'
  get 'sessions/create'
  get 'sessions/destroy'
  delete 'sessions/destroy', to: 'sessions#destroy'

  get 'user/new'
  post 'user/new', to: 'user#create'
  get 'user/create'

  get 'user/destroy'

  get 'user/index'

  get 'user/show'

  get "/signup", to: "user#new"
  post "signup", to: "user#create"
  resources :user
  get "/signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  delete "signout", to: "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
