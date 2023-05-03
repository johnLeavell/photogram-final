class WelcomeController < ApplicationController

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "layouts/index.html.erb" })
  end

end
