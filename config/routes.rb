Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new', as: :new_user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :workflows, only: :show
  post '/workflows/submit/:id', to: 'workflows#form_submit',
                                as: 'workflow_submit'

  get 'static_pages/home'
  root 'static_pages#home'
end
