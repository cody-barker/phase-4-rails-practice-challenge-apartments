Rails.application.routes.draw do
  resources :tenants do
    resources :apartments
  end
  resources :apartments do
    resources :tenants
  end
  resources :leases, only: [:create, :destroy]
end
