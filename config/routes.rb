Rails.application.routes.draw do

  devise_for :users
  root 'welcome#main'
  
  get '/results', to: 'welcome#results', as: 'results'
  get '/search', to: 'welcome#search', as: 'search'
  get '/about', to: 'welcome#about', as: 'about'
  get '/help', to: 'welcome#help', as: 'help'
  get '/howto', to: 'welcome#howto', as: 'howto'
  get '/contact', to: 'welcome#contact', as: 'contact'
  get '/termsandconditions', to: 'welcome#termsandconditions', as: 'termsandconditions'
  
  resources :skills

  resources :users do 
    resources :experiences, only: [:new, :create, :edit, :update, :destroy]
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  end
    
 end
