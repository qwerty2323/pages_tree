PagesTree::Application.routes.draw do
  root to:'pages#index'

  # http://guides.rubyonrails.org/routing.html#route-globbing-and-wildcard-segments
  get '(/*slugs)/add' => 'pages#new', as:'new_page'
  get '/*slugs/edit' => 'pages#edit', as:'edit_page'
  get '/*slugs' => 'pages#show', as:'page'
  put '/*slugs' => 'pages#update'
  post '/pages' => 'pages#create'
  # but it OF COURSE is not true Rails way. Strongly not recommended
end
