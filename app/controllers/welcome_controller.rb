class WelcomeController < ApplicationController
  # this is the Index action
  # GET '/'
  def index
    # render({plain: 'Hello World!'})
    # render plain: 'Hello World!'

    # this will automatically look for a file named: home.html.erb
    # within folder: /app/views/welcome
    # it defaults to `.html` because the default `format` for requests in rubyonrails
    # is always HTML unless you specify otherwise
    # erb: is the default built-in templating system with Rails
    # By default Rails will use `app/views/layouts/application.html.erb` as
    # the layout, so the content of `home.html.erb` will be inserted in the
    # place of `<%= yield %>` within the layout
    # render :home

    # the default behaviour is to render: index.html.erb within folder:
    # /app/views/welcome
  end

  def contact_us

  end

  def contact_submit
    # params gives us access to all GET or POST parameters from the HTTP request
    # params uses Hashes with indifferent access which means it will work with
    # either symbols or strings as keys
    @name = params[:name]
    # render plain: 'Form submitted'
  end
end
