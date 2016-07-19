require('sinatra/activerecord')
require('./lib/question')
require('./lib/survey')
require('./lib/response')
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('pg')
require('pry')

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

get('/admin') do
  erb(:admin)
end

post('/surveys') do
  name = params['name']
  @survey = Survey.create({name: name})
  redirect to('/')
end

get('/surveys/:id') do
  @survey = Survey.find(params['id'].to_i)
  erb(:survey)
end

post('/surveys/:id/new_question') do
  @survey = Survey.find(params['id'])
  content = params['content']
  new_question = Question.create({content: content, survey_id: @survey.id()})
  redirect('/surveys/' + @survey.id.to_s)
end

get('/surveys/:id/edit') do
  @survey = Survey.find(params['id'])
  erb(:edit_survey_form)
end

patch('/surveys/:id') do
  name = params['name']
  @survey = Survey.find(params['id'].to_i)
  @survey.update({name: name})
  redirect('/surveys/' + @survey.id.to_s)
end

delete('/surveys/:id') do
  survey = Survey.find(params['id'].to_i)
  survey.delete()
  redirect('/')
end

get('/surveys/:survey_id/questions/:question_id') do
  @survey = Survey.find(params['survey_id'].to_i)
  @question = Question.find(params['question_id'].to_i)
  @question.responses.to_a.sort! {|x| x.rating}.reverse!
  # responses = @question.responses
  # @sorted_responses = responses.to_a.sort! {|x| x.rating}
  # @sorted_responses.reverse!
  erb(:question)
end

get('/surveys/:survey_id/questions/:question_id/edit') do
  @survey = Survey.find(params['survey_id'].to_i)
  @question = Question.find(params['question_id'].to_i)
  erb(:question_edit_form)
end

patch('/surveys/:survey_id/questions/:question_id') do
  content = params['content']
  question = Question.find(params['question_id'].to_i)
  question.update({content: content})
  redirect('/surveys/' + question.survey_id().to_s)
end

post("/surveys/:survey_id/questions/:question_id/new_response") do
  question = Question.find(params['question_id'].to_i)
  survey_id = params['survey_id']
  content = params['response']
  response = Response.create({response_content: content, rating: 0, question_id: question.id})
  url = '/surveys/' + survey_id + '/questions/' + question.id.to_s
  redirect(url)
end

delete("/surveys/:survey_id/questions/:question_id/:response_id/delete") do
  response = Response.find(params['response_id'].to_i)
  survey_id = params['survey_id']
  question_id = params['question_id']
  response.delete
  url = '/surveys/' + survey_id + '/questions/' + question_id
  redirect(url)
end

patch("/surveys/:survey_id/questions/:question_id/:response_id/up_vote") do
  response = Response.find(params['response_id'].to_i)
  survey_id = params['survey_id']
  question_id = params['question_id']
  response.up_vote
  url = '/surveys/' + survey_id + '/questions/' + question_id
  redirect(url)
end

patch("/surveys/:survey_id/questions/:question_id/:response_id/down_vote") do
  response = Response.find(params['response_id'].to_i)
  survey_id = params['survey_id']
  question_id = params['question_id']
  response.down_vote
  url = '/surveys/' + survey_id + '/questions/' + question_id
  redirect(url)
end

delete('/surveys/:survey_id/questions/:question_id/delete') do
  # survey = Survey.find(params['survey_id'])
  question = Question.find(params['question_id'])
  question.delete()
  redirect('/surveys/' + params['survey_id'])
end

get('/surveys/:id/take') do
  @survey = Survey.find(params['id'].to_i)
  erb(:take_survey)
end
