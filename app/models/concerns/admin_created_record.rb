
module AdminCreatedRecord
  extend ActiveSupport::Concern

  included do
    belongs_to :created_by, class_name: "User"

    validate :creator_must_be_admin, on: :create
  end

  def editable_by?(user)
    user&.admin? || false
  end

  def deletable_by?(user)
    user&.admin? || false
  end

  private

  def creator_must_be_admin
    unless created_by&.admin?
      errors.add(:created_by, "must be an admin")
    end
  end
end
