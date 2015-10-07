Rails.application.routes.draw do
  resources :announcements
  get 'announcements/:id/participants' => 'announcements#get_participants', as: :announcement_participants
  get 'announcements/:id/author' => 'announcements#get_author', as: :announcement_author
  
  get 'users' => 'users#index', as: :users_index
  get 'user/:id' => 'users#show', as: :user
  get 'user/:id/user_json' => 'users#user_json', as: :user_json
  get 'user/:id/announcements' => 'users#user_announcements', as: :user_announcements
  get 'user/:id/participants' => 'users#user_participants', as: :user_participants
  
  devise_for :users
  
  root to: "announcements#index"
end
