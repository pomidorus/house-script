require 'csv'
require 'net/http'
require 'uri'
require 'json'

HPI_DATA_FILE = 'data/hpi_sample.csv'
HOUSE_API_URI = 'http://house-api-test.herokuapp.com/hpi'

DATE_COLUMN = 'Date'
REGION_NAME_COLUMN = 'RegionName'
INDEX_COLUMN = 'Index'

uri = URI.parse(HOUSE_API_URI)
header = {'Content-Type': 'application/json'}
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)

def post_data(row, http, request)
  hpi = {
    date: row[DATE_COLUMN],
    region_name: row[REGION_NAME_COLUMN],
    index: row[INDEX_COLUMN].to_f
  }

  request.body = hpi.to_json
  p response = http.request(request)
end

CSV.foreach(HPI_DATA_FILE, headers: true) do |row|
  post_data(row, http, request)
end

p 'Done!'
