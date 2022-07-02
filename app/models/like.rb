class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_save :like_post
  after_destroy :unlike_post

  private

  def like_post
    if self.post != nil
      self.post.likes_count += 1
      self.post.save
    end
  end

  def unlike_post
    if self.post != nil
      self.post.likes_count -= 1
      self.post.save
    end
  end

end
