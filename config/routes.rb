Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:        'admins/sessions',
    passwords:       'admins/passwords',
    registrations:   'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  namespace :public do
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :customers, only: [:show, :edit, :update] do
      get '/quit' => 'customers#quit'
      patch '/out' => 'customers#out'
    end
    resources :orders, only: [:new, :index, :create, :show] do
      get '/thanks' => 'orders#thanks'
      post '/info' => 'orders#info'
    end
  end

  namespace :admin do
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end

  get '/admin' => 'admin/homes#top'
  get '/' => 'public/homes#top'
  get '/about' => 'public/homes#about'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
