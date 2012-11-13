Dixit::Application.routes.draw do
  match 'home' => 'home#index'

  resources :users
  resources :friendships
  resources :games
  resources :pictures

  match "home/show" => "home#show",:as => :home_show
  match "games/(:id)/invite" => "games#invite", :via => :post, :as => :game_invite

  match 'friendships/(:id)' => 'friendships#show', via: :post
  match 'friendship/create' => 'friendships#create', via: :post

  resources :sessions, only: [:new, :create, :destroy]
  match "auth/(:provider)/callback" => "sessions#create_auth"

  match 'signup',  to: 'users#new'
  match 'signin',  to: 'sessions#new'
  match 'signout', to: 'sessions#destroy', via: :delete

  devise_for :admins, :skip => [:sessions]

  as :admin do
    get 'admins/sign_in' => 'devise/sessions#new', :as => :new_admin_session
    post 'sessions/admin' => 'devise/sessions#create', :as => :admin_session
    delete 'admins/sign_out' => 'devise/sessions#destroy', :as => :destroy_admin_session
  end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root :to => 'home#index'

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
  # match ':controller(/:action(/:id))(.:format)'
end
