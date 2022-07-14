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
  get '/' => 'public/homes#top'
  get '/about' => 'public/homes#about'

  resources :items, only: [:index, :show]

  namespace :admin do
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
