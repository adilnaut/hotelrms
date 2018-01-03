module ApplHelper
  def get_appl_by_RSSN(given_ssn)
    result = run_sql_script("SELECT * FROM `mydb`.`Applications` WHERE `Worker_Receptionist_SSN`="+given_ssn.to_s+";")
    return result
  end
  def reserved? (res)
    if res.nil?
      return "Not reserved"
    else
      return "Reserved"
    end
  end

  def get_appl_by_MSSN(given_ssn)
    result = run_sql_script("SELECT * FROM `mydb`.`Applications` WHERE `Worker_Manager_SSN`="+given_ssn.to_s+";")
    return result
  end

  def get_resr_by_MSSN(given_ssn)
    result = run_sql_script("SELECT * FROM `mydb`.`Reservations` WHERE `Worker_Manager_SSN`="+given_ssn.to_s+";")
    return result
  end
end
