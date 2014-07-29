EventReg::Application.routes.draw do

  namespace :catalogs do
    resources :participants
    get 'participants/list/:course_id' => 'participants#list', as: 'participants_list'
    get 'participants/confirm_participant/:id' => 'participants#confirm_participant', as: 'confirm_participant'
  end

  namespace :public do
    get 'events_courses/index'
    get 'events_courses/event_info/:id' => 'events_courses#event_info', as: 'event_info'
    get 'events_courses/registration/:course_id' => 'events_courses#new_participant', as: 'registration'
    post 'events_courses/create_participant' => 'events_courses#create_participant', as: 'create_participant'
    get 'events_courses/registration_done/:id' => 'events_courses#registration_done', as: 'registration_done'
  end

  namespace :catalogs do
    resources :courses
    get 'courses/preview/:id' => 'courses#preview', as: 'course_preview'
    get 'courses/download_file/:filename' => 'courses#download_file',
        as: 'course_download_file',
        constraints: { :filename => /[^\/]+i(?=\.html\z|\.json\z)|[^\/]+/, :name => /[^\/]+i(?=\.html\z|\.json\z)|[^\/]+/  }
    get 'courses/change_owner/:id' => 'courses#change_owner', as: 'course_change_owner'
    post 'course/update_owner' => 'courses#update_owner', as: 'course_update_owner'
  end

  devise_for :devise_users
  namespace :admin do
    resources :users
    get 'users/delete/:id' => 'users#delete', as: 'delete_user'
    
    get 'system_config' => 'system_configs#index'
    post 'system_config/update' => 'system_configs#update'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'catalogs/courses#index'

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
