Rails.application.routes.draw do
  namespace :admin do
    resources :users do
      resource :balance, only: [:create]
    end
  end

  namespace :api do

    resources :products, only: [:index, :show]

    resource :user, only: [:create, :update]

    resource :session, only: [:create, :destroy]

    resources :purchases, only: [:index, :show, :create]
    resource :purchase, only: [:show, :create, :update, :destroy]
    # match '/purchases/drop' => 'purchases#destroy', via: :post

    resources :orders, only: [:index, :show, :create, :update] do
      resource :payment, only: [:create]
    end

    resources :gift_certificates, only: [:index, :show, :create, :destroy]

    resource :gift_certificates do
      resource :generate, only: [:create]
    end
    #   collection do
    #     post 'generate'
    #   end
    # end

    # match '/profile/balance' => 'users#update', via: :patch

    # resource :profile do
    #   member do
    #     patch 'balance'
    #   end
    # end


    # match '/gift_certificates/generate' => 'gift_certificates#create', via: :post
# match '/orders/:id/payment' => 'payment#create', via: :post
  end
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
