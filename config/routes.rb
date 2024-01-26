Rails.application.routes.draw do
  resources :products
  
  resources :categories do 
    resources :products
  end
  
  root 'categories#index'


  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
