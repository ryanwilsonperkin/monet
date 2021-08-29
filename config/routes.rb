Rails.application.routes.draw do
  resources :vendors
  resources :transactions, except: [:new, :create, :delete] do
    collection do
      get 'edit_vendors'
      put 'update_vendors'
    end
  end
  resources :credit_card_statements, except: [:edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
