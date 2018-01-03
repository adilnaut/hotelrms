module ClientHelper
  def is_client?(login)
    result = run_sql_script('SELECT `Client_national_id` FROM `mydb`.`User` WHERE `login` = \''+login+'\';')[0]
    return !(result["Client_national_id"].nil?)
  end

  def get_client_id_by_login(login)
    result = run_sql_script('SELECT `Client_national_id` FROM `mydb`.`User` WHERE `login` = \''+login+'\';')[0]
    return result["Client_national_id"].to_s
  end
end
