require('spec_helper')

describe(Response)do
  describe('#up_vote') do
    it "adds one to the rating" do
      response = Response.create({response_content: "man whatever", question_id: 1, rating: 0})
      response.up_vote
      expect(response.rating).to(eq(1))
    end
  end

  describe('#down_vote') do
    it "minus one to the rating" do
      response = Response.create({response_content: "man whatever", question_id: 1, rating: 2})
      response.down_vote
      expect(response.rating).to(eq(1))
    end
  end


end
