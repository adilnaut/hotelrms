SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT;
SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS;
SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION;
SET NAMES utf8;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0;

USE `mydb`;

alter table `mydb`.`Worker`
  	add CONSTRAINT `fk_Worker_Worker1`
	    FOREIGN KEY (`Manager_SSN`)
	    REFERENCES `mydb`.`Worker` (`SSN`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION;
alter table `mydb`.`Worker`
    add CONSTRAINT `fk_Worker_Worker2`
      FOREIGN KEY (`Receptionist_SSN`)
      REFERENCES `mydb`.`Worker` (`SSN`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
alter table `mydb`.`Worker`
    add CONSTRAINT `fk_Worker1_Worker2`
      FOREIGN KEY (`Receptionist_Manager_SSN`)
      REFERENCES `mydb`.`Worker` (`Manager_SSN`)
      ON DELETE SET NULL
      ON UPDATE NO ACTION;
alter table `mydb`.`Reservations`
	add CONSTRAINT `fk_Reservations_Worker1`
	    FOREIGN KEY (`Worker_Manager_SSN`)
	    REFERENCES `mydb`.`Worker` (`Manager_SSN`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION;

alter table `mydb`.`Reservations`
	add CONSTRAINT `fk_Reservations_Room1`
	    FOREIGN KEY (`Room_number`)
	    REFERENCES `mydb`.`Room` (`number`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION;

alter table `mydb`.`Reservations`
	add CONSTRAINT `fk_Reservations_Client1`
	    FOREIGN KEY (`Client_national_id`)
	    REFERENCES `mydb`.`Client` (`national_id`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION;

alter table `mydb`.`Applications`
	add CONSTRAINT `fk_Applications_Worker1`
	    FOREIGN KEY (`Worker_Manager_SSN`)
	    REFERENCES `mydb`.`Worker` (`Manager_SSN`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION;

alter table `mydb`.`Applications`
  add CONSTRAINT `fk_Applications_Worker2`
      FOREIGN KEY (`Worker_Receptionist_SSN`)
      REFERENCES `mydb`.`Worker` (`Receptionist_SSN`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

alter table `mydb`.`Applications`
	add CONSTRAINT `fk_Applications_Client1`
	    FOREIGN KEY (`Client_national_id`)
	    REFERENCES `mydb`.`Client` (`national_id`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION;

alter table `mydb`.`Applications`
	add CONSTRAINT `fk_Applications_Reservations1`
	    FOREIGN KEY (`Reservations_id`)
	    REFERENCES `mydb`.`Reservations` (`id`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION;
alter table `mydb`.`User`
  add CONSTRAINT `fk_User_Worker1`
      FOREIGN KEY (`Worker_Manager_SSN`)
      REFERENCES `mydb`.`Worker` (`Manager_SSN`)
      ON DELETE SET NULL
      ON UPDATE NO ACTION;
alter table `mydb`.`User`
  add CONSTRAINT `fk_User_Worker2`
      FOREIGN KEY (`Worker_Receptionist_SSN`)
      REFERENCES `mydb`.`Worker` (`Receptionist_SSN`)
      ON DELETE SET NULL
      ON UPDATE NO ACTION;
alter table `mydb`.`User`
	add CONSTRAINT `fk_User_Client1`
	    FOREIGN KEY (`Client_national_id`)
	    REFERENCES `mydb`.`Client` (`national_id`)
	    ON DELETE NO ACTION
	    ON UPDATE NO ACTION;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT;
SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS;
SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION;
SET SQL_NOTES=@OLD_SQL_NOTES;
