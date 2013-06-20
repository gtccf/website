CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],                        # required
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],                        # required
  }
  config.fog_directory  = 'ccf-assets'                     # required
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
