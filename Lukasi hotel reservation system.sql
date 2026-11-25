create schema Lukasi_hotel_reservation_system;


use Lukasi_hotel_reservation_system;

create table customers(
customer_id int auto_increment primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(50),
date_of_birth date,
phone_number varchar(20),
country varchar(50),
address_1 varchar(150),
address_2 varchar(150),
city varchar(30),
zip_code varchar (25) );

create table bookings(
booking_id int auto_increment primary key,
check_in date not null,
check_out date not null,
meal_status enum ('all inclusive','bed & breakfast','room only'),
customer_notes text
);
create table customer_bookings(
customer_id int not null,
booking_id int not null, 
primary key(customer_id,booking_id),
foreign key(customer_id) references customers(customer_id),
foreign key(booking_id) references bookings(booking_id));


create table room_description(
room_type enum('Kifaru suite','Ndovu suite','Nairobae suite','Umondo suite') primary key,
nightly_rate decimal(10,2),
description text not null
);

create table rooms(
room_number char(5) primary key,
status varchar(20) default'un-occupied',
room_type enum ('Kifaru suite','Ndovu suite','Nairobae suite','Umondo suite'),
foreign key (room_type) references room_description(room_type));


create table booked_rooms(
booking_id int,
room_number char(5),
primary key(booking_id,room_number),
foreign key (booking_id) references bookings(booking_id),
foreign key (room_number) references rooms(room_number)
);


create table resturant(
order_id int auto_increment primary key,
booking_id int,
customer_id int,
foreign key (customer_id) references customers(customer_id),
foreign key (booking_id) references bookings(booking_id)
);

create table transactions(
transaction_id int  auto_increment primary key,
payment_method enum ('bank transfer','card payment','m-pesa','cash upfront'),
amount decimal (10,2),
payment_status varchar(15) default 'pending',
order_id int null,
booking_id int null,
foreign key (order_id) references resturant(order_id),
foreign key (booking_id) references bookings(booking_id),
check(
        (order_id is not null and booking_id is null)
        or (order_id is null and booking_id is not null)
      )
);








