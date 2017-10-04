Rails.application.routes.draw do

  scope module: :api, path: :api do
    scope module: :v1, path: :v1, constraints: ApiVersion.new('v1', true) do
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
