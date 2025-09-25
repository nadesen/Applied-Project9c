class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_one_attached :image

  has_many :group_users
  has_many :members, through: :group_users, source: :user

  validates :name, presence: true

  def all_members
    members_with_owner = members.to_a
    members_with_owner.unshift(owner) unless members_with_owner.include?(owner)
    members_with_owner
  end
end
