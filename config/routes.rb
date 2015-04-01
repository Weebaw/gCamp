
Rails.application.routes.draw do

   root 'welcome#index'

   get '/terms' => 'terms#index'

   get '/about' => 'about#index'

   get '/faq' => 'common_questions#index'

   resources :users




   resources :projects do
     resources :tasks do
       resources :comments
     end
     resources :memberships
   end

   get "/sign-up" => "registrations#new"
   post "/sign-up" => "registrations#create"
   get "/sign-out" => "authentication#destroy"
   get "sign-in" => "authentication#new"
   post "sign-in" => "authentication#create"

   resources :tracker_projects, only: [:show]


end
