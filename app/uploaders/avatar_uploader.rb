class AvatarUploader < BaseUploader

  version :thumb do
    process resize_to_fill: [80, 80]
  end
  
  version :default do
    process resize_to_fill: [200, 200]
  end

end
