use master
go 
create database qlibanhang
on primary(
	name= 'QLBH_dat',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai1\QLBH.mdf',
	size= 10MB,
	maxsize= 100MB,
	filegrowth= 10MB
)
log on(
	name= 'QLBH_log',
	filename= 'E:\SQL_Ki3\BaiTap_SQL\Bai1\QLBH.ldf',
	size= 1MB,
	maxsize= 5MB,
	filegrowth= 20%
)
go 
use qlibanhang
go
create table CongTy(
	MaCT nchar(10) not null primary key,
	TenCT nvarchar(20) not null,
	TrangThai nchar(10),
	ThanhPho nvarchar(20)
)
create table SanPham(
	MaSP nchar(10) not null primary key,
	TenSP nvarchar(20) not null,
	MauSac nchar(10) default N'ĐỎ',
	Gia money,
	SoLuongCo int,
	constraint unique_TenSP unique (TenSP)
)
create table CungUng(
	MaCT nchar(10) not null,
	MaSP nchar(10) not null,
	SoLuongBan int,
	constraint pk_CungUng primary key(MaCT,MaSP),
	constraint chk_SLB check (SoLuongBan > 0),
	constraint fk_CU_CT foreign key (MaCT)
		references CongTy(MaCT),
	constraint fk_CU_SP foreign key (MaSP)
		references SanPham(MaSP)
)