module AvatorsHelper

  def get_avator_image(user, size)
    avator_image = Avator.where("uid = ?", user.id)
    if avator_image.count > 0
      return image_tag(avator_image[0].img_resize(size), class: 'profile')
      # return image_tag(avator_image[0].image, class: 'profile', style: 'width:36px; height:36px')
    else
      # style = 'width:'+size.to_s+'px; height:'+size.to_s+'px;'
      return image_tag('https://picsum.photos/200/300?image='+((user.id % 1000) + LOREM_PIC).to_s, class: 'profile')
    end
  end

end
