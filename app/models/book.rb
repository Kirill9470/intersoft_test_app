class Book < ApplicationRecord

  validates :author, uniqueness: { scope: :name }

  def self.filter_by_name(name)
    return all if name.blank?

    where('name ILIKE ?', "%#{name}%")
  end

  def self.filter_by_author(author_mask)
    return all if author_mask.blank?

    where(author: author_mask)
  end

  def self.filter_by_date(start_date, end_date)
    return all if start_date.blank? && end_date.blank?
    return where('date > ?', Date.new(start_date.to_i)) if start_date.present? && start_date.blank?
    return where('date < ?', Date.new(end_date.to_i)) if start_date.blank? && end_date.present?

    where(date: Date.new(start_date.to_i)..Date.new(end_date.to_i))
  end

end
