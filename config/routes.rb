Rails.application.routes.draw do
  devise_for :users
  resources :task_assignments, except: %i[index show edit create]
  resources :project_assignments, except: %i[index]
  resources :task_updates, except: %i[index]
  resources :projects do
    resources :tasks do
      member do
        patch :update_status
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  root 'welcome#index'
  get 'welcome/index' => 'welcome#index', as: :welcome

  mount ActionMailbox::Engine => '/rails/action_mailbox'
  post '/rails/action_mailbox/mailgun/inbound_emails/mime' => 'action_mailbox/ingresses/mailgun/inbound_emails#create'

  match '/500', to: 'errors#internal_server_error', via: :all, as: :internal_server_error
  match '/404', to: 'errors#not_found', via: :all, as: :not_found
end
