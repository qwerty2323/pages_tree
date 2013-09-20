PagesTree::Application.routes.draw do
  root to:'pages#index'
  get '(/*slugs)/add' => 'pages#new', as:'new_page'
  get '/*slugs/edit' => 'pages#edit', as:'edit_page'
  get '/*slugs' => 'pages#show', as:'page'
  put '/*slugs' => 'pages#update'
  post '/pages' => 'pages#create'
  # resources :pages, only:[:create, :update]
end
