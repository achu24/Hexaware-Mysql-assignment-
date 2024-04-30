use ticketbookingsystem;
CREATE TABLE Event (event_id int primary key,
    event_name varchar(255),
    event_date date,
    event_time time,
    venue_id int,
    total_seats int,
    available_seats int,
    ticket_price decimal(5, 2),
    event_type enum('Movie', 'Sports', 'Concert'),
    booking_id int,
    foreign key (venue_id) references Venue(venue_id)
);
create table Customer (
    customer_id int primary key,
    customer_name varchar(255),
    email varchar(255),
    phone_number varchar(20),
    booking_id int
);

create table Booking (
    booking_id int primary key,
    customer_id int,
    event_id int,
    num_tickets int,
    total_cost decimal(5, 2),
    booking_date date,
    foreign key (customer_id) references Customer(customer_id),
    foreign key (event_id) references Event(event_id)
);
/* task 2*/
INSERT INTO Venue (venue_id, venue_name, address) VALUES
(1, 'Stadium', '123 Stadium Ave'),
(2, 'Concert Hall', '456 Music St'),
(3, 'Cinema', '789 Movie St'),
(4, 'Arena', '10 Sports Rd'),
(5, 'Amphitheater', '1 Park Lane'),
(6, 'Convention Center', '555 Conference Ave'),
(7, 'Auditorium', '700 Performance St'),
(8, 'Field', '888 Sport Ave'),
(9, 'Theatre', '999 Drama St'),
(10, 'Club', '100 Nightlife Rd');

insert into Event (event_id, event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id) VALUES
(11, 'Movie Night', '2024-05-01', '18:00:00', 3, 100, 10, 10.00, 'Movie', 1111),
(22, 'Basketball Game', '2024-05-02', '19:30:00', 1, 5000, 2500, 20.00, 'Sports', 2222),
(33, 'Concert', '2024-05-03', '20:00:00', 2, 2000, 250, 30.00, 'Concert', 3333),
(44, 'Football Match', '2024-05-04', '15:00:00', 4, 15000, 850, 25.00, 'Sports', 4444),
(55, 'Outdoor Play', '2024-05-05', '16:00:00', 5, 500, 500, 15.00, 'Concert', 5555),
(66, 'Movie Night', '2024-05-01', '18:00:00', 3, 100, 100, 10.00, 'Movie', 6666),
(77, 'World cup ', '2024-05-07', '20:30:00', 1, 15000, 800, 20.00, 'Sports', 7777),
(88, 'Soccer Match', '2024-05-08', '14:00:00', 8, 20000, 20000, 30.00, 'Sports', 8888),
(99, 'Musical', '2024-05-09', '19:00:00', 9, 1500, 1500, 40.00, 'Concert', 9999),
(101, 'Concert', '2024-05-03', '20:00:00', 2, 2000, 2000, 30.00, 'Concert', 1010);

INSERT INTO Customer (customer_id, customer_name, email, phone_number, booking_id) VALUES
(111, 'Alice', 'alice@example.com', '123-456-7890', 1111),
(222, 'Bob', 'bob@example.com', '111-111-1189', 2222),
(333, 'Charlie', 'charlie@example.com', '990-555-5555', 3333),
(444, 'David', 'david@example.com', '987-765-4322', 4444),
(555, 'Eva', 'eva@example.com', '913-476-8569', 5555),
(666, 'Frank', 'frank@example.com', '121-212-1212', 6666),
(777, 'Grace', 'grace@example.com', '111-110-0000', 7777),
(888, 'Henry', 'henry@example.com', '112-222-2222', 8888),
(999, 'Isabel', 'isabel@example.com', '124-444-4444', 9999),
(110, 'Jack', 'jack@example.com', '111-666-6666', 1010);

INSERT INTO Booking (booking_id, customer_id, event_id, num_tickets, total_cost, booking_date) VALUES
(1111, 111, 11, 2, 20.00, '2024-04-27'),
(2222, 222, 22, 4, 80.00, '2024-04-28'),
(3333, 333, 33, 1, 30.00, '2024-04-29'),
(4444, 444, 44, 3, 75.00, '2024-04-30'),
(5555, 555, 55, 2, 30.00, '2024-05-01'),
(6666, 666, 66, 1, 50.00, '2024-05-02'),
(7777, 777, 77, 2, 40.00, '2024-05-03'),
(8888, 888, 88, 5, 150.00, '2024-05-04'),
(9999, 999, 99, 2, 80.00, '2024-05-05'),
(1010, 110, 101, 3, 75.00, '2024-05-06');
INSERT INTO Booking values(1112,999,99,0,80.00,'2024-05-06');
alter table Event add constraint fk_event foreign key(booking_id) references booking(booking_id);
alter table Customer add constraint fk_customer foreign key(booking_id) references booking(booking_id);

Select * from event;
select * from event where available_seats>0;
select * from event where event_name like "%cup%";
select * from event where ticket_price between 1000 and 2500;
select * from event where event_date between '2024-05-03' and '2024-05-08' order by event_date; 
select * from event where available_seats>0 and event_name like"%Concert%";

select*from booking where num_tickets>4; 
select*from customer where phone_number like "%000"; 
select*from event where total_seats >15000 order by total_seats;
select* from event where event_name not like'x%'and event_name not like'y%'and event_name not like'z%';

/* task 3*/
select event_name, avg(ticket_price) from event group by event_name;
select event_name, sum(total_cost) from booking join event on booking.event_id= event.event_id group by event_name;
select event_name, SUM(num_tickets) FROM Booking, event where booking.event_id = event.event_id GROUP BY event_name ORDER BY sum(num_tickets) DESC LIMIT 1;
select event_name, sum(num_tickets) from booking join event on Booking.event_id = event.event_id group by event_name;
select event_name from event e left join booking b on e.event_id = b.event_id where num_tickets is null;
select c.customer_id, c.customer_name, max(b.num_tickets) from customer c left join booking b on c.customer_id = b.customer_id group by c.customer_id,c.customer_name order by max(b.num_tickets) desc limit 1;
select e.event_id, e.event_name, sum(b.num_tickets), month(b.booking_date) from event e left join booking b on e.event_id =b.event_id group by e.event_id,month(b.booking_date) order by month(b.booking_date);
select v.venue_id, v.venue_name, avg(e.ticket_price) from venue v left join event e on v.venue_id = e.event_id group by v.venue_id, v.venue_name;
select event_type, count(event_type), sum(num_tickets) from event left join booking on event.event_id = booking.event_id group by event_type;
select year(booking_date), sum(total_cost) from booking group by year(booking_date);
select c.customer_id, c.customer_name, COUNT(b.event_id) as num_total_events from customer c join booking b on c.customer_id=b.customer_id group by customer_id, customer_name having count(b.event_id) >1;
select c.customer_id, c.customer_name, sum(b.total_cost) from customer c left join booking b on c.customer_id=b.customer_id group by c.customer_id, c.customer_name;
select v.venue_name, e.event_type,avg(e.ticket_price) from venue v right join event e on e.venue_id=v.venue_id group by e.event_type, v.venue_name;
select c.customer_name, count(b.booking_id) from customer c left join booking b on c.customer_id=b.customer_id group by c.customer_name;

/* task 4*/
select v.venue_name,(select avg(ticket_price) from event where venue_id = v.venue_id) from venue v;
select event_name, (total_seats - available_seats) from event where (select(total_seats - available_seats) from event e where e.event_id=event.event_id)>0.5*total_seats;
select event_name,(select sum(total_seats - available_seats) from event e where e.event_id = event.event_id) as total_tickets_sold from event;
select c.customer_name from customer c where not exists (select b.booking_id from booking b where b.customer_id = c.customer_id);
select event_id, event_name from event where (total_seats - available_seats) not in (select (total_seats - available_seats) from event where (total_seats - available_seats) <>0);
select e.event_type, sum(tickets_sold) from(select event_id, sum(num_tickets) as tickets_sold from booking group by event_id) b join event e on b.event_id = e.event_id group by e.event_type;
select event_name, ticket_price from event where ticket_price > (select avg(ticket_price) from event);
select c.customer_id, c.customer_name, (select sum(b.total_cost) from Booking b where b.customer_id = c.customer_id) as total_revenue from Customer c;
select customer_id, customer_name from customer where exists (select 1 from booking join event on booking.event_id = event.event_id where venue_id = 3 and booking.customer_id = customer.customer_id);
select e.event_type, sum(tickets_sold) from(select event_id, sum(num_tickets) as tickets_sold from booking group by event_id) b join event e on b.event_id = e.event_id group by e.event_type;
select customer_name, month(booking_date) from customer c join booking b on b.customer_id=c.customer_id where month(booking_date) = (select month(booking_date) from booking b limit 1);
select v.venue_name,(select avg(ticket_price) from event where venue_id = v.venue_id) from venue v;

