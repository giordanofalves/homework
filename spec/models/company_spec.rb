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
require "rails_helper"

RSpec.describe Company, type: :model do
  let(:deal) { build(:deal) }

  describe "associations" do
    it { should have_many(:deals) }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(deal).to be_valid
    end

    it "validates uniqueness of name" do
      create(:company, name: "Company 1")
      company2 = build(:company, name: "Company 1")

      expect(company2).not_to be_valid
    end

    it "validates presence of name" do
      company = build(:company, name: nil)

      expect(company).not_to be_valid
    end

    it "validates presence of employee_count" do
      company = build(:company, employee_count: nil)

      expect(company).not_to be_valid
    end

    it "validates presence of industry" do
      company = build(:company, industry: nil)

      expect(company).not_to be_valid
    end

    it "validates numericality of employee_count" do
      company = build(:company, employee_count: "abc")

      expect(company).not_to be_valid
    end

    it "validates employee_count to be greater than 0" do
      company = build(:company, employee_count: 0)

      expect(company).not_to be_valid
    end
  end
end
