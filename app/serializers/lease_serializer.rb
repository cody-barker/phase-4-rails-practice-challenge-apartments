class LeaseSerializer < ActiveModel::Serializer
  attributes :id, :apartment_id, :tenant_id, :rent
  belongs_to :lease
  belongs_to :tenant
end
