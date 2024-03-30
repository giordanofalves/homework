# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id             :bigint           not null, primary key
#  name           :string
#  employee_count :integer
#  industry       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Company < ApplicationRecord
  include Filterable

  has_many :deals, dependent: :destroy

  validates :name, uniqueness: true
  validates :name, :employee_count, :industry, presence: true
  validates :employee_count, numericality: { only_integer: true, greater_than: 0 }

  scope :filter_by_name,                   -> (value) { where("UPPER(companies.name) like ?", "%#{value.upcase}%") }
  scope :filter_by_industry,               -> (value) { where(industry: value) }
  scope :filter_by_minimum_employee_count, -> (value) { where("companies.employee_count >= ?", value) }
  scope :filter_by_minimum_deals_amount,   -> (value) { joins(:deals).group(:id).having("sum(deals.amount) >= ?", value) }
end
