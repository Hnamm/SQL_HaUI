use master
go
create database DeptEmp
on primary(
	name= 'DeptEmp_dat',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai2\DeptEmp.mdf',
	size= 10MB,
	maxsize= 100MB,
	filegrowth= 10MB
)
log on(
	name= 'DeptEmp_log',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai2\DeptEmp.ldf',
	size= 1MB,
	maxsize= 5MB,
	filegrowth= 20%
)
go
use DeptEmp
go
create table Department(
	DepartmentNo integer not null primary key,
	DepartmentName char(25) not null,
	LocationDe  char(25) not null 
)
create table Employee(
	EmpNo Integer  not null PRIMARY KEY ,
    Fname varchar(15)  NOT NULL,
    Lname Varchar(15) NOT NULL,
    Job Varchar(25)  NOT NULL,
    HireDate Datetime  NOT NULL,
    Salary Numeric NOT NULL,
    Commision Numeric  ,
    DepartmentNo Integer ,
	constraint fk_department_employee foreign key(DepartmentNo)
		references Department(DepartmentNo)
)
go
insert into Department
	values
		('10', 'Accounting', 'Melbo'),
        ('20', 'Research', 'Adealid'),
        ('30', 'Sales', 'Sydney'),
        ('40', 'Operations', 'Perth')
go
insert into Employee
    values
		('1', 'John',  'Smith', 'Clerk', '17-Dec-1980', 800, null, 20),
		('2', 'Peter', 'Allen', 'Salesman', '20-Feb-1981', 1600, 300, 30),
		('3', 'Kate', 'Ward', 'Salesman', '22-Feb-1981', 1250, 500, 30),
		('4', 'Jack', 'Jones', 'Manager', '02-Apr-1981', 2975, null, 20),
		('5', 'Joe', 'Martin', 'Salesman', '28-Sep-1981', 1250, 1400, 30)
go
--1. Hiển thị nội dung bảng Department
select *
from Department
--2. Hiển thị nội dung bảng Employee
select *
from Employee

--3. Hiển thị employee number, employee first name và employee last name từ bảng Employee mà employee first name có tên là ‘Kate’.
select EmpNo, Fname, Lname 
from Employee 
where Fname='Kate'
--4. Hiển thị ghép 2 trường Fname và Lname thành Full Name, Salary, 
--10%Salary (tăng 10% so với lương ban đầu).
select concat(Fname,' ', Lname) as FullName, Salary from Employee 
--5. Hiển thị Fname, Lname, HireDate cho tất cả các Employee có HireDate là 
--năm 1981 và sắp xếp theo thứ tự tăng dần của Lname.
select Fname, Lname, HireDate 
from Employee 
where year(HireDate) = 1981 
order by Lname
--6. Hiển thị trung bình(average), lớn nhất (max) và nhỏ nhất(min) của 
--lương(salary) cho từng phòng ban trong bảng Employee.
select Department.DepartmentName, avg(Salary) as 'Trung binh', max(Salary) as'Luong lon nhat', min(Salary) as 'Luong nho nhat'
from Employee inner join Department on Employee.DepartmentNo=Department.DepartmentNo
group by Department.DepartmentName
--7. Hiển thị DepartmentNo và số người có trong từng phòng ban có trong bảng 
--Employee.
select Employee.DepartmentNo, count(EmpNo)
from Employee inner join Department on Employee.DepartmentNo=Department.DepartmentNo
group by Employee.DepartmentNo
--8. Hiển thị DepartmentNo, DepartmentName, FullName (Fname và Lname), 
--Job, Salary trong bảng Department và bảng Employee.
select Employee.DepartmentNo, DepartmentName, concat(Fname,' ',Lname) as FullName, Job, Salary
from Employee inner join Department on Employee.DepartmentNo=Department.DepartmentNo
--9. Hiển thị DepartmentNo, DepartmentName, Location và số người có trong 
--từng phòng ban của bảng Department và bảng Employee.
select Department.DepartmentNo, DepartmentName, LocationDe, count(Employee.EmpNo) as 'So Nhan Vien'
from Employee inner join Department on Employee.DepartmentNo=Department.DepartmentNo
group by Department.DepartmentNo, DepartmentName, LocationDe
--10. Hiển thị tất cả DepartmentNo, DepartmentName, Location và số người có 
--trong từng phòng ban của bảng Department và bảng Employee
select Department.DepartmentNo, DepartmentName, LocationDe, count(Employee.EmpNo) as 'So Nhan Vien'
from Employee inner join Department on Employee.DepartmentNo=Department.DepartmentNo
group by Department.DepartmentNo, DepartmentName, LocationDe