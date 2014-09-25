json.array!(@triggers) do |trigger|
  json.extract! trigger, :id, :device_id, :title, :email, :property, :operation, :value, :message
  json.url trigger_url(trigger, format: :json)
end
