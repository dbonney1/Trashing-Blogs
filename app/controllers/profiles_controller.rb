class ProfilesController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @profile = @user.profile.create(profile_params)
        redirect_to user_profile_path(@user)
    end
    
    
    private 
        def profile_params
            params.require(:profile).permit(:bio, :description, :imageurl)
        end
end
