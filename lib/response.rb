class Response < ActiveRecord::Base
  belongs_to(:question)
  default_scope {order(rating: :desc)}


  def up_vote
    self.rating += 1
    self.update({rating: rating})
  end

  def down_vote
    self.rating -= 1
    self.update({rating: rating})
  end


end
