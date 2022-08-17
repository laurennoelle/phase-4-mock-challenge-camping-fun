class ActivitiesController < ApplicationController

    def index
        activities = Activity.all
        render json: activities, except: [:updated_at, :created_at], status: :ok
    end


    def destroy
        activity = Activity.find(params[:id])
        activity.destroy
        head :no_content 
    rescue ActiveRecord::RecordNotFound => error
        render json: { error: "Activity not found"}, status: :not_found
    end
end
