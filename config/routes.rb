Ccf::Application.routes.draw do
  devise_for :users
  resources 'staff'
  namespace 'admin' do
    resources 'staff'
    root to: 'admin#index'
  end
  root to: 'home#index'
end
