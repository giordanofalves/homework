# frozen_string_literal: true

class Api::V1::CompaniesController < ApplicationController
  before_action :filtering_params

  def index
    @companies = Company.filter(@filters)
                  .joins(:deals)
                  .group(:id)
                  .order(name: :asc)
                  .select(:id, :name, :industry, :employee_count, "sum(deals.amount) as deals_amount")
                  .page(params[:page])


    render json: { message: "Not found" }, status: :not_found if @companies.empty?
  end

  def list_industries
    industries = Company.all
                   .group(:industry)
                   .select(:industry)
                   .order(:industry)

    render json: { industries: industries.map(&:industry) }
  end

  private

  def filtering_params
    @filters = params.slice(:name, :industry, :minimum_employee_count, :minimum_deals_amount)
  end
end
