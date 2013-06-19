Ccf::Application.routes.draw do
  resources 'staff'
  root to: 'home#index'
end
