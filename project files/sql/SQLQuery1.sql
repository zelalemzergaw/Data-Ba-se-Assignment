/*SELECT price,type FROM hotel h INNER JOIN room r on h.hotelNo = r.hotelNo where h.hotelName='palace'; 
select * from hotel
select * from guest
select * from booking
select * from Room
select * from hotel h inner join room r on h.hotelNo=r.hotelNo and h.hotelName='palace'
select c.fName,c.lName,propertyNo from  Client c,Viewing v where c.clientNo=v.clientNo
select p.*,b.* from branch b full join PropertyForRent p on b.city =p.city 


insert into hotel values (18,'palace','Burlington')
select s.staffNo,fName,lName,count(propertyNo) from staff s left join propertyForRent p on p.branchNo=s.branchNo group by s.staffNo,fName,lName
update room set price=price *0.8 where type='family'

select GETDATE()-3
*/
select g.guestName,g.guestNo from
guest g inner join booking b on
g.guestNo=b.guestNo inner join hotel h on h.hotelNo=b.hotelNo
where h.hotelName='palace' and b.dateTo>=GETDATE() and b.dateFrom<=GETDATE()
SELECT r.*,g.guestName 
from booking b inner join room r 
on b.roomNo=r.roomNo and b.hotelNo=r.hotelNo inner join guest g 
on b.guestNo=g.guestNo inner join hotel h 
on r.hotelNo=h.hotelNo where  
b.dateFrom <= GETDATE() AND b.dateTo>=GETDATE() AND h.hotelName='palace'

(select r.*
from room r inner join hotel h on r.hotelNo=h.hotelNo 
where h.hotelName='palace') except (SELECT r.* 
from booking b inner join room r 
on b.roomNo=r.roomNo and b.hotelNo=r.hotelNo inner join hotel h 
on r.hotelNo=h.hotelNo where  
b.dateFrom <= GETDATE() AND b.dateTo>=GETDATE())

SELECT r.hotelno, SUM(price) as Lost FROM Room r WHERE r.roomno 
NOT IN(SELECT b.roomNo FROM Booking b , Hotel  h
WHERE (b.datefrom <= GETDATE()
AND b.dateto >= GETDATE())AND b.hotelNo = h.hotelno)
 GROUP BY r.hotelno;

 select b.hotelNo,g.guestName,g.guestAddress from Booking b inner join guest g 
 on b.guestNo=g.guestNo inner join hotel h on b.hotelNo=h.hotelNo 
 where g.guestAddress=h.city and (b.datefrom <= GETDATE()
AND b.dateto >= GETDATE()) group by b.hotelNo,g.guestName,g.guestAddress
having count(b.hotelNo)>1



insert into hotel values (9,'Marriot','DesMoines')
insert into Room values (10,11,'family',106)
insert into guest values (11,'John','Omaha')

update r set r.price=r.price+r.price*0.05 from room
as r inner join hotel h ON h.hotelNo= r.hotelNo 
where h.hotelName='palace';

 CREATE TABLE Archive( hotelNo nchar(10) ,guestNo nchar(10) , 
 dateFrom DATETIME ,dateTo DATETIME, roomNo nchar(10),
PRIMARY KEY(hotelNo,guestNo,dateFrom),
FOREIGN KEY (hotelNo) REFERENCES hotel ,
FOREIGN KEY (guestNo) REFERENCES guest );


INSERT INTO Archive 
SELECT b.hotelNo, b.guestNo, b.dateFrom,b.dateTo,b.roomNo
FROM booking b 
WHERE b.dateFrom <= '2015-01-01 ';


DELETE FROM booking  WHERE dateFrom <= '2015-01-01';



(SELECT   b.hotelNo AS hotelNo ,r.type AS type,count(r.type) AS myCOUNT
   FROM booking b INNER JOIN room r  ON b.hotelNo = r.hotelNo 
   AND b.roomNo =r.roomNo INNER JOIN hotel h ON h.hotelNo= b.hotelNo 
   WHERE h.city ='fairfield' GROUP BY  r.type,b.hotelNo )


