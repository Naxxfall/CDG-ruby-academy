module TestData
  module_function

  def image_data
    attacher = Shrine::Attacher.new
    attacher.set(uploaded_image)
    attacher.column_data # or attacher.data in case of postgres jsonb column
  end

  def uploaded_image
    file = File.open("#{Rails.root}/test/files/image.jpg", binmode: true)

    # for performance we skip metadata extraction and assign test metadata
    uploaded_file = Shrine.upload(file, :store, metadata: false)
    uploaded_file.metadata.merge!(
        "size"      => File.size(file.path),
        "mime_type" => "image/jpeg",
        "filename"  => "image.jpg",
        )

    uploaded_file
  end

  def cached_image
    file = File.open("test/files/image.jpg",  binmode: true)
    cached_file = Shrine.upload(file, :cache)
    return cached_file.data
  end
end