json.array!(@devices) do |device|
  json.extract! device, :id, :key, :name, :description
  json.url device_url(device, format: :json)
end
