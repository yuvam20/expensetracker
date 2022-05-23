Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/admin' ,to: 'admins#index'
  get '/admin/login' ,to:'admins#login'
  post 'admin/signin' ,to:'admins#sessions'
  get '/destroy',to:'admins#destroy'
  get 'admin/show/:id',to: 'admins#show'
  get 'admin/newemp',to:'admins#signup'
  post '/admin/sign',to:'admins#create'
  get '/admin/search/:id',to: 'admins#search'
  get 'admin/accept/:id',to:'admins#accept'
  get 'admin/reject/:id',to:'admins#reject'
  post '/admin/comment',to:'admins#comment'
  get 'admin/fetch',to: 'admins#fetchingapi'
<<<<<<< HEAD
  get 'admins/show_image/:id',to:'admins#show_image'
=======
  get 'admins/show_image',to:'admins#show_image'
  get 'admin/expenses',to:'admins#expenses'
>>>>>>> main

  # User routes
  get 'users' ,to: 'users#index'
  get 'users/login',to:'users#login'
  post 'users/sign',to:'users#loggedin'
  get 'users/destroy',to:'users#destroy'
  get '/users/expenses',to: 'users#expenses'
  post '/users/handler',to: 'users#handler'
  get 'users/accepted',to:'users#accepted'
  get 'users/rejected',to:'users#rejected'
  get '/users/search/:id' ,to: 'users#search'
  post '/users/comment',to: 'users#comment'
  post '/admin/searchmethod',to:'admins#searchmethod'

end
