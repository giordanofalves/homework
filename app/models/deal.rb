# frozen_string_literal: true

# == Schema Information
#
# Table name: deals
#
#  id         :bigint           not null, primary key
#  name       :string
#  amount     :integer
#  status     :integer
#  company_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Deal < ApplicationRecord
  belongs_to :company

  enum status: { pending: 0, won: 1, lost: 2 }

  validates :name, :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }
  validates :company, presence: true
end
