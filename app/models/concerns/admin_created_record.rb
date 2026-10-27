
module AdminCreatedRecord
  extend ActiveSupport::Concern

  included do
    belongs_to :created_by, class_name: "User"

    validate :creator_must_be_admin, on: :create
    before_update :check_admin_for_update
    before_destroy :check_admin_for_destroy
  end

  private

  def creator_must_be_admin
    unless created_by&.admin?
      errors.add(:created_by, "must be an admin")
    end
  end

  def check_admin_for_update
    unless Current.user&.admin?
      errors.add(:base, "Only admins can update this record")
      throw(:abort)
    end
  end

  def check_admin_for_destroy
    unless Current.user&.admin?
      errors.add(:base, "Only admins can delete this record")
      throw(:abort)
    end
  end
end
