class CatRentalRequest < ActiveRecord::Base
  STATUS = ["PENDING", "DENIED", "APPROVED"]

  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: STATUS }

  belongs_to :cat

  after_initialize { status ||= "PENDING" }

  def approve!
    # If it can't be approved, don't show the button (where ever that button-logic is).
    CatRentalRequest.transaction do
      status = 'APPROVED'
      save!
      overlapping_requests.each { |request| request.deny! }
    end
  end

  def deny!
    status = "DENIED"
    save!
  end

  def overlapping_requests
    CatRentalRequest.where("id != :id AND cat_id = :cat_id AND (
      (start_date BETWEEN :start_date AND :end_date) OR
      (end_date BETWEEN :start_date AND :end_date))",
      { start_date: self.start_date, end_date: self.end_date, id: self.id, cat_id: self.cat_id})
  end

  def overlapping_approved_requests
    overlapping_requests.select{ |request| request.status == "APPROVED"}
  end


end
