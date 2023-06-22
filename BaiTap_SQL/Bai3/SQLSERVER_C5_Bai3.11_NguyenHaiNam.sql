use master
go

create database DeptEmp
go

use DeptEmp
go

create table Department(
	DepartmentNo int not null primary key,
	DepartmentName char(25) not null,
	Location char(25) not null

)

create table Employee(
	EmpNo int not null primary key,
	Fname varchar(15) not null,
	Lname varchar(15) not null,
	Job varchar(25) not null,
	HireDate Datetime not null,
	Salary numeric not null,
	commision numeric,
	DepartmentNo int not null 
	constraint FK_Employee_Department foreign key (DepartmentNo) 
		references Department(DepartmentNo)
)
go

insert into Department
values(10, 'Accounting', 'Melbourne'),
(20, 'Research', 'Adealide'),
(30, 'Sales' ,'Sydney'),
(40, 'Operations' ,'Perth')

insert into Employee
values(1, 'John', 'Smith', 'Clerk' ,17-12-1980, 800, null, 20),
(2, 'Peter' ,'Allen' ,'Salesman', 20-11-1981 ,1600, 300, 30),
(3, 'Kate' ,'Ward', 'Salesman', 22-11-1981 ,1250, 500, 30),
(4, 'Jack', 'Jones', 'Manager', 02-07-1981 ,2975, null, 20),
(5, 'Joe', 'Martin', 'Salesman' ,28-09-1981 ,1250, 1400, 30)

--C1: Hiển thị nội dung bảng Department
select * from Department

--C2: Hiển thị nội dung bảng Employee
select * from Employee

--C3: Hiển thị employee number, employee first name và employee last name từ bảng Employee mà employee first name có tên là ‘Kate’
select EmpNo, Fname, Lname 
	from Employee
		where Fname = 'Kate'

--C4: Hiển thị ghép 2 trường Fname và Lname thành Full Name, Salary, 10%Salary (tăng 10% so với lương ban đầu). 
select concat(Fname,Lname) as 'Full Name', salary, 0.1*salary as 'Số lương tăng '
	from Employee

--C5: Hiển thị Fname, Lname, HireDate cho tất cả các Employee có HireDate là năm 1981 và sắp xếp theo thứ tự tăng dần của Lname
select Fname, Lname, HireDate 
	from Employee 
	where year(HireDate) = 1981
	order by Lname

--C6: Hiển thị trung bình(average), lớn nhất (max) và nhỏ nhất(min) của lương(salary) cho từng phòng ban trong bảng Employee.

select Department.departmentNo,DepartmentName, avg(salary) as 'Lương TB', max(salary) as 'Lương cao nhất', min(salary) as 'Lương thấp nhất'
	from Employee inner join Department
		on Employee.DepartmentNo = Department.DepartmentNo
			group by Department.departmentNo,DepartmentName

--C7: Hiển thị DepartmentNo và số người có trong từng phòng ban có trong bảng Employee.
select Employee.DepartmentNo, COUNT(EmpNo) as 'Số người'	from Employee		group by Employee.DepartmentNo--C8: Hiển thị DepartmentNo, DepartmentName, FullName (Fname và Lname), Job, Salary trong bảng Department và bảng Employee.
 select Employee.DepartmentNo, Department.DepartmentName, concat(Fname,' ', Lname) as 'Full name', job, salary	from Employee inner join Department
		on Employee.DepartmentNo = Department.DepartmentNo

--c9: Hiển thị DepartmentNo, DepartmentName, Location và số người có trong từng phòng ban của bảng Department và bảng Employee
SELECT Department.DepartmentNo, DepartmentName, location, COUNT(EmpNo) as 'Số người từng phòng'
	from Employee inner join Department
		on Employee.DepartmentNo = Department.DepartmentNo
		group by Department.DepartmentNo, DepartmentName, location

--C10: Hiển thị tất cả DepartmentNo, DepartmentName, Location và số người có trong từng phòng ban của bảng Department và bảng Employee
SELECT Department.DepartmentNo, DepartmentName, location, COUNT(EmpNo) as 'Số người từng phòng'
	from Employee inner join Department
		on Employee.DepartmentNo = Department.DepartmentNo
		group by Department.DepartmentNo, DepartmentName, location