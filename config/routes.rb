require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get	'/login',	to: 'sessions#new'
	post	'/login',	to: 'sessions#create'
	delete	'/logout',	to: 'sessions#destroy'
	
	resources :servers, 	only: [:index, :show]
	resources :problems, 	only: [:index]
	resources :users, 	only: [:index, :show, :new, :create]

	#Sidekiq ui
	mount Sidekiq::Web => '/sidekiq'
end
