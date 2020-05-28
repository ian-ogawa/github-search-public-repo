Rails.application.routes.draw do
	root 'github_pages#index'
  # get 'github_pages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'search', :to => "github_pages#search"
end
