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
  has_many :deals

  validates :name, uniqueness: true
  validates :name, :employee_count, :industry, presence: true
  validates :employee_count, numericality: { only_integer: true, greater_than: 0 }
end
