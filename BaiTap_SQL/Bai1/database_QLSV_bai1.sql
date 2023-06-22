use master
go 
create database QuanLiSinhVien
on primary(
	name= 'QLSV_dat',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai1\QLSV.mdf',
	size= 10MB,
	maxsize= 100MB,
	filegrowth= 10MB
)
log on(
	name= 'QLSV_log',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai1\QLSV.ldf',
	size= 1MB,
	maxsize= 5MB,
	filegrowth= 20%
)
go 
use QuanLiSinhVien
go
create table SV(
	MaSV nchar(10) not null primary key,
	TenSV nvarchar(20) not null,
	Que nvarchar(10) not null
)
create table MON(
	MaMH nchar(10) not null primary key,
	TenMH nvarchar(20) not null ,
	Sotc int default 3,
	constraint unique_TenMH unique (TenMH),
	constraint chk_Sotc check (Sotc>=2 and Sotc<=5)
)
create table KQ(
	MaSV nchar(10) not null,
	MaMH nchar(10) not null,
	Diem float,
	constraint pk_KQ primary key(MaSV, MaMH),
	constraint fk_KQ_SV foreign key(MaSV)
		references SV(MaSV),
	constraint fk_KQ_MON foreign key(MaMH)
		references MON(MaMH),
	constraint chk_Diem check (Diem>=0 and Diem<=10)
)
go 
insert into SV (MaSV, TenSV, Que)
	values 
	('2021604735', N'Nguyễn Hải Nam', N'Thái Bình'),
	('2021673943', N'Phạm Minh Đức', N'Quảng Ninh'),
	('2021634283', N'Phạm Duy Chiến', N'Thái Bình')
go
insert into MON(MaMH, TenMH)
	values
	('N6004', N'Cơ sở dữ liệu'),
	('N6005', N'Toán rời rạc'),
	('N6006', N'Lịch sử Đảng')
go
insert into KQ(MaSV, MaMH, Diem)
	values 
	('2021604735', 'N6004', 8),
	('2021604735', 'N6006', 9),
	('2021634283', 'N6006', 3),
	('2021673943', 'N6005', 4),
	('2021634283', 'N6005', 2),
	('2021604735', 'N6005', 10)
go
update KQ
set Diem=0
where MaSV='2021604735' and MaMH='N6006';
go
SELECT *FROM 
QuanLiSinhVien.INFORMATION_SCHEMA.TABLES;
go