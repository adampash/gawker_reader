Rails.application.routes.draw do
  get 'reports/politburo'

  get 'reports/index'

  get 'admin/index'

  get 'comments/create'

  get 'reports/politburo/:site' => 'reports#politburo', as: :build_report
  get 'reports' => 'reports#index'
  get 'reports/:site' => 'reports#index', as: :report
  post 'reports/comment' => 'reports#comment'
  get 'reports/:site/:month' => 'reports#show', as: :show_report
  post 'reports/publish/:id' => 'reports#publish', as: :publish_report
  get 'reports/politburo/:site/:month' => 'reports#build', as: :build_new_report

  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  get 'admin' => 'admin#index', as: :admin
  post 'admin/toggle/:user_id' => 'admin#toggle'
  get 'posts/submit' => 'posts#submit'
  resources :posts
  resources :comments
  post 'comments/pin/:id' => 'comments#pin'
  get 'logout' => 'users#logout', as: :user_logout
  get 'dashboard' => 'pages#dashboard', as: :dashboard
  get 'setup' => 'pages#setup', as: :setup
  get ':site' => 'posts#index', as: :site
  get 'posts/preview/:id' => 'posts#preview', as: :preview
  root 'pages#welcome'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
