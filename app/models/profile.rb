class Profile < ApplicationRecord
  before_update :remove_existing_permissions
  has_many :permissions, class_name: 'Acl::Permission', dependent: :delete_all
  accepts_nested_attributes_for :permissions, reject_if: proc { |attributes| attributes['actions'].blank? }
  validates :name, presence: true
  validates :name, uniqueness: true

  NAMES = [
    { NAME: 'Admin', ADMIN: true },
    { NAME: 'CPTO', ADMIN: false },
    { NAME: 'Serviço Operacional', ADMIN: false },
    { NAME: 'Serviço Técnico', ADMIN: false },
    { NAME: 'QRCODE', ADMIN: false }
  ]

  def has_action(app_module_id, action)
    permission = self.permissions.where(app_module_id: app_module_id).first
    return permission.present? ? permission.actions.include?(action) : false
  end

  def self.get_admin_id
    name = ""
    NAMES.each do |v|
      name = v[:NAME] and break if v[:ADMIN]
    end
    find_by(name: name).id
  end

  private
    def remove_existing_permissions
      Acl::Permission.where(profile_id: self.id).delete_all
    end
end
