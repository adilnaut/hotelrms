module UserHelper
  def run_sql_script(script)
    connection = ActiveRecord::Base.connection()
    sql_scripts = []
    sql_scripts.push('USE `mydb`;')
    sql_scripts.push(script)
    last = nil
    begin
      for command in sql_scripts
        last = connection.select_all(command)
      end
    rescue
      last = false
    end
    if last.nil?
      last = true
    else
      # if last[0].nil?
      #   last = true
      # end
    end
    puts "--------------DEBUG-----------------"
    puts last
    puts "---------------END------------------"
    #puts last

    return last
  end
end
