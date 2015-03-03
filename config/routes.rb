Rails.application.routes.draw do

   root 'welcome#index'

   get '/terms' => 'terms#index'

   get '/about' => 'about#index'

   get '/faq' => 'common_questions#index'

   resources :tasks

   resources :users

   resources :projects

   get "/sign-up" => "registrations#new"
   post "/sign-up" => "registrations#create"
   get "/sign-out" => "authentication#destroy"


end
