Spree::Core::Engine.routes.draw do
  match 'suggestions', :to => 'suggestions#index'
end
