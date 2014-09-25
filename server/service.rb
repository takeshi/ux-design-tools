class MainApp < Sinatra::Base

  get '/app' do
    users = []
    User.each { |user|  
      users.push user
    }
    json users
  end

  get '/app/add' do
    User.create(name:'Taro',email:'test@test.com')
    "Add Taro"
  end

end