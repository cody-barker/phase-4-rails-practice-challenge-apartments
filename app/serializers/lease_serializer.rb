class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :apartment_id, :tenant_id, :rent
end
