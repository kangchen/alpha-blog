class Avator < ApplicationRecord
  has_one_attached :image
  validate :image_type

  def img_resize(size)
    return self.image.variant(resize: "#{size} x #{size}!").processed
  end

  private
  def image_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/gif))
      errors.add(:image, 'Must be a JPEG, GIF, or PNG image file')
    elsif image.attached? == false
      errors.add(:image, 'required')
    end
  end

end
