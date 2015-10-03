Rails.application.routes.draw do
  resources :announcements
  get 'announcements/:id/participants' => 'announcements#get_participants', as: :announcement_participants
  get 'announcements/:id/author' => 'announcements#get_author', as: :announcement_author
  
  devise_for :users
  
  root to: "announcements#index"
end
