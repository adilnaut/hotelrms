class ApplController < ApplicationController
  def rnew
    @@Rec_SSN = params[:SSN]
  end

  def rcreate
    @@Rec_SSN = flash[:someval]
    if receptionist?
      result = run_sql_script("INSERT INTO `mydb`.`Client` VALUES(\'"+params[:appl][:national_id]+"\',\'"+params[:appl][:first_n]+"\', \'"+params[:appl][:last_n]+"\');")
      if !result
        flash.now[:danger] = "Incorrect values"
        render "new"
      end
      nat_id = params[:appl][:national_id]
      params[:appl].delete(:national_id)
      params[:appl].delete(:first_n)
      params[:appl].delete(:last_n)
      values = []
      keys = []
      params[:appl].each do |key, value|
        values.push('\''+value+'\'')
        keys.push('`'+key+'`')
      end
      keys.push('`price`')
      values.push("\'"+(params[:price].to_i*params[:num_of_beds].to_i).to_s+"\'")
      keys.push('`num_of_beds`')
      values.push("\'"+params[:num_of_beds]+"\'")
      keys.push('`Worker_Receptionist_SSN`')
      values.push(@@Rec_SSN.to_s)
      keys.push('`Client_national_id`')
      values.push(nat_id.to_s)
      keys.push('`Worker_Manager_SSN`')
      values.push(get_MSSN_by_RSSN @@Rec_SSN)
      result = run_sql_script("INSERT INTO `mydb`.`Applications` ("+keys.join(",")+") VALUES ("+values.join(",")+");")
      if result
        redirect_to '/worker/show?SSN='+@@Rec_SSN
      else
        flash.now[:danger] = "Incorrect values"
        render "new"
      end

    end
  end

  def cnew
  end

  def ccreate
  end

  def show
  end

  def index
  end
end
