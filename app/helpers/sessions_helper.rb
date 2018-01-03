module SessionsHelper
  def	sign_in(user)
      remember_token	=	new_remember_token
      cookies.permanent[:remember_token]	=	remember_token
      run_sql_script('UPDATE `mydb`.`User` SET `remember_token`=\''+encrypt(remember_token)+'\'' + 'WHERE `login`=\''+user+'\';')
      # user.update_attribute(:remember_token,	encrypt(remember_token))
      self.current_user	=	user
  end

  def new_remember_token
    SecureRandom.urlsafe_base64
  end
  def encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def sign_out
    # current_user.update_attribute(:remember_token, encrypt(new_remember_token))
    run_sql_script('UPDATE `mydb`.`User` SET `remember_token`=\''+encrypt(new_remember_token)+'\''+ 'WHERE `login`=\''+current_user["login"]+'\';')
    cookies.delete(:remember_token)
	  self.current_user	=	nil
  end

  def	current_user=(user)
	  	@current_user	=	user
	end

  def current_user
      remember_token = encrypt(cookies[:remember_token])
      results = run_sql_script('SELECT `login` FROM `mydb`.`User` WHERE `remember_token`=\''+remember_token+'\';')
      @current_user = @current_user || results[0]
  end

  def signed_in?
      !current_user.nil?
  end

  def current_user?(user)
      return user == @current_user["login"]
  end

  def auth(user, password)
    real_pass = run_sql_script('SELECT `password` FROM `mydb`.`User` WHERE `login`=\''+user+'\';')
    if real_pass[0].nil?
      return false
    end
    enc_pass = encrypt password
    if enc_pass.eql? real_pass[0]["password"]
      return true
    else
      return false
    end
  end

  def admin?
    if current_user["login"].eql? "admin"
      return true
    else
      return false
    end
  end

  def manager?
    user_m_ssn = run_sql_script("SELECT `Worker_Manager_SSN` from `mydb`.`User` WHERE login = \'"+current_user["login"]+'\';')[0]
    puts user_m_ssn
    if user_m_ssn.nil? || user_m_ssn["Worker_Manager_SSN"].nil?
      return false
    else
      return true
    end
  end

  def is_manager?(login)
    user_m_ssn = run_sql_script("SELECT `Worker_Manager_SSN` from `mydb`.`User` WHERE login = \'"+login+'\';')[0]
    if user_m_ssn.nil? || user_m_ssn["Worker_Manager_SSN"].nil?
      return false
    else
      return true
    end
  end

  def receptionist?
    user_r_ssn = run_sql_script("SELECT `Worker_Receptionist_SSN` from `mydb`.`User` WHERE login = \'"+current_user["login"]+'\';')[0]
    if user_r_ssn.nil? || user_r_ssn["Worker_Receptionist_SSN"].nil?
      return false
    else
      return true
    end
  end

  def is_receptionist?(login)
    user_r_ssn = run_sql_script("SELECT `Worker_Receptionist_SSN` from `mydb`.`User` WHERE login = \'"+login+'\';')[0]
    if user_r_ssn.nil? || user_r_ssn["Worker_Receptionist_SSN"].nil?
      return false
    else
      return true
    end
  end

  def get_SSN(login)
    if is_receptionist?(login)
      user_r_ssn = run_sql_script("SELECT `Worker_Receptionist_SSN` from `mydb`.`User` WHERE login = \'"+login+'\';')[0]
      return user_r_ssn["Worker_Receptionist_SSN"]
    elsif is_manager?(login)
      user_m_ssn = run_sql_script("SELECT `Worker_Manager_SSN` from `mydb`.`User` WHERE login = \'"+login+'\';')[0]
      return user_m_ssn["Worker_Manager_SSN"]
    end

  end

  def is_worker?(login)
    return ((is_receptionist? login) )||((is_manager? login))
  end

  def client?
    result = run_sql_script('SELECT `Client_national_id` FROM `mydb`.`User` WHERE `login` = \''+current_user["login"]+'\';')[0]
    return !(result["Client_national_id"].nil?)
  end
end
