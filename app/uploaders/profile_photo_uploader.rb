class ProfilePhotoUploader < CarrierWave::Uploader::Base
  if Rails.env.test?
    storage :file
  # else
  #   storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png bmp)
  end

end
