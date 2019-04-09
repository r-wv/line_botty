Rails.application.routes.draw do
  resources :members
  post '/callback' => 'linebot#callback'
end
