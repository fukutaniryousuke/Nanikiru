module Public::NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil

    your_post_image = link_to 'あなたの投稿', post_image_path(notification), style: "font-weight: bold;"
    @visiter_post_comment = notification.post_comment_id
    # notification.actionがfollowかfavoriteかpost_commentか
    case notification.action
    when "follow" then
      tag.a(notification.visiter.name, href: customer_path(@visiter), style: "font-weight: bold;") + "があなたをフォローしました"
    when "favorite" then
      tag.a(notification.visiter.name, href: customer_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_image_path(notification.post_image_id), style: "font-weight: bold;") + "にいいねしました"
    when "post_comment" then
      @comment = PostComment.find_by(id: @visiter_post_comment)&.comment
      tag.a(@visiter.name, href: customer_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('投稿', href: post_image_path(notification.post_image_id), style: "font-weight: bold;") + "にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end
end
