class SessionsController < ApplicationController
  def new
  end

  def create

    user = run_sql_script('SELECT * FROM `mydb`.`User` WHERE `login` = \''+params[:session][:login]+'\';')

    if auth(params[:session][:login], params[:session][:password])
      sign_in user[0]["login"]
      if admin?
        redirect_to '/user/index'
      else
        redirect_to '/user/show?login='+params[:session][:login]
      end
    else
      flash.now[:danger] = "Invalid login/password"
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to '/sessions/new'
  end
end
