ActionController::Routing::Routes.draw do |map|
  map.resources :memos

  map.root :controller => :memos
end
