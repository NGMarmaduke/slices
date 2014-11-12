require "paperclip"

module Paperclip
  class Cropped < Thumbnail

    def transformation_command
      if crop_command && !skip_crop?
        crop_command
      else
        super
      end
    end

    def crop_command
      target = @attachment.instance
      if target.cropping?
        ["-crop", "#{target.crop_width}x#{target.crop_height}+#{target.crop_x}+#{target.crop_y}"]
      end
    end

    def skip_crop?
      ["180x180#"].include?(@target_geometry.to_s)
    end
  end
end
