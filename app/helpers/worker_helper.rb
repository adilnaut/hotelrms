module WorkerHelper
  def drop_constraints
    sql_drop = get_queries read_file 'drop.sql'

    connection = ActiveRecord::Base.connection()

    for query in sql_drop
      connection.execute(query)
    end
  end
  def add_constraints
    sql_alter = get_queries read_file 'alter.sql'
    connection = ActiveRecord::Base.connection()
    for query in sql_alter
      connection.execute(query)
    end
  end
  def read_file(file_name)
    file = File.open(file_name, "r")
    data = file.read
    file.close
    return data
  end

  def get_queries(sql_document)
    queries = sql_document.split(";")
    queries.pop(1)
    return queries
  end

  def get_worker_type_by_ssn(given_ssn)
    result = run_sql_script("SELECT * FROM `mydb`.`Worker` WHERE SSN="+given_ssn.to_s+";")[0]
    if !(result["Manager_SSN"].nil?)
      return "Manager"
    elsif !(result["Receptionist_SSN"].nil?)
      return "Receptionist"
    else
      return "Not a worker"
    end
  end

  def get_MSSN_by_RSSN(given_ssn)
    result = run_sql_script("SELECT `Receptionist_Manager_SSN` FROM `mydb`.`Worker` WHERE SSN="+given_ssn.to_s+";")[0]
    return result["Receptionist_Manager_SSN"].to_s
  end

end
