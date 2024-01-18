select * from member;
delete from member where userId = "yoon";

create table member(
	userId varchar(30) not null,
	userPassword varchar(30) not null,
	userName varchar(20) not null,
	age int,
	phoneNo varchar(30),
	adressSi varchar(20),
	adressGu varchar(20),
	gender varchar(10),
	incomeQuintile varchar(10),
	timestamp datetime default current_timestamp
	accrRqisCn varchar(20),
	major varchar(20),
	employmentStatus varchar(20),
	splzRlmRqisCn varchar(30),
	primary key(userId)
);

create table wishList(
	bizId varchar(50) not null,
	userId varchar(30) not null,
	polyItcnCn varchar(500),
    polyBizSjnm varchar(50), 
    rqutPrdCn varchar(30),
    rqutUrla varchar(100),
    cnsgNmor varchar(50),
    ageInfo varchar(30),
    sporCn varchar(500),
    rqutProcCn varchar(500),
    jdgnPresCn varchar(500),
    empmSttsCn varchar(100),
    accrRqisCn varchar(100),
    majrRqisCn varchar(100),
    splzRlmRqisCn varchar(100),
    FOREIGN KEY (userId) REFERENCES member(userId),
    CONSTRAINT unique_bizId_per_user UNIQUE (userId, bizId)
);


/*사용자가 검색시 INSERT될 DB*/
create table t_popular_word(
	popw_word varchar(50), 
	popw_date DATETIME
);

/*사용자 화면에 보여줄 DB*/
create table t_user_popular_word(
	user_popw_word varchar(50), 
	user_popw_date DATETIME, 
	user_popw_order int
);

select * from wishList



SELECT polyBizSjnm, COUNT(*) AS count
FROM wishList
GROUP BY polyBizSjnm
ORDER BY count DESC
LIMIT 4;

SELECT polyBizSjnm
FROM (
    SELECT polyBizSjnm, COUNT(*) AS count
    FROM wishList
    GROUP BY polyBizSjnm
    ORDER BY count DESC
    LIMIT 4
) AS subquery;

select * from wishList
ALTER TABLE wishList ADD CONSTRAINT unique_bizId_per_user UNIQUE (userId, bizId);
delete from wishList
alter table member modify column rqutProcCn varchar500);
alter table member add timestamp datetime default current_timestamp; 
alter table member add email varchar(20) not null
alter table wishList add  srchPolyBizSecd varchar(30)
alter table member drop signUpDate;
alter table wishList drop srchPolyBizSecd
RENAME TABLE user TO member;

select userName from member where userId = "123";
select IFNULL(userId, 0) from member where userName="테스";

timestamp datetime default current_timestamp


select * from member where email="worjc@hs.ac.kr"
