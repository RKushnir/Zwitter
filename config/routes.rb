ActionController::Routing::Routes.draw do |map|
  map.resources :records
  map.resources :categories, :has_many => :records

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create', :method=>:post
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.root :controller => 'home'
  map.home '/today', :controller => 'home', :action => 'day'
  map.settings '/settings', :controller => 'users', :action => 'edit'
  map.year_chart '/period/:year/chart', :controller => 'home', :action => 'year_chart'
  map.year '/period/:year', :controller => 'home', :action => 'year'
  map.month_chart '/period/:year/:month/chart', :controller => 'home', :action => 'month_chart'
  map.month '/period/:year/:month', :controller => 'home', :action => 'month'
  map.day '/period/:year/:month/:day', :controller => 'home', :action => 'day'
  map.range_chart '/from/:start_year/:start_month/:start_day/to/:end_year/:end_month/:end_day/chart', :controller => 'home', :action => 'range_chart'
  map.range '/from/:start_year/:start_month/:start_day/to/:end_year/:end_month/:end_day', :controller => 'home', :action => 'range'
  map.reports '/reports', :controller => 'home', :action => "range", :start_year => Date.today.year, :start_month => Date.today.month, :start_day => Date.today.mday, :end_year => 1.day.from_now(Date.today).year, :end_month => 1.day.from_now(Date.today).month, :end_day => 1.day.from_now(Date.today).mday

  map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
