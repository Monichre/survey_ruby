class Question < ActiveRecord::Base
  belongs_to(:survey)
  has_many(:responses)

  # scope(:sort_responses_by_rating, -> do
  #   Response.order({rating: :desc})
  #   where(response.question_id = self.id )
  # end)
end
