require 'csv'

namespace :import_towns_from_file do
	desc 'This task imports towns from file'
	task :import => [:environment] do
		
		ActiveRecord::Base.connection.execute("DELETE FROM towns")
		p "truncated"

		filepath = Rails.root.join('db', 'Botify-Python-Challenge-French-Towns-Data.csv')

		HEADERS = [
				"Region Code",
				"Region Name",
				"Code Department",
				"Code District",
				"Code town",
				"Town Name",
				"Population",
				"Average Age",
		]

		@headers = {}
		HEADERS.each_with_index do |header, index|
				@headers[header] = index
		end
		
		line_number = 0
		towns = []
		CSV.foreach(filepath, col_sep: ';', encoding: 'UTF-8') do |row|
			line_number += 1
			puts row.inspect
			puts "line : #{line_number} / 35912"
			next if line_number == 1
			population = row[@headers["Population"]].gsub(/\s+/,"").to_i

			town = {
				region_code: row[@headers["Region Code"]],
				region_name: row[@headers["Region Name"]],
				dept_code: row[@headers["Code Department"]],
				distr_code: row[@headers["Code District"]],
				code: row[@headers["Code town"]],
				name: row[@headers["Town Name"]],
				population: population,
				average_age: row[@headers["Average Age"]],
			}
			towns << town
		end
		p 'creating___'
		Town.create(towns)

	end

end