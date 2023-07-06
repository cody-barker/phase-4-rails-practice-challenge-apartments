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
        render json: tenants, include: ['apartments', 'apartments.leases']
    end

    def show
        tenant = find_tenant
        render json: tenant, include: ['apartments', 'apartments.leases']
    end

    def create
        if params[:apartment_id]
            apartment = find_apartment
            tenant = apartment.tenants.create(tenant_params)
        else
            tenant = Tenant.create!(tenant_params)
        end
        render json: tenant, include: ['apartments', 'apartments.leases'], status: :created
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, include: ['apartments', 'apartments.leases'],  status: :accepted
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        render json: {}, status: :no_content
    end

    private

    def find_apartment
        Apartment.find(params[:apartment_id])
    end

    def find_tenant
        Tenant.find(params[:id])
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def render_record_not_found_response
        render json: {error: "Tenant not found."}, status: :not_found
    end

    def render_record_invalid_response(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
