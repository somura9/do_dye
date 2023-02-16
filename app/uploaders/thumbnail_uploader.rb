class ThumbnailUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  process resize_to_fill: [1200, 800, 'Center']

  # Choose what kind of storage to use for this uploader:
  if Rails.env.development? # 開発環境の場合
    storage :file
  elsif Rails.env.test? # テスト環境の場合
    storage :file
  else # 本番環境の場合
    storage :fog
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'sample.png'
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
