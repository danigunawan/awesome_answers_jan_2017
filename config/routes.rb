Rails.application.routes.draw do
  # you map a HTTP verb / URL combo to a controller + action (method)

  # get({ '/' => 'welcome#index' })
  # get '/' => 'welcome#index', as: :root
  root 'welcome#index'

  # the above route maps any `GET` request with `/` URL to the index action
  # within the WelcomeController (action is a method defined within the
  # controller class)
  # the above can be called DSL (Domain Specific Language). It's just Ruby it's
  # not a special programming language, just Ruby. The Ruby is written in a way
  # that looks like its own language

  get '/contact' => 'welcome#contact_us'

  post '/contact_submit' => 'welcome#contact_submit'

  get '/about'   => 'welcome#about_us', as: :aboutus

  # resources :questions, only: [:create, :update]
  # resources :questions, except: [:index]

  # shallow: true option makes it so nested routes only include '/questions/:question_id'
  # for the create action and not for `destroy` for instance. This is because
  # when deleting a nested resouces you may not need to know about the parent
  # resource because you can get it from the Database. In our case, we can
  # get the question_id of an answer from the database
  resources :questions, shallow: true do
    # post :search
    # post :search, on: :member
    # post :search, on: :collection

    # this creates a set of `answers` routes nested within the `questions`
    # routes. This will make all the `answers` routes prefixed with
    # `/questions/:question_id`
    resources :answers, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  # post '/questions/search' => 'questions#search'

  # get    '/questions/new'      => 'questions#new',    as: :new_question
  # post   '/questions'          => 'questions#create', as: :questions
  # get    '/questions/:id'      => 'questions#show',   as: :question
  # get    '/questions'          => 'questions#index'
  # get    '/questions/:id/edit' => 'questions#edit',   as: :edit_question
  # patch  '/questions/:id'      => 'questions#update'
  # delete '/questions/:id'      => 'questions#destroy'

  # post '/questions/:question_id/answers' => 'answers#create'
  # delete '/questions/:question_id/answers/:id' => 'answers#destroy'


end
