create database clinic;
use clinic;

create table patient (
patient_id int primary key,
name varchar (50) not null,
age int check (age > 0),
gender varchar(10),
phone varchar (15) unique
);
describe patient;

insert into patient values
(1 ,'ahmed' , 25 , 'male' , '0501111111'),
(2 , 'sara' , 30 , 'female' , '0502222222'),
(3 , 'khalid' , 40 , 'male' , '0503333333'),
(4 , 'nora' , 22 , 'female' , '0504444444'),
(5 , 'faisal' , 35 , 'male' , '0505555555');
select * from patient;

select name , age
from patient where age > 30;

select count(*) as total_patients
from patient;

select avg(age) as avg_age
from patient;

create table doctor(
doctor_id int primary key,
name varchar (50),
specialty varchar(50),
phone varchar (15) unique
);
describe doctor;

insert into doctor values
(1 ,'dr.ali' ,  'cardiology' , '0501111711'),
(2 , 'dr.salwa' ,  'dermatology' , '0502229222'),
(3 , 'dr.omar' , 'dentistry' , '0503363333'),
(4 , 'dr.rose' , 'neurology' , '0503444444'),
(5 , 'dr.mohammed' , 'orthopedics' , '0505555155');
select * from doctor;

create table appointment(
appointment_id int primary key,
appointment_date date not null,
appointment_time time not null,
status varchar(20) check (status in ('scheduled' , 'completed' , 'cancelled')),
patient_id int,
doctor_id int,
foreign key (patient_id) references
patient(patient_id),
foreign key (doctor_id) references
doctor(doctor_id)
); 
describe appointment;

insert into appointment values
(1 ,'2026-04-22' ,  '10:00' , 'scheduled' ,1 ,1),
(2 ,'2026-04-23' ,  '11:00' , 'completed' ,2 ,2),
(3 ,'2026-04-24' ,  '12:00' , 'cancelled' ,3 ,3),
(4 ,'2026-04-25' ,  '01:00' , 'scheduled' ,4 ,4),
(5 ,'2026-04-26' ,  '02:00' , 'completed' ,5 ,5);
select * from appointment;

select appointment.appointment_id , appointment.appointment_date ,
 patient.name as patient_name , 
 doctor.name as doctor_name
from appointment
join patient on appointment.patient_id = patient.patient_id
join doctor on appointment.doctor_id = doctor.doctor_id;

create table medical_record(
record_id int primary key,
diagnosis varchar(100) not null,
treatment varchar(100),
patient_id int,
doctor_id int,
foreign key (patient_id) references
patient(patient_id),
foreign key (doctor_id) references
doctor(doctor_id)
);
describe medical_record;

insert into medical_record values
(1 ,'flu' ,  'medication'  ,1 ,1),
(2 ,'skin allergy' ,  'cream'  ,2 ,2),
(3 ,'tooth decay' ,  'filling'  ,3 ,3),
(4 ,'headache' ,  'painkillers'  ,4 ,4),
(5 ,'fracture' ,  'surgery'  ,5 ,5);
select * from medical_record;
select name
from patient
where patient_id in (select patient_id from  medical_record);

create view clinic_report as
select appointment.appointment_date , appointment.appointment_time , appointment.status,
 patient.name as patient_name , 
 doctor.name as doctor_name
from appointment
join patient on appointment.patient_id = patient.patient_id
join doctor on appointment.doctor_id = doctor.doctor_id
where appointment.status = 'scheduled';

select * from  clinic_report;

show tables;

