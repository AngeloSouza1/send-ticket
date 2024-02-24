# config/routes.rb

Rails.application.routes.draw do
  resources :students do
    collection do
      get 'send_ticket', to: 'students#new_send_ticket'
      post 'send_ticket', to: 'students#send_ticket'
    end
  end

  root 'students#new'
end
