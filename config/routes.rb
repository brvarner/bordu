Rails.application.routes.draw do
  devise_for :users
  resources :task_assignments, except: %i[index show edit create]
  resources :project_assignments
  resources :task_updates
  resources :tasks
  resources :projects
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'

  mount ActionMailbox::Engine => '/rails/action_mailbox'
  post '/rails/action_mailbox/mailgun/inbound_emails/mime' => 'action_mailbox/ingresses/mailgun/inbound_emails#create'
end
