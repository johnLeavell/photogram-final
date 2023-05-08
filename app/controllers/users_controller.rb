class UsersController < ApplicationController
  skip_before_action(:force_user_sign_in, { :only => [:index] })

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    path_user = params.fetch("path_id")

    matching_user = User.where({ :username => path_user })

    @the_user = matching_user.first

    
    @matching_request = FollowRequest.where({ :recipient_id => @the_user.id, :sender_id => @current_user.id }).first
    
    if @the_user.private?
      if @the_user.followers.include?(@current_user) && @matching_request.status == "accepted"
        render({ :template => "users/show.html.erb" })
      else
        redirect_to("/", { :alert => "You're not authorized for that." })
      end
    else
        render({ :template => "users/show.html.erb" })
    end
  end

  def show_liked
    path_user = params.fetch("path_id")

    matching_user = User.where({ :username => path_user })

    @the_user = matching_user.first

    render({ :template => "users/show_liked.html.erb"})
  end

  def show_feed
    path_user = params.fetch("path_id")

    matching_user = User.where({ :username => path_user })

    @the_user = matching_user.first

    render({ :template => "users/show_feed.html.erb"})
  end

  def show_discover
    path_user = params.fetch("path_id")

    matching_user = User.where({ :username => path_user })

    @the_user = matching_user.first

    render({ :template => "users/show_discover.html.erb"})
  end
end
