#/device/id/streams          - retorna ultimos 100
#/device/id/streams/date  - retorna ultimos 100 daquela data. mantendo no maximo 60 dias de histórico
#/device/id/streams/date/end_date - retorna os 100 ultimos registros do periodo informado *
# verificar com data e hora



Rails.application.routes.draw do

  root 'home#index'

  devise_for :users
  resources :devices do
    delete 'streams/delete' => 'devices#delete_streams'
  end

  namespace :v1 do
    post 'streams/new'
    get 'device/:id/streams' => 'streams#list', as: 'device_streams'
    get 'device/:id/streams/last' => 'streams#last', as: 'device_streams_last'
    get 'device/:id/streams/:date' => 'streams#list'
    get 'device/:id/streams/:date/:end_date' => 'streams#list'
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
