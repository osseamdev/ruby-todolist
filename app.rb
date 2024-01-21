require 'sinatra'
require 'sinatra/reloader' if development?

set :public_folder, File.dirname(__FILE__) + '/public'

tasks = []

get '/' do
  erb :index, locals: { tasks: tasks }
end

post '/add_task' do
  task = params[:task]
  tasks << task unless task.empty?
  redirect '/'
end

post '/delete_task/:id' do
  id = params[:id].to_i
  tasks.delete_at(id) if id < tasks.length
  redirect '/'
end
