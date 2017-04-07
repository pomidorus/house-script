require 'csv'

CSV.foreach("data/hpi_sample.csv", headers: true) do |row|
 p row['Date']
 p row['RegionName']
 p row['Index']
end
