use master
go
create database ThucTap
on primary(
	name= 'ThucTap_dat',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai3\ThucTap.mdf',
	size= 10MB,
	maxsize= 100MB,
	filegrowth= 10MB
)
log on(
	name= 'ThucTap_log',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai3\ThucTap.ldf',
	size= 1MB,
	maxsize= 5MB,
	filegrowth= 20%
)
go
use ThucTap
go
create table Khoa(
	makhoa char(10) not null primary key,
	tenkhoa char(30) not null,
	dienthoai char(10)
)
create table GiangVien(
	magv int not null primary key,
	hotengv char(30) not null,
	luong decimal(5,2) not null,
	makhoa char(10) not null,
	constraint fk_GiangVien_Khoa foreign key(makhoa)
		references Khoa(makhoa)
)
create table SinhVien(
	masv int not null primary key,
	hotensv char(30) not null,
	makhoa char(10) not null,
	namsinh int, 
	quequan char(30),
	constraint fk_SinhVien_Khoa foreign key(makhoa)
		references Khoa(makhoa)
)
create table DeTai(
	madt char(10) not null primary key,
	tendt char(30) not null,
	kinhphi int,
	noithuctap char(30)
)
create table HuongDan(
	masv int not null primary key,
	madt char(10) not null,
	magv int not null,
	ketqua decimal(5,2),
	constraint 
)