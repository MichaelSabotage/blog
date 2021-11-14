Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    resources :comments
  end

  # О подробностях DSL, доступного в этом файле, написано в http://rusrails.ru/rails-routing
end
