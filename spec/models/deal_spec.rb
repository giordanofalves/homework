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
require "rails_helper"

RSpec.describe Deal, type: :model do
  let(:company) { build(:company) }
  let(:deal)    { build(:deal, company:) }

  describe "associations" do
    it { should belong_to(:company) }
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(deal).to be_valid
    end

    it "is invalid without a name" do
      deal.name = nil

      expect(deal).to be_invalid
      expect(deal.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an amount" do
      deal.amount = nil

      expect(deal).to be_invalid
      expect(deal.errors[:amount]).to include("can't be blank")
    end

    it "is invalid with a negative amount" do
      deal.amount = -100

      expect(deal).to be_invalid
      expect(deal.errors[:amount]).to include("must be greater than 0")
    end

    it "is invalid without a company" do
      deal.company = nil

      expect(deal).to be_invalid
      expect(deal.errors[:company]).to include("can't be blank")
    end
  end
end
