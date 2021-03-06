Rails.application.routes.draw do
  root 'albums#index'
  
  devise_for :users
    
  resources :albums do
    resources :pictures
    patch '/album/:album_id/pictures/destroy_multiple' => 'pictures#destroy_multiple', as: 'destroy_multiple_pictures' 
  end
  get '/restore/:id'=>'albums#restore', as: 'restore_album'
  get '/really_destroy/:id'=>'albums#really_destroy', as: 'really_destroy_album'
  resources :tags 



  # post '/album/:album_id/pictures/destroy_multiple' => 'albums#destroy_multiple', as: 'destroy_multiple_pictures' 
  # get '/album/:album_id/pictures/destroy_multiple' => 'albums#destroy_multiple_show', as: 'destroy_multiple_pictures_show' 
  
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
