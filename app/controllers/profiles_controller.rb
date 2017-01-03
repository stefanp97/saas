class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user

  def new
    @profile = Profile.new
  end
  # POST to /users/:user_id/profile
def create
  # Ensure that we have the user who is filling out form
  @user = User.find( params[:user_id] )
  # Create profile linked to this specific user
  @profile = @user.build_profile( profile_params )
  if @profile.save
    # flash[:success] = "Profile updated!"
    redirect_to user_path(id: params[:user_id] )
  else
    render action: :new
  end
end
def edit
  # GET to /users/:user_id/profile/edit
  @user = User.find( params[:user_id] )
  @profile = @user.profile
end

def update
  # PATCH to /users/:user_id/profile
  @user = User.find( params[:user_id] )
  @profile = @user.profile
  if @profile.update_attributes(profile_params)
    # Redirect user to their profile page
    redirect_to user_path(id: params[:user_id])
  else
    render action: :edit
  end
end
private
  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :avatar, :contact_email, :description)
  end

  def only_current_user
    @user = User.find( params[:user_id] )
    redirect_to(root_url) unless @user == current_user
  end
end
