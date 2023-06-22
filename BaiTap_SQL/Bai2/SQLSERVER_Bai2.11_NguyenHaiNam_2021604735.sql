use master 
go

create database MarkManagement
go

use MarkManagement
go

create table Student(
	StudentID nvarchar(12) not null primary key,
	StudentName nvarchar(25) not null,
	DateofBirth datetime not null,
	Email nvarchar(40),
	Phone nvarchar(12),
	class nvarchar(10)
)

create table Subjects(
	SubjectID nvarchar(10) not null primary key,
	SubjectName Nvarchar(25) not null
)

create table Mark(
	StudentID nvarchar(12) not null,
	SubjectID nvarchar(10) not null,
	theory tinyint,
	practical tinyint,
	Datee Datetime
	constraint PK_Mark primary key(StudentID, SubjectID)
	constraint FK_Mark_Student foreign key(StudentID)
		references Student(StudentID),
	constraint FK_Mark_Subjects foreign key(SubjectID)
		references Subjects(SubjectID)
)
go

insert into Student
values('AV0807005', N'Mai Trung Hiếu',11/10/1989,'trunghieu@yahoo.com','0904115116','AV1'),
('AV0807006', N'Nguyễn Quý Hùng',2/12/1988,'quyhung@yahoo.com','0904115116','AV2'),
('AV0807007', N'Đỗ Khắc Quỳnh',11/12/1993,'quynh93@yahoo.com','0904345116','AV2'),
('AV0807009', N'An Đăng Khuê',11/1/1981,'khuek22@yahoo.com','0904112316','AV1'),
('AV0807010', N'Nguyễn.T.Tuyết Lan',1/3/1989,'lanlt@yahoo.com','0901215116','AV2'),
('AV0807011', N'Đinh Phụng Long',19/3/1992,'longphung@yahoo.com','0203115116','AV1'),
('AV0807012', N'Nguyễn Tuấn Nam',1/10/1991,'namhai@yahoo.com','0904415116','AV1')

insert into Subjects 
values('S001', 'SQL'),
('S002' ,'Java Simplefield'),
('S003' ,'Active Server Pag')

insert into Mark
values('AV0807005', 'S001', 8, 25, '6/5/2008'),
('AV0807006', 'S002', 16, 30, '6/5/2008'),
('AV0807007', 'S001', 10, 25, '6/5/2008'),
('AV0807009' ,'S003' ,7 ,13 ,'6/5/2008'),
('AV0807010', 'S003', 9, 16,'6/5/2008'),
('AV0807011', 'S002' ,8 ,30, '6/5/2008'),
('AV0807012', 'S001', 7, 31, '6/5/2008'),
('AV0807005', 'S002' ,12 ,11 ,'6/6/2008'),
('AV0807010', 'S001' ,7 ,6, '6/6/2008')
go

select * from Student
select * from Subjects
select * from Mark