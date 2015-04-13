Rails.application.routes.draw do

  devise_for :users
  root 'welcome#main'
  
  get '/results', to: 'welcome#results', as: 'results'
  get '/contact', to: 'welcome#contact', as: 'contact'
  
  
  resources :skills

  resources :users do 
    resources :experiences
    resources :reviews
  end
    
 end
