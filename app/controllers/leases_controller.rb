class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response

    def index
        leases = Lease.all
        render json: leases
    end

    def show
        lease = Lease.find(params[:id])
        render json: lease
    end
    
    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def update
        lease = Lease.find(params[:id])
        lease.update!(lease_params)
        render json: lease, status: :accepted
    end

    def destroy
        lease = find_lease
        lease.destroy
        render json: lease, status: :no_content
    end
    
    private

    def find_tenant
        Tenant.find(params[:tenant_id])
    end

    def find_apartment
        Apartment.find(params[:apartment_id])
    end

    def find_lease
        Lease.find(params[:id])
    end

    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end

    def render_record_not_found_response
        render json: {error: "Lease not found."}, status: :not_found
    end

    def render_record_invalid_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
