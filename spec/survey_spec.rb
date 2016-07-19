require('spec_helper')

describe(Survey) do
  it('capitalizes the name') do
    survey = Survey.create({name: 'whassup'})
    expect(survey.name()).to(eq('Whassup'))
  end

  describe('#questions') do
    it('lists out the questions that belong to a survey') do
      test_survey = Survey.create({name: 'The Best Survey'})
      test_question = Question.create({question: 'What is the difference?', survey_id: test_survey.id})
      test_question2 = Question.create({question: 'How am I?', survey_id: test_survey.id})
      expect(test_survey.questions()).to(eq([test_question, test_question2]))
    end
  end
end
