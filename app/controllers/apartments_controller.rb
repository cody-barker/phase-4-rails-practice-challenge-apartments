class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

    def index
        if params[:tenant_id]
            tenant = find_tenant
            apartments = tenant.apartments
        else
            apartments = Apartment.all
        end
        render json: apartments, include: :tenants
    end

    def show
        apartment = find_apartment
        render json: apartment, include: :tenants
    end

    def create
        if params[:tenant_id]
            tenant = find_tenant
            apartment = tenant.apartments.create(apartment_params)
        else
            apartment = Apartment.create(apartment_params)
        end
        render json: apartment, include: :tenants, status: :created
    end

    def update
        
    end

    # def destroy
    # end

    private

    def find_tenant
        Tenant.find(params[:tenant_id])
    end

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find(params[:id])
    end

    def render_record_not_found_response
        render json: {error: "Record not found."}, status: :not_found
    end

    def render_record_invalid_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
