Ccf::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources 'staff', only: [:index]

  namespace 'admin' do
    resources 'staff' do
      member do
        put 'up'
      end
      collection do
        put 'reset_sort'
      end
    end
    root to: 'admin#index'
  end
  root to: 'home#index'
end
