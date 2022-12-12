/*-------to create table----------*/
---## create  4xDimension
--#1 Dimension - branch
CREATE TABLE branch(
	branch_id INT NOT NULL PRIMARY KEY,
	location VARCHAR(150));
--#2  Dimension - order_item
CREATE TABLE order_item(
	order_id INT,
	order_item_id INT,
	menu_id INT,
	quantity INT);
--#3  Dimension - menu
CREATE TABLE menu (
	menu_id INT NOT NULL PRIMARY KEY,
	menu_name VARCHAR(150),
	price DECIMAL);
--#4  Dimension - member
CREATE TABLE  member(
	member_id  INT NOT NULL PRIMARY KEY,
	name VARCHAR(150),
	birth_date DATE,
	mobile_no VARCHAR(50),
	active_date DATE );
--#5  Dimension -  saler
CREATE TABLE saler(
	saler_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(150),
	active_date DATE,
	status VARCHAR(20));
--##create  1xFact
CREATE TABLE orders(
	order_id INT NOT NULL PRIMARY KEY,
	order_date DATETIME,
	member_id INT,
	saler_id   INT ,
	branch_id  INT ,
	total_amount  DECIMAL ,
  FOREIGN KEY (member_id) REFERENCES member(member_id),
	FOREIGN KEY (saler_id) REFERENCES saler(saler_id),
	FOREIGN KEY (branch_id) REFERENCES branch(branch_id),
	FOREIGN KEY (order_id) REFERENCES order_item(order_item_id));
/*----------to insert data----------*/
--##insert  menu 
INSERT INTO menu VALUES 
(1,'Banana bread',89),
(2,'Cornbread',70),
(3,'Cuban bread',65),
(4,'Frybread',62),
(5,'Texas toast' ,70),
(6,'Calas',98),
(7,'Charleston red rice',120),
(8,'Chicken bog',45),
(9,'Dirty rice',65),
(10,'Glorified rice',55),
(11,'Gumbo',80),
(12,'Hawaiian haystack',45),
(13,'Jambalaya',45),
(14,'Rice and gravy',65),
(15,'Red beans and rice',85),
(16,'Shrimp creole',180),
(17,'Spanish rice',150),
(18,'coffee',50),
(19,'milk',35),
(20,'water',20);
--##insert  member
INSERT INTO member VALUES 
(1,'Mary','1985-05-05','0068944449','2017-05-18'),
(2,'Jim','1992-02-16','1588166825','2015-02-11'),
(3,'Ann','1979-01-01','-','2017-06-17'),
(4,'Niky','1977-10-14','-','2018-05-27'),
(5,'Deny','1988-06-26','058962222','2020-01-01'),
(6,'Mike','1995-11-28','-','2021-06-18'),
(7,'Tim','1999-02-16','00988522','2014-05-29');
--##insert  saler 
INSERT INTO saler VALUES 
(1,'Ying','2019-06-17','ACTIVE'),
(2,'Poo','2018-05-27','ACTIVE'),
(3,'Karn','2018-11-27','ACTIVE'),
(4,'Tik','2020-06-24','ACTIVE');
--##insert  branch
INSERT INTO branch VALUES 
(1,'New York'),
(2,'Los Angeles'),	
(3,'Chicago'),
(4,'Boston');
--##insert  order_item
INSERT INTO order_item VALUES 
(1, 1,1,1),
(1, 2,6,1),
(2, 1,8,1),
(3,1 ,4,2),
(3, 2,19,1),
(4,1 ,17,1),
(5, 1,12,3),
(6,1 ,14,1),
(6, 2,12,1),
(6, 3,8,2),
(7, 1,5,3),
(8, 1,10,1),
(9,1 ,9,2),
(10, 1,12,1),
(11,1 ,3,2),
(12, 1,4,1),
(12,2 ,6,1),
(13,1 ,13,1),
(14, 1,5,1),
(15, 1,16,2),
(15, 2,4,1),
(16,1 ,3,2),
(17, 1,1,1),
(18, 1,1,1),
(19, 1,9,1),
(20,1 ,8,1);
--##insert  orders
INSERT INTO orders VALUES 
(1, '2022-08-06 10.12.26',1,1,3,187),
(2, '2022-08-15 19.22.14',4,2,3,45),
(3, '2022-08-30 13.12.45',3,1,4,167),
(4, '2022-09-01 11.20.42',3,2,4,150),
(5, '2022-09-01 15.20.45',1,3,1,135),
(6, '2022-09-01 20.18.26',3,1,1,200),
(7, '2022-09-02 16.12.26',7,2,2,210),
(8, '2022-09-02 19.55.22',2,1,2,55),
(9, '2022-09-02 21.12.26',3,4,3,130),
(10, '2022-09-02 10.45.26',3,1,4,45),
(11, '2022-09-03 14.12.28',4,2,4,130),
(12, '2022-09-03 16.30.45',2,4,3,160),
(13, '2022-09-03 20.14.36',3,1,2,45),
(14, '2022-09-04 10.19.03',5,2,2,70),
(15, '2022-09-04 16.45.26',4,3,1,422),
(16, '2022-09-05 12.30.55',3,1,1,130),
(17, '2022-09-05 13.45.15',3,4,3,89),
(18, '2022-09-05 16.22.50',6,3,4,89),
(19, '2022-09-05 18.12.30',3,1,2,65),
(20, '2022-09-06 19.06.43',2,4,1,45);
/*----------to query table----------*/
.mode markdown
.header on 
--## 1. popular menu all branch
select  r.menu_id ,m.menu_name ,count(*) 'sales_number' 
from order_item r join  menu  m on  r.menu_id = m.menu_id 
group by r.menu_id 
order by 3 DESC

--## 2. sales  by  branch
select  ROW_NUMBER() OVER(order by 3 DESC) AS 'No.', b.branch_id ,b.location,sum(r.total_amount) AS 'Total_Amount' from orders r join branch b on r.branch_id = b.branch_id group by   b.branch_id  

--## 3. frequently ,average spending member 
select m.member_id , m.name , count(*) as 'frequently' ,ROUND(AVG(total_amount),2) as 'avg_total_amt' from orders o join member m on o.member_id = m.member_id
group by m.member_id order by 4 DESC
  
--## 4. popular menu  by  branch
with sub AS ( -- With Sub Table
select b.branch_id , b.location, r.menu_id ,m.menu_name ,count(*) 'sales_number' 
from order_item r join  menu  m on  r.menu_id = m.menu_id
     join orders  o on o.order_id = r.order_id
     join branch b on o.branch_id = b.branch_id
     group by b.branch_id,r.menu_id 
)
select  location,menu_name ,sales_number
from  sub --use sub table
order by 1,3 DESC 
