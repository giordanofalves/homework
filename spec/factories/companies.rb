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
FactoryBot.define do
  factory :company do
    name           { Faker::Company.name }
    industry       { Faker::Company.industry }
    employee_count { rand(10..1000) }
  end
end
