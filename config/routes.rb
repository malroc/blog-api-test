Rails.application.routes.draw do
  scope "", defaults: {format: :json} do
    resources :posts do
      resource :like, only: [:show, :create, :destroy]
      resources :comments
    end
  end
end
