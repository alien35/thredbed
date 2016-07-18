Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'users/index'

  post ':user_name/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':user_name/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications', to: 'notifications#index'
  get 'profiles/show'
  get 'profiles/index'
  get 'tags/:tag', to: 'posts#index', as: :tag

  devise_for :users, controllers: { registrations: 'registrations',
                                    sessions: 'sessions',
                                    passwords: 'passwords' }


  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :posts do
    resources :comments#, only: [:new,:create,:show,:edit,:update,:destroy]
  end
  resources :posts do
    resources :comments do
      resources :responses#, only: [:new,:create,:show,:edit,:update,:destroy]
    end
  end

  resources :posts do
    member do
      put 'like',   to: 'posts#like'
      put 'dislike', to: 'posts#dislike'
      put 'unlike',   to: 'posts#unlike'
    end
  end
  resources :posts do
    resources :comments do
      member do
        put 'like',   to: 'comments#like'
        put 'dislike', to: 'comments#dislike'
        put 'unlike',   to: 'comments#unlike'
      end
    end
  end

  resources :comments do
    resources :responses do
      member do
        put 'like',   to: 'responses#like'
        put 'dislike', to: 'responses#dislike'
        put 'unlike',   to: 'responses#unlike'
      end
    end
  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'posts#index'

  get ':user_name', to: 'profiles#show', as: :profile
  get ':user_name/edit', to: 'profiles#edit', as: :edit_profile
  patch ':user_name/edit', to: 'profiles#update', as: :update_profile
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
