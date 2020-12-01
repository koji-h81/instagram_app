Rails.application.routes.draw do
  root 'static_pages#home'
  get  'static_pages/home'
  get  'static_pages/search'
  get  'static_pages/notice'
  get  'static_pages/mypage'
  get  'static_pages/upload'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
