# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
FactoryBot.create_list(:company, 100)

Company.all.each do |company|
  rand(10..30).times do |i|
    FactoryBot.create_list(:deal, i, %i[pending won lost].sample, company:)
  end
end
