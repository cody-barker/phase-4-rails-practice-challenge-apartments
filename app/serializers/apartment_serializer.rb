class ApartmentSerializer < ActiveModel::Serializer
  attributes :id, :number
  has_many :leases
  has_many :tenants, through: :leases
end
