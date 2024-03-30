# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::CompaniesController, type: :controller do
  describe "GET index" do
    let!(:companies) { create_list(:company, 3) }
    let(:filters) { { name: "Company", industry: "Tech", minimum_employee_count: 100, minimum_deals_amount: 1000 } }

    before do
      companies.each do |company|
        create(:deal, company:, amount: rand(10..1000))
      end
    end

    it "returns all companies and results" do
      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      body = JSON.parse(response.body)
      expect(body).to be_an(Hash)
      expect(body["companies"].length).to eq(3)

      body["companies"].each do |company|
        expect(company).to have_key("id")
        expect(company).to have_key("name")
        expect(company).to have_key("industry")
        expect(company).to have_key("employee_count")
        expect(company).to have_key("deals_amount")
      end
    end

    it "returns filtered company and results" do
      filtered_company = companies.sample
      get :index, params: { name: filtered_company.name }, format: :json

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      body = JSON.parse(response.body)
      expect(body).to be_an(Hash)
      expect(body["companies"].length).to eq(1)

      company = body["companies"].first
      expect(company["id"]).to eq(filtered_company.id)
      expect(company["name"]).to eq(filtered_company.name)
      expect(company["industry"]).to eq(filtered_company.industry)
      expect(company["employee_count"]).to eq(filtered_company.employee_count)
      expect(company["deals_amount"]).to eq(ActionController::Base.helpers.number_to_currency(filtered_company.deals.sum(:amount), delimiter: ""))
    end

    it "returns 'Not found' message when no companies are found" do
      Company.destroy_all
      get :index, format: :json

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      body = JSON.parse(response.body)
      expect(body).to be_an(Hash)
      expect(body["message"]).to eq("Not found")
    end
  end

  describe "GET list_industries" do
    let!(:companies) { create_list(:company, 3) }

    it "returns a list of industries" do
      get :list_industries, format: :json

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      body = JSON.parse(response.body)
      expect(body).to be_an(Hash)
      expect(body["industries"]).to match_array(companies.pluck(:industry))
    end
  end
end
