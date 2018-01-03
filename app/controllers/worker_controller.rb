class WorkerController < ApplicationController
  def new
    if !admin?
      redirect_to root_path
    end
    @@user_login = params[:login]
    if params[:worker_type].eql? "Manager"
      @@user_worker_type = "Worker_Manager_SSN"
    end
    if params[:worker_type].eql? "Receptionist"
      @@user_worker_type = "Worker_Receptionist_SSN"
    end
    managers = run_sql_script('SELECT * from `mydb`.`Worker`WHERE `Manager_SSN` IS NOT NULL;')
    options = []
    for manager in managers
      options.push([manager["First_n"]+" "+manager["Second_n"], manager["SSN"]])
    end
    @options = options
    @worker_type = params[:worker_type]

  end

  def create

    if admin?
      values = []
      keys = []
      params[:worker].each do |key, value|
        keys.push('`'+key+'`')
        if key == "Salary" || key == "SSN"
          values.push(value)
        else
          values.push('\''+value+'\'')
        end
      end
      if @@user_worker_type.eql? "Worker_Receptionist_SSN"
        keys.push('`Receptionist_Manager_SSN`')
        values.push(params[:rec_ssn])
      end


      result = run_sql_script("INSERT INTO `mydb`.`Worker` ("+keys.join(",")+") VALUES ("+values.join(",")+");")
      if result
        drop_constraints
        run_sql_script("UPDATE `mydb`.`User` SET `"+@@user_worker_type+"` = "+values[0]+" WHERE `login` = \'"+@@user_login+"\';" )
        run_sql_script("UPDATE `mydb`.`Worker` SET `"+@@user_worker_type.gsub('Worker_','')+"` = "+values[0]+" WHERE `SSN` = "+values[0]+";")
        add_constraints
        redirect_to '/worker/show/?SSN='+values[0]
      else
        flash.now[:danger] = "Incorrect values"
        render "new"
      end
    end
  end

  def destroy
    if admin?
      run_sql_script("DELETE FROM `mydb`.`Worker` WHERE `SSN` = " + params[:SSN] + ';')
      redirect_to root_path
    end
  end

  def show
    if !flash[:smess].nil?
      flash.now[:success] = flash[:smess]
    end
    if !flash[:dmess].nil?
      flash.now[:danger] = flash[:dmess]
    end
    # flash.clear
    @worker = run_sql_script('SELECT * FROM `mydb`.`Worker` WHERE `SSN` = '+params[:SSN]+';')[0]
    wtype = get_worker_type_by_ssn params[:SSN]
    if wtype.eql? "Manager"
      @his_rec = run_sql_script('SELECT * FROM `mydb`.`Worker` WHERE `Receptionist_Manager_SSN` = '+params[:SSN]+';')
    elsif wtype.eql? "Receptionist"
      his_r_m_ssn = run_sql_script('SELECT `Receptionist_Manager_SSN` FROM `mydb`.`Worker` WHERE `SSN` = '+params[:SSN]+';')[0]["Receptionist_Manager_SSN"]
      @his_man = run_sql_script('SELECT * FROM `mydb`.`Worker` WHERE SSN = '+his_r_m_ssn.to_s+';')[0]
    end
    flash[:someval] = params[:SSN]
    result = run_sql_script("SELECT * FROM `mydb`.`Room`;")
    prices = []
    nums = []
    result.each do |room|
      prices.push([room["price"]/room["num_of_beds"], room["price"]/room["num_of_beds"]])
      nums.push([room["num_of_beds"], room["num_of_beds"] ])
    end
    prices.uniq!
    nums.uniq!
    @prices = prices
    @nums = nums
  end



end
