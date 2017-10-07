Rails.application.routes.draw do

  scope module: :api, path: :api do
    scope module: :v1, path: :v1, constraints: ApiVersion.new('v1', true) do
      resources :friendships, only: [:index, :create, :destroy] do
        post :accept
      end
      resources :quizzes, only: [:index, :create, :update, :destroy] do
        get 'user_quizzes/:user_id' => 'quizzes#user_quizzes', on: :collection
      end
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
