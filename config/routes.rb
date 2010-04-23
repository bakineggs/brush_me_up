ActionController::Routing::Routes.draw do |map|
  map.resources :memos, :users, :user_sessions

  map.root :controller => :memos
end
