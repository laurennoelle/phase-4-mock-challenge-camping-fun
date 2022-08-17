class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_error

    def index 
        campers = Camper.all
        render json: campers, except: [:created_at, :updated_at], status: :ok
    end

    def show
        camper = find_camper
        render json: camper, include: :activities, status: :ok
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end 

private

    def camper_params
        params.permit(:name, :age)
    end

    def find_camper
        Camper.find(params[:id])
    end

    def record_not_found
        render json: { error: "Camper not found"}, status: :not_found
    end

    def unprocessable_entity_error(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end


end
