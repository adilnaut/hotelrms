class UserController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  def new
  end

  def create
    u_params = user_params
    u_params["password"] = encrypt u_params["password"]
    values = []
    u_params.each do |key, value|
      values.push('\''+value+'\'')
    end
    script = 'INSERT INTO `mydb`.`User` (`login`, `password`, `remember_token`) VALUES ('+values.join(',')+',\'no_token\');'
    result = run_sql_script(script)
    if result
      sign_in u_params[:login]
      redirect_to '/user/show?login='+u_params[:login]
    else
      flash.now[:danger] = "Incorrect values"
      render 'new'
    end
  end

  def destroy
    run_sql_script("DELETE FROM `mydb`.`User` WHERE `login` = \'"+ @user[0]["login"] + '\';')
    redirect_to root_path
  end

  def index
    if !signed_in?
      redirect_to '/sessions/new'
    end
    @users = run_sql_script('SELECT * FROM `mydb`.`User`;')
    puts @user
  end

  def show
    if admin? || (current_user["login"] ==  @user[0]["login"])
      @user = @user[0]
    else
      redirect_to root_path
    end
  end
private
  def user_params
    params.require(:user).permit(:login, :password)
  end

  def set_user
    @user = run_sql_script('SELECT * FROM `mydb`.`User` WHERE `login` = \''+params[:login]+'\';')
  end
end
