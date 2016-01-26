class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_name_or_last_name_present
  validates :gender, :inclusion => ["male", "female"]
  validate :male_not_named_sue

  def self.get_all_profiles(min, max)
    Profile.where("birth_year BETWEEN ? AND ?", min, max).order(:birth_year)
  end

  def first_name_or_last_name_present
    if first_name.nil? && last_name.nil?
      errors.add(:base, "either first name or last name must be present")
    end
  end

  def male_not_named_sue
    if gender == "male" && first_name == "Sue"
      errors.add(:base, "males cannot be named Sue")
    end
  end
end
