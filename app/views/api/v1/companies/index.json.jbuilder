# frozen_string_literal: true

json.companies do
  json.array! @companies do |company|
    json.id             company.id
    json.name           company.name
    json.industry       company.industry
    json.employee_count company.employee_count
    json.deals_amount   number_to_currency(company.deals_amount, delimiter: "")
  end
end

json.current_page  @companies.current_page
json.total_pages   @companies.total_pages
json.total_entries @companies.total_count
