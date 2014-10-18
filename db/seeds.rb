require 'httparty'

# Fill database with random locations
req_options = {
  key: $CONFIG['google']['api_key'],
  location: '55.755826,37.6173', # Moscow, Russia
  radius: 20000,
  types: 'bar|cafe|food|restaurant',
  pagetoken: nil,
  sensor: false
}
locations = {}

res = HTTParty.get("https://maps.googleapis.com/maps/api/place/radarsearch/json?" + req_options.to_param)
if res['status'] == 'OK'
  res['results'].each_with_index do |result|
    break if locations.count == 50

    location = result['geometry']['location']
    locations[location.values.join.hash] = {
      latitude: location['lat'],
      longitude: location['lng']
    }
  end
end

# Create locations avoiding google query limit in 10 QPS
locations.values.each_slice(10).to_a.each do |locs|
  Location.create(locs)
  sleep(1)
end
