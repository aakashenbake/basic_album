class UploadController < ApplicationController
  def upload
    uploader = AvatarUploader.new
    uploader.store!(my_file)
  end

  def retrive
    uploader.retrieve_from_store!('my_file.png')
  end
end
