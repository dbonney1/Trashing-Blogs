Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users do
    member do
      get :subscribed_to, :subscribers
    end
    resources :profiles
  end
  get 'welcome/index'
  
  resources :subscriptions, only: [:create, :destroy, :show, :index]
  
  resources :articles do
    resources :comments
    resources :abuse_reports
    resources :likes
  end
  
  
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/tagged', to: "articles#tagged", as: :tagged
  
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
