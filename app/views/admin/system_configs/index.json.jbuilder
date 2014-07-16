json.array!(@admin_system_configs) do |admin_system_config|
  json.extract! admin_system_config, :id
  json.url admin_system_config_url(admin_system_config, format: :json)
end
