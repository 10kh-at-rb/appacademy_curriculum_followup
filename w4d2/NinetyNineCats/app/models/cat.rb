class Cat < ActiveRecord::Base
  COLORS = {
    :black => "Black",
    :gray => "Gray",
    :white => "White"
  }
  SEX = {
    :male => "M",
    :female => "F"
  }
  validates :color, inclusion: { in: COLORS.values, message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: SEX.values, message: "%{value} is not a valid sex" }

  has_many :cat_rental_requests, dependent: :destroy

  def self.colors
    COLORS.values
  end

  def age
    Time.now.year - self.birthdate.year
  end

end
