use mydb;
alter table User drop foreign key fk_User_Worker1;
alter table User drop foreign key fk_User_Worker2;
alter table User drop foreign key fk_User_Client1;
alter table Applications drop foreign key fk_Applications_Reservations1;
alter table Applications drop foreign key fk_Applications_Client1;
alter table Applications drop foreign key fk_Applications_Worker2;
alter table Applications drop foreign key fk_Applications_Worker1;
alter table Reservations drop foreign key fk_Reservations_Client1;
alter table Reservations drop foreign key fk_Reservations_Room1;
alter table Reservations drop foreign key fk_Reservations_Worker1;
alter table Worker drop foreign key fk_Worker1_Worker2;
alter table Worker drop foreign key fk_Worker_Worker2;
alter table Worker drop foreign key fk_Worker_Worker1;
