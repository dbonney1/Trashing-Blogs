class SubscriptionsController < ApplicationController
    def create
        user = User.find(params[:subscribed_id])
        current_user.subscribe(user)
        redirect_back(fallback_location: root_path)
    end
    
    def destroy 
        user = Subscription.find(params[:id]).subscribed
        current_user.unsubscribe(user)
        redirect_back(fallback_location: root_path)
    end
end