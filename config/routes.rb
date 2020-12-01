Rails.application.routes.draw do
  get  'users/new'
  root 'static_pages#home'
  get  '/mypage',  to: 'static_pages#mypage'
  get  '/upload',  to: 'static_pages#upload'
  get  '/contact', to: 'static_pages#contact'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
