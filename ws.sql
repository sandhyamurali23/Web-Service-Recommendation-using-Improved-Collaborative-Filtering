/*
UserInfo_full
*/
CREATE TABLE UserInfo_full
(
userid INTEGER,
ipaddress Text,
country Text,
ipno Text,
autonomoussystem Text,
latitude Text,
longitude Text,
PRIMARY key (userid)
);

COPY USERinfo_full FROM '/Users/CASH/NetBeansProjects/timeWSR_CF/dataset/dataset1/userlist.csv' WITH (FORMAT csv);

/*
webserviceinfo_full
*/
CREATE TABLE webserviceinfo_full(
serviceid INTEGER,
wsdladdress Text, 
serviceprovider Text,
ipaddress Text,
country Text,
ipno Text,
autonomoussystem Text,
latitude Text,
longitude Text,
PRIMARY key(serviceid)                  
);

COPY webserviceinfo_full FROM '/Users/CASH/NetBeansProjects/timeWSR_CF/dataset/dataset1/wslistp.txt'
 WITH (format csv, delimiter E'\t')

ALTER TABLE webserviceinfo_full
  ADD category Text;

/*SELECT wsdladdress, serviceprovider, country , category FROM webserviceinfo_full;
SELECT category, count(1) FROM webserviceinfo_full GROUP BY category*/


/*
userservicematrix_timeinvoked_full
*/
CREATE TABLE userservicematrix_timeinvoked_full
(
userid INTEGER,
serviceid INTEGER,
responsetime FLOAT(4),
PRIMARY key (userid, serviceid),
FOREIGN KEY (userid) REFERENCES userinfo_full(userid),
FOREIGN KEY (serviceid) REFERENCES webserviceinfo_full(serviceid)
);

COPY userservicematrix_timeinvoked_full FROM '/Users/CASH/NetBeansProjects/timeWSR_CF/dataset/dataset1/rtMatrix1.csv' WITH (FORMAT csv);


/*
userservicematrix_qos_full
*/
CREATE TABLE userservicematrix_qos_full
(
userid INTEGER,
serviceid INTEGER,
throughput FLOAT(4),
PRIMARY key (userid, serviceid),
FOREIGN KEY (userid) REFERENCES userinfo_full(userid),
FOREIGN KEY (serviceid) REFERENCES webserviceinfo_full(serviceid)
);

COPY userservicematrix_qos_full FROM '/Users/CASH/NetBeansProjects/timeWSR_CF/dataset/dataset1/tpMatrix1.csv' WITH (FORMAT csv);


SELECT A.userid, A.serviceid,A.responsetime  FROM userservicematrix_timeinvoked_full A, userinfo_full B, webserviceinfo_full C WHERE A.userid=B.userid AND C.serviceid= A.serviceid AND B.country='United States' AND C.category='entertainment';

SELECT A.userid, A.serviceid,A.throughput  FROM userservicematrix_qos_full A, userinfo_full B, webserviceinfo_full C WHERE A.userid=B.userid AND C.serviceid= A.serviceid AND B.country='United States' AND C.category='entertainment';

SELECT A.userid, A.serviceid,A.responsetime, D.throughput  FROM userservicematrix_timeinvoked_full A, userinfo_full B, webserviceinfo_full C, USERservicematrix_qos_full D WHERE A.userid=B.userid AND C.serviceid= A.serviceid AND D.userid=B.userid AND C.serviceid= D.serviceid AND B.country='United States' AND C.category='entertainment';

SELECT DISTINCT A.userid  FROM userservicematrix_timeinvoked_full A, userinfo_full B, webserviceinfo_full C, USERservicematrix_qos_full D WHERE A.userid=B.userid AND C.serviceid= A.serviceid AND D.userid=B.userid AND C.serviceid= D.serviceid AND B.country='United States' AND C.category='entertainment';



CREATE TABLE userservicematrix_timeinvoked_p
(
userid INTEGER,
serviceid INTEGER,
timesliceid INTEGER,
responsetime FLOAT(4),
PRIMARY key (userid, serviceid, timesliceid),
FOREIGN KEY (userid) REFERENCES userinfo_full(userid),
FOREIGN KEY (serviceid) REFERENCES webserviceinfo_full(serviceid)
);

COPY userservicematrix_timeinvoked_p FROM '/Users/CASH/NetBeansProjects/timeWSR_CF/dataset/dataset2/rtdata.txt'
 WITH (format csv, delimiter E'\t')
/*
userservicematrix_qos_full
*/
CREATE TABLE userservicematrix_qos_p
(
userid INTEGER,
serviceid INTEGER,
timesliceid INTEGER,
throughput FLOAT(4),
PRIMARY key (userid, serviceid, timesliceid),
FOREIGN KEY (userid) REFERENCES userinfo_full(userid),
FOREIGN KEY (serviceid) REFERENCES webserviceinfo_full(serviceid)
);

COPY userservicematrix_qos_p FROM '/Users/CASH/NetBeansProjects/timeWSR_CF/dataset/dataset2/tpdata.txt'
 WITH (format csv, delimiter E'\t')
