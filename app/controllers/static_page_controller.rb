class StaticPageController < ApplicationController
  def main

    if (params.key? "result") && (params[:result].eql? "true")
      flash.now[:success] = "There are available rooms!"
    elsif (params.key? "result")
      flash.now[:danger] = "There are no available rooms!"
    end

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
  def search
    price = (params[:price].to_i*params[:num_of_beds].to_i).to_s
    num_of_beds = params[:num_of_beds]
    to_d = params[:static][:to_d]
    from_d = params[:static][:from_d]

    rooms = run_sql_script("SELECT number from Room WHERE price ="+price.to_s+" AND num_of_beds="+num_of_beds.to_s+";")

    possible_rooms = []
    for room in rooms
      room_number = room["number"].to_s
      result = run_sql_script("SELECT * FROM Reservations, Applications  WHERE Applications.Reservations_id = Reservations.id AND Reservations.Room_number ="+room_number+
      " AND( Applications.to_d >= STR_TO_DATE('"+((from_d).to_s)+"', '%Y-%m-%d') AND Applications.from_d <= STR_TO_DATE('" + (to_d.to_s) +"', '%Y-%m-%d') ) ;")
      if (result[0].nil?)
        possible_rooms.push(room_number)
      end
    end
    result = possible_rooms.length > 0
    redirect_to '/static_page/main?result='+result.to_s
  end
end
