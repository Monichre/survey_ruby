require('spec_helper')

describe(Question) do
  describe('#sort_responses_by_rating') do
    it('sorts a questions responses by their rating') do
      question = Question.create({content: 'why are you here?', survey_id: 1})
      response = Response.create({response_content: "man whatever", question_id: question.id, rating: 2})
      response2 = Response.create({response_content: "NO!", question_id: question.id, rating: 4})
      expect(question.sort_responses_by_rating).to(eq([response2, response]))
    end
  end
end
