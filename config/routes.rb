VitalWatcher::Application.routes.draw do
  resources :event_types
  resources :activity_types

  resources :users
  resources :heart_rate_types

  resources :recover_passwords, :except => [:index, :show, :destroy] 
  
  resources :sessions, :only => [:new, :create, :destroy] do
    collection do
      post :authenticate
    end
  end

  resources :devices, :only => [:new, :create, :destroy] do
    member do
      get :show_user
    end
  end

  resources :heart_rate_summaries, :only => [:show] do
    member do
      get :show_user
    end
  end

  resources :activities, :only => [:show] do
    member do
      get :show_user
    end
  end  

  resources :events, :only => [:show] do
    member do
      get :show_user
    end
  end

  resources :marshalling, :only => [:index]

  match '/signup',                  :to => 'users#new'
  match '/signin',                  :to => 'sessions#new'
  match '/signout',                 :to => 'sessions#destroy'
  
  match '/configurations',          :to => 'pages#configurations'
  match '/about',                   :to => 'pages#about'
  match '/not_enough_privileges',   :to => 'pages#not_enough_privileges'

  root :to => 'pages#home'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
