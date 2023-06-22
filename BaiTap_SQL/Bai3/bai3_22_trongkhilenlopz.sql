use master
go
create database MarkManagement 
on primary(
	name= 'MarkManagement_dat',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai3\MarkManagement.mdf',
	size= 10MB,
	maxsize= 100MB,
	filegrowth= 10MB
)
log on(
	name= 'MarkManagement_log',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai3\MarkManagement.ldf',
	size= 1MB,
	maxsize= 5MB,
	filegrowth= 20%
)
go
use MarkManagement
go
create table Students(
	StudentID nvarchar(12) not null primary key,
	StudentName nvarchar(25) not null,
	DateOfBirth datetime not null,
	Email nvarchar(40),
	Phone nvarchar(12),
	Class nvarchar(10)
)
create table Subjects(
	SubjectID nvarchar(10) not null primary key,
	SubjectName nvarchar(25) not null
)
create table Mark(
	StudentID nvarchar(12) not null,
	SubjectID nvarchar(10) not null,
	DateMark datetime,
	Theory tinyint,
	Practical tinyint,
	constraint pk_Mark primary key(StudentID, SubjectID),
	constraint fk_Mark_Students foreign key (StudentID)
		references Students(StudentID),
	constraint fk_Mark_Subjects foreign key (SubjectID)
		references Subjects(SubjectID)
)
go
insert into Students
	values 
		('AV0807005', N'Mail Trung Hiếu', '11/10/1989', 'trunghieu@yahoo.com', '0904115116', 'AV1'),
		('AV0807006', N'Nguyễn Quý Hùng', '2/12/1988', 'quyhung@yahoo.com', '0955667787', 'AV2'),
		('AV0807007', N'Đỗ Đắc Huỳnh', '2/1/1990', 'dachuynh@yahoo.com', '0988574747', 'AV2'),
		('AV0807009', N'An Đăng Khuê', '6/3/1986', 'dangkhue@yahoo.com', '0986757463', 'AV1'),
		('AV0807010', N'Nguyễn T. Tuyết Lan', '12/7/1989', 'tuyetlan@gmail.com', '098331034', 'AV2'),
		('AV0807011', N'Đinh Phụng Long', '2/12/1990', 'phunglong@yahoo.com',null, 'AV1'),
		('AV0807012', N'Nguyễn Tuấn Nam', '2/3/1990', 'tuannam@yahoo.com', null, 'AV1')
go
insert into Subjects
	values 
		('S001', 'SQL'),
		('S002', 'Java Simplefield'),
		('S003', 'Active Server Page')
go
insert into Mark
	values
		('AV0807005', 'S001', '6/5/2008', 8, 25),
		('AV0807006', 'S002', '6/5/2008', 16, 30),
		('AV0807007', 'S001', '6/5/2008', 10, 25),
		('AV0807009', 'S003', '6/5/2008', 7, 13),
		('AV0807010', 'S003', '6/5/2008', 9, 16),
		('AV0807011', 'S002', '6/5/2008', 8, 30),
		('AV0807012', 'S001', '6/5/2008', 7, 31),
		('AV0807005', 'S002', '6/5/2008', 12, 11),
		('AV0807009', 'S002', '6/6/2008', 11, 20),
		('AV0807010', 'S001', '6/6/2008', 7, 6)
go
--1. Hiển thị nội dung bảng Students
select *
from Students
--2. Hiển thị nội dung danh sách sinh viên lớp AV1
select *
from Students
where Class='AV1'
--3. Sử dụng lệnh UPDATE để chuyển sinh viên có mã AV0807012 sang lớp 
--AV2
update Students
set Class = 'AV2'
where Students.StudentID='AV0807012'
--4. Tính tổng số sinh viên của từng lớp
select Class, count(StudentID) as 'Số sinh viên'
from Students
group by Class
--5. Hiển thị danh sách sinh viên lớp AV2 được sắp xếp tăng dần theo 
--StudentName
select *
from Students
where Class = 'AV2'
order by StudentName asc
--6. Hiển thị danh sách sinh viên không đạt lý thuyết môn S001 (theory <10) thi 
--ngày 6/5/2008
select *
from Students inner join Mark on Students.StudentID=Mark.StudentID
where Theory<10 and DateMark='6/5/2008'
--7. Hiển thị tổng số sinh viên không đạt lý thuyết môn S001. (theory <10)
select COUNT(Students.StudentID) as 'số sinh viên không đạt lý thuyết môn S001'
FROM Students inner join Mark on Students.StudentID=Mark.StudentID
where Theory<10 and Mark.SubjectID='S001'

--8. Hiển thị Danh sách sinh viên học lớp AV1 và sinh sau ngày 1/1/1980
select *
from Students
where Class='AV1' and DateOfBirth>'1/1/1980'
--9. Xoá sinh viên có mã AV0807011
alter table Mark drop 
constraint fk_Mark_Students
delete from Students
where Students.StudentID='AV0807011'
--10.Hiển thị danh sách sinh viên dự thi môn có mã S001 ngày 6/5/2008 bao gồm 
--các trường sau: StudentID, StudentName, SubjectName, Theory, Practical, Date

select Mark.StudentID, StudentName, SubjectName, Theory, Practical, DateMark
from Students inner join Mark on Students.StudentID=Mark.StudentID
inner join Subjects on Subjects.SubjectID=Mark.SubjectID
where Mark.SubjectID='S001' AND DateMark='6/5/2008'