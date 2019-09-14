Rails.application.routes.draw do
  get '/towns' => 'towns#index'
  get '/aggs' => 'towns#aggregate'
  post '/query' => 'towns#convert'
end
