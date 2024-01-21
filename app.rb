require 'sinatra'
require 'sinatra/reloader' if development?

set :public_folder, File.dirname(__FILE__) + '/public'

tasks = []

get '/' do
  erb :index, locals: { tasks: tasks }
end

def format_angolan_date(date_string)
  datetime = DateTime.parse(date_string)
  datetime.strftime('%d/%m/%Y %H:%M:%S')
end

post '/add_task' do
  content = params[:task]
  created_at = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')
  tasks << { content: content, created_at: created_at }
  redirect '/'
end

post '/delete_task/:id' do
  id = params[:id].to_i
  tasks.delete_at(id) if id < tasks.length
  redirect '/'
end
