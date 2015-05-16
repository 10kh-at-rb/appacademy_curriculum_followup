class Post < ActiveRecord::Base
  validates :author_id, :sub_id, :title, presence: true

  belongs_to :sub
  belongs_to(
  :author,
  class_name: 'User'
  )


end
