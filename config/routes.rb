Ccf::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :staff, only: [:index]
  resources :events, only: [:show]
  get '/devotions', to: redirect('/devotions/today')
  resources :devotions, only: [] do
    collection do
      get 'today'
    end
  end

  namespace 'admin' do
    resources :devotions
    resources :events
    resources :users do
      member do
        put 'promote'
        put 'demote'
      end
    end
    resources :staff do
      member do
        put 'up'
      end
      collection do
        put 'reset_sort'
      end
    end
    root to: 'admin#index'
  end
  get '/lifegroups', to: redirect('https://docs.google.com/a/gtccf.org/spreadsheet/viewform?formkey=dDAwS0x1cHhUNTU1OWVwcGQ1YnhOaEE6MQ#gid=0')
  root to: 'home#index'
end
