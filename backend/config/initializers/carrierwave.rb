CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_directory = 'terraform-e-production-image-storage-bucket'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
      aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
      region: 'ap-northeast-1'
    }
  else
    config.asset_host = 'http://localhost:8000'
  end
end
