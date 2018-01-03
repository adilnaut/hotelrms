class ReservationController < ApplicationController
  def new
    if !(manager?)
      redirect_to root_path
    end
    appl_id = params[:id]
    appl_result = run_sql_script("SELECT * FROM Applications WHERE id ="+appl_id.to_s+";")[0]
    rooms = run_sql_script("SELECT number from Room WHERE price ="+appl_result["price"].to_s+" AND num_of_beds="+appl_result["num_of_beds"].to_s+";")
    possible_rooms = []
    for room in rooms
      room_number = room["number"].to_s
      result = run_sql_script("SELECT * FROM Reservations, Applications  WHERE Applications.Reservations_id = Reservations.id AND Reservations.Room_number ="+room_number+
      " AND( Applications.to_d >= STR_TO_DATE('" +(appl_result["from_d"].to_s)+"', '%Y-%m-%d') AND Applications.from_d <= STR_TO_DATE('" + (appl_result["to_d"].to_s) +"', '%Y-%m-%d') ) ;")

      if (result[0].nil?)
        possible_rooms.push(room_number)
      end
    end
    if (possible_rooms.length) == 0
      # @reserved = "No rooms available"
      # flash.now[:danger] = "No rooms available"
      flash[:dmess] = "No rooms available"
    else
      chosen_room = possible_rooms[0]
      result = run_sql_script("INSERT INTO `mydb`.`Reservations`(`status`, `Worker_Manager_SSN`,`Room_number`, `Client_national_id`) VALUES (\'no\',\'"+appl_result["Worker_Manager_SSN"].to_s+"\',\'"+chosen_room.to_s+"\',\'"+appl_result["Client_national_id"].to_s+"\');")
      res_id = run_sql_script("SELECT LAST_INSERT_ID();")[0]["LAST_INSERT_ID()"].to_s
      if result
        # @reserved = "Room successfully reserved"
        # flash.now[:success] = "Room successfully reserved"
        flash[:smess] = "Room successfully reserved"
        drop_constraints
        result = run_sql_script("UPDATE `mydb`.`Applications` SET `Reservations_id`="+res_id+" WHERE `id` ="+appl_id.to_s+";")
        add_constraints
      else
        # @reserved = "Room is not reserved, some error"
        # flash.now[:danger] = "Room is not reserved, some error"
        flash[:dmess] = "Room is not reserved, some error"
      end
    end
    redirect_to '/worker/show?SSN='+appl_result["Worker_Manager_SSN"].to_s
   end

  def checkin
    id = params[:id]
    mSSN = params[:MSSN]
    result = run_sql_script("UPDATE `mydb`.`Reservations` SET status='checked in' WHERE id="+id.to_s+";")
    redirect_to '/worker/show?SSN='+mSSN.to_s
  end

  def destroy
    id = params[:id]
    mSSN = params[:MSSN]
    result = run_sql_script("DELETE FROM `mydb`.`Applications` WHERE Reservations_id='"+id.to_s+"';")
    result = run_sql_script("DELETE FROM `mydb`.`Reservations` WHERE id='"+id.to_s+"';")
    redirect_to '/worker/show?SSN='+mSSN.to_s
  end

  def edit
  end

  def index
  end

  def show
  end
end
