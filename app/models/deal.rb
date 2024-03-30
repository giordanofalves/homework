# frozen_string_literal: true

# == Schema Information
#
# Table name: deals
#
#  id         :bigint           not null, primary key
#  name       :string
#  amount     :decimal(10, 2)
#  status     :integer
#  company_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Deal < ApplicationRecord
  belongs_to :company

  enum status: { pending: 0, won: 1, lost: 2 }

  validates :name, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :company, presence: true
end
