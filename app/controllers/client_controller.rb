class ClientController < ApplicationController
  def new
    @@user_login = params[:login]
  end

  def create

    if signed_in?
      values = []
      keys = []
      params[:client].each do |key, value|
        keys.push('`'+key+'`')
        values.push('\''+value+'\'')
      end
      result = run_sql_script("INSERT INTO `mydb`.`Client` ("+keys.join(",")+") VALUES ("+values.join(",")+");")
      if result
        drop_constraints
        run_sql_script("UPDATE `mydb`.`User` SET `Client_national_id` ="+params[:client][:national_id].to_s+" WHERE `login`= \'"+@@user_login+"\';")
        add_constraints
        redirect_to root_path
      else
        flash.now[:danger] = "Incorrect values"
        render "new"
      end
    end
  end

  def show
    @client = run_sql_script('SELECT * FROM `mydb`.`Client` WHERE `national_id` = '+params[:national_id].to_s+';')[0]
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
