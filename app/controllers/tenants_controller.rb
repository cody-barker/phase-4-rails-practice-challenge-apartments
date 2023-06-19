class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

    def index
        if params[:apartment_id]
            apartment = find_apartment
            tenants = apartment.tenants
        else
            tenants = Tenant.all
        end
        render json: tenants, include: :apartment
    end

    # def show
    # end

    # def create
    # end

    # def update
    # end

    # def destroy
    # end

    private

    def find_apartment
        Apartment.find(params[:apartment_id])
    end

    def render_record_not_found_response
        render json: {error: "Record not found."}, status: :not_found
    end

    def render_record_invalid_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
