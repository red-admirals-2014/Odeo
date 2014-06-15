class Clip < ActiveRecord::Base
  belongs_to :user

  def create
  	p "params"
  	p params

  	p "*"*20

  	p "current_user"
  	p current_user

  	p "*"*20

  	p "current_user.id"
  	p current_user.id

  	p "session.id"
  	p session[:id]

  	p "*"*20
  	p "current_user.uid"
  	p current_user.uid


  end
end