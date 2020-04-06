Rails.application.routes.draw do
  scope "", defaults: {format: :json} do
    resources :posts
  end
end
