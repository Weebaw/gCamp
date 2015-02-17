Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

   get '/terms' => 'terms#index'

   get '/about' => 'about#index'

   get '/faq' => 'common_questions#index'

   resources :tasks

   resources :users
   


end
