class ProfilesController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @profile = Profile.new(profile_params)
        @profile.user = @user
        
        if @profile.save
          render :action => :show
        else
          render :action => :new
        end
    
    end
    
    def show
        @profile = Profile.find(params[:id])
    end
    def new
        @user = User.find(params[:user_id])
        @profile = @user.build_profile
    end
    def edit 
        @user = User.find(params[:user_id])
        @profile = Profile.find(params[:id])
    end
    def update
        @profile = Profile.find(params[:id])
        if @profile.update(profile_params)
            redirect_to user_profile_path(@profile)
        else
            render 'edit'
        end
    end
    def destroy
        @user = User.find(params[:user_id])
        @profile = @user.profile.find(params[:id])
        @profile.destroy
    end
    private 
        def profile_params
            params.require(:profile).permit(:bio, :description, :imageurl)
        end
end
