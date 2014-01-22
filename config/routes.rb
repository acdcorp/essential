Subrolink::Application.routes.draw do
  root to: redirect("/claims")

  devise_for :users

  devise_scope :user do
    get '/login' => 'devise/sessions#new'
    get '/logout' => 'devise/sessions#destroy'
    get '/forgot_password' => 'devise/passwords#new'
  end

  resources :claims
  get '/claims/form/:type' => 'claims#form', as: :claim_form
end
