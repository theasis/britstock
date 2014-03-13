Britstock::Application.routes.draw do
  resources :markers

  resources :caches

  controller :sessions do
    get 'login' => :new
    get 'login2' => :new2
    get 'paypalreturn' => :createpaypal
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :administrators
  get "paypalredirect2" => "static_pages#help"

  get "about" => "static_pages#about"
  get "privacypolicy" => "static_pages#privacypolicy"
  get "useragreement" => "static_pages#useragreement"
  get "help" => "static_pages#help"
  get "faq" => "static_pages#faq"
  get "contact" => "static_pages#contact"
  get "success" => "static_pages#success"

  get "client/location"
  get "client/show"
  resources :lightboxes

  get "client/index"
  resources :photographers
  get "application", to: "photographers#application"
  get "application_sent", to: "photographers#application_sent"
  post "application", to: "photographers#apply"

  get "client/:id", to: "client#show"
  get "client/istocklightbox/:lbid", to: "client#istocklightbox"

  get "photog/:id", to: "client#show"
  get "client/photog/:id", to: "client#show"
  get "artist/:id", to: "client#show"

  get "location/", to: "client#location"

#  get "admin/", to: "admin#index"
#  post "admin/new", to: "admin#new"
  get "admindone/", to: "client#done"


  root 'client#location', as: 'locat'

  resource :session

#  root to: 'photographers#index'
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
