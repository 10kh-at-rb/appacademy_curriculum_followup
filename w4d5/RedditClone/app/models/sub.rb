class Sub < ActiveRecord::Base
  validates :title, :moderator_id, :description, presence: true

  belongs_to(
    :moderator,
    class_name: 'User',
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many :posts


end
