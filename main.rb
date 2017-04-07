require 'csv'
require 'net/http'
require 'uri'
require 'json'

HPI_DATA_FILE = 'data/hpi_sample.csv'
HOUSE_API_URI = 'http://house-api-test.herokuapp.com/hpi'

uri = URI.parse(HOUSE_API_URI)
header = {'Content-Type': 'application/json'}
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)

CSV.foreach(HPI_DATA_FILE, headers: true) do |row|
  hpi = {
    date: row['Date'],
    region_name: row['RegionName'],
    index: row['Index'].to_f
  }

  request.body = hpi.to_json
  p response = http.request(request)
end

p 'Done!'
