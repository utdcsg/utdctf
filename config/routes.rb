Utdctf::Application.routes.draw do
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  namespace :admin do
    resources :users
    resources :competitions do
      resources :news
      resources :categories do
        resources :problems
      end
      member do
        put 'hide'
        put 'unhide'
        put 'activate'
        put 'deactivate'
      end
    end
  end

  resources :users, :only => [:new, :edit, :create, :update]

  resources :competitions, :only => [:show] do
    resources :users, :only => [] do
      member do
        put 'register'
      end
    end
    resources :problems, :only => [:show]
    resources :solves, :only => [:create]
    member do
      get 'scoreboard'
      get 'stats'
    end
  end


  root :to => "home#index"

end
