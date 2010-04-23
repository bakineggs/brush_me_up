ActionController::Routing::Routes.draw do |map|
  map.resources :memos, :users

  map.root :controller => :memos
end
