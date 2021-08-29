Rails.application.routes.draw do
  resources :vendors
  resources :transactions, only: [:index, :show]
  resources :credit_card_statements, except: [:edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
