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
FactoryBot.define do
  factory :deal do
    sequence(:name) { |n| "Deal #{n}" }
    amount          { rand(10..1000) }
    company

    traits_for_enum :status, Deal.statuses
    # trait :pending do
    #   status { 0 }
    # end
    # trait :won do
    #   status { 1 }
    # end
    # trait :lost do
    #   status { 2 }
    # end
  end
end
