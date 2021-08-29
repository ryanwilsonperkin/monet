Rails.application.routes.draw do
  root to: 'reports#index'
  namespace :reports do
    get 'monthly', as: 'monthly_redirect', status: 302, to: redirect { "reports/monthly/#{Date.current.year}/#{Date.current.month}" }
    get 'monthly/:year/:month', action: 'monthly', as: 'monthly'
    get 'yearly', as: 'yearly_redirect', status: 302, to: redirect { "reports/yearly/#{Date.current.year}" }
    get 'yearly/:year', action: 'yearly', as: 'yearly'
    get 'vendors', action: 'vendors', as: 'vendors'
  end
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
