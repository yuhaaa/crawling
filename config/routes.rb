Rails.application.routes.draw do

  resources :articles
  get 'articles/index'
  post 'articles/news_title'
  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
