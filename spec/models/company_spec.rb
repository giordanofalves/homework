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
    it { should have_many(:deals).dependent(:destroy) }
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

  describe "scopes" do
    describe ".filter_by_name" do
      it "returns companies with matching name" do
        company1 = create(:company, name: "Company 1")
        company2 = create(:company, name: "Company 2")
        filtered_companies = Company.filter_by_name("Company 1")

        expect(filtered_companies).to include(company1)
        expect(filtered_companies).not_to include(company2)
      end
    end

    describe ".filter_by_industry" do
      it "returns companies with matching industry" do
        company1 = create(:company, industry: "Technology")
        company2 = create(:company, industry: "Finance")
        filtered_companies = Company.filter_by_industry("Technology")

        expect(filtered_companies).to include(company1)
        expect(filtered_companies).not_to include(company2)
      end
    end

    describe ".filter_by_minimum_employee_count" do
      it "returns companies with employee count greater than or equal to the given value" do
        company1 = create(:company, employee_count: 100)
        company2 = create(:company, employee_count: 50)
        filtered_companies = Company.filter_by_minimum_employee_count(75)

        expect(filtered_companies).to include(company1)
        expect(filtered_companies).not_to include(company2)
      end
    end

    describe ".filter_by_minimum_deals_amount" do
      it "returns companies with total deals amount greater than or equal to the given value" do
        company1 = create(:company)
        company2 = create(:company)
        create(:deal, company: company1, amount: 100)
        create(:deal, company: company2, amount: 50)
        filtered_companies = Company.filter_by_minimum_deals_amount(75)

        expect(filtered_companies).to include(company1)
        expect(filtered_companies).not_to include(company2)
      end
    end
  end
end
