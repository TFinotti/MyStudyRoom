
--**************************CREATE ALL TABLES******************************

CREATE TABLE USERIDS
(
CENTENNIAL_ID NUMBER(9) CONSTRAINT USRID_CENTID_PK PRIMARY KEY,
FIRSTNAME VARCHAR2(20) CONSTRAINT USRID_FN_NN NOT NULL,
LASTNAME VARCHAR2(20) CONSTRAINT USRID_LN_NN NOT NULL,
EMAIL VARCHAR2(40) CONSTRAINT USRID_EMAIL_UNQ UNIQUE 
    CONSTRAINT USRID_EMAIL_NN NOT NULL,
PASSWORD VARCHAR2(15) CONSTRAINT USRID_PWD_NN NOT NULL,
USERTYPE VARCHAR2(9) CONSTRAINT USRID_USRTP_CK CHECK (USERTYPE IN ('STUDENT','FACULTY','LIBRARIAN'))
    CONSTRAINT USRID_UTYPE_NN NOT NULL
);

CREATE TABLE CAMPI
(
CAMPUS_ID VARCHAR2(5) CONSTRAINT CMP_CMPID_PK PRIMARY KEY,
CAMPUSNAME VARCHAR2(60) CONSTRAINT CMP_CMPN_NN NOT NULL
    CONSTRAINT CMP_CMPN_UNQ UNIQUE,
STREETNUMBER NUMBER(5),
STREETNAME VARCHAR2(50),
ZIPCODE VARCHAR2(7),
CITY VARCHAR2 (12)
);

CREATE TABLE ROOMTYPES
(
ROOMTYPE_ID NUMBER(4) CONSTRAINT RMTPS_ROOMTPID_PK PRIMARY KEY,
HASMULTIMEDIA VARCHAR(1) CONSTRAINT RMTPS_HMLTM_CK CHECK (HASMULTIMEDIA IN ('Y','N'))
    CONSTRAINT HMULT_NN NOT NULL,
NUMSEATS NUMBER(3) CONSTRAINT RMTPS_NUMST_NN NOT NULL
);

CREATE TABLE ROOMS
(
ROOM_ID VARCHAR2(5) CONSTRAINT RMS_ROOMID_PK PRIMARY KEY
    CONSTRAINT RMS_ROOMID_CK CHECK (ROOM_ID LIKE '__-__'),
CAMPUS_ID VARCHAR2(5) CONSTRAINT RMS_CMPID_NN NOT NULL
    CONSTRAINT CAMPI_ROOMS_CMPID_FK REFERENCES CAMPI (CAMPUS_ID),
ROOMTYPE_ID NUMBER(4) CONSTRAINT RMS_ROOMTP_NN NOT NULL
    CONSTRAINT ROOMTYPES_ROOMS_ROOMTP_FK REFERENCES ROOMTYPES (ROOMTYPE_ID)
);

CREATE TABLE RESERVATIONS
(
RESERVATION_ID NUMBER(10) CONSTRAINT RSVTS_RESERVID_PK PRIMARY KEY,
CENTENNIAL_ID NUMBER(9) CONSTRAINT RSVTS_CENTID_NN NOT NULL
    CONSTRAINT USERIDS_RESERV_CENTID_FK REFERENCES USERIDS (CENTENNIAL_ID),
ROOM_ID VARCHAR2(5) CONSTRAINT RSVTS_ROOMID_NN NOT NULL
    CONSTRAINT ROOMS_RESERV_ROOMID_FK REFERENCES ROOMS (ROOM_ID),
RESERVATIONSTATUS VARCHAR(1) CHECK (RESERVATIONSTATUS IN ('Y','N'))
    CONSTRAINT RSVTS_RSVSST_NN NOT NULL,
RESERVATIONDATE DATE CONSTRAINT RSVTS_RSVTSDT_NN NOT NULL
);

CREATE TABLE NOTIFICATIONS
(
NOTIFICATION_ID NUMBER(11) CONSTRAINT NTFC_NOTIFID_PK PRIMARY KEY,
CENTENNIAL_ID NUMBER(9) CONSTRAINT NTFC_CENTID_NN NOT NULL
    CONSTRAINT USERIDS_NOTIF_CENTID_FK REFERENCES USERIDS (CENTENNIAL_ID),
RESERVATION_ID NUMBER(10) CONSTRAINT NTFC_RSVID_NN NOT NULL
    CONSTRAINT RESERV_NOTIF_RESERVID_FK REFERENCES RESERVATIONS (RESERVATION_ID)
);

CREATE TABLE WAITLISTS
(
WAITLIST_ID NUMBER(11) CONSTRAINT WTL_WTLID_PK PRIMARY KEY,
CENTENNIAL_ID NUMBER(9) CONSTRAINT WTL_CENTID_NN NOT NULL
    CONSTRAINT USERIDS_WAITL_CENTID_FK REFERENCES USERIDS (CENTENNIAL_ID),
ROOMTYPE_ID NUMBER(4) CONSTRAINT WTL_ROOMTP_NN NOT NULL
    CONSTRAINT ROOMTYPES_WAITL_ROOMTP_FK REFERENCES ROOMTYPES (ROOMTYPE_ID),
REQUESTDATE DATE CONSTRAINT WTL_REQDT_NN NOT NULL
);

--*********POPULATE ALL TABLES********************************

INSERT ALL
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (301948275, 'Joe', 'Doe', 'jdoe@my.centennialcollege.ca', 'JdfT63375', 'STUDENT')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (301948276, 'John', 'Carrol', 'jcarrol@my.centennialcollege.ca', 'Jdfh6675', 'STUDENT')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (301948277, 'Dave', 'Fraser', 'dfraser@my.centennialcollege.ca', 'Jddff5655', 'STUDENT')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (301948278, 'Camille', 'Letendre', 'cletendre@my.centennialcollege.ca', 'Jfs9T63375', 'STUDENT')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (301948279, 'Sara', 'Briggs', 'sbriggs@my.centennialcollege.ca', 'JdfTfgh975', 'STUDENT')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (302948275, 'Pat', 'Fikowski', 'pfikowski@my.centennialcollege.ca', 'Jdfasas7375', 'FACULTY')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (302948276, 'Emily', 'Dantas', 'edantas@my.centennialcollege.ca', 'JdfT6vbnf', 'FACULTY')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (302948277, 'Katrina', 'Horvath', 'khorvath@my.centennialcollege.ca', 'Jdf3rTrt55', 'FACULTY')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (303948275, 'Kessy', 'Torns', 'ktorns@my.centennialcollege.ca', 'Jefsd45565', 'LIBRARIAN')
 INTO USERIDS (centennial_id, firstname, lastname, email, password, usertype) VALUES (303948276, 'Lerry', 'Douglas', 'jdouglas@my.centennialcollege.ca', 'JdfT6dfsdD6', 'LIBRARIAN')
SELECT * FROM DUAL;

INSERT ALL
 INTO CAMPI (campus_id, campusname,streetnumber, streetname, zipcode, city) VALUES ('PRG02', 'Progress', 941, 'Progress Ave', 'M1T 3T8', 'Scarborough')
 INTO CAMPI (campus_id, campusname,streetnumber, zipcode, city) VALUES ('EGL01', 'Eglinton', 124, 'M4R 2G8', 'Toronto')
 INTO CAMPI (campus_id, campusname) VALUES ('MSD01', 'Morningside')
SELECT * FROM DUAL;

INSERT ALL
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (0041, 'Y', 004)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (0061, 'Y', 006)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (0121, 'Y', 012)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (0501, 'Y', 050)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (2381, 'Y', 238)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (0040, 'N', 004)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (0060, 'N', 006)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (0120, 'N', 012)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (0500, 'N', 050)
 INTO ROOMTYPES (roomtype_id, hasmultimedia, numseats) VALUES (2380, 'N', 238)
SELECT * FROM DUAL;

INSERT ALL
 INTO ROOMS (room_id, campus_id, roomtype_id) VALUES ('L2-34', 'PRG02', 0041)
 INTO ROOMS (room_id, campus_id, roomtype_id) VALUES ('L1-33', 'PRG02', 0060)
 INTO ROOMS (room_id, campus_id, roomtype_id) VALUES ('A1-50', 'PRG02', 2381)
 INTO ROOMS (room_id, campus_id, roomtype_id) VALUES ('C3-14', 'EGL01', 0060)
 INTO ROOMS (room_id, campus_id, roomtype_id) VALUES ('M1-01', 'MSD01', 2380)
 INTO ROOMS (room_id, campus_id, roomtype_id) VALUES ('K2-30', 'MSD01', 0121)
SELECT * FROM DUAL;

INSERT ALL
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080001, 301948275, 'L2-34', 'Y', (TO_DATE('2019/08/20 13:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080002, 301948275, 'L1-33', 'Y', (TO_DATE('2019/08/20 14:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080003, 301948275, 'K2-30', 'N', (TO_DATE('2019/08/31 10:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080004, 303948275, 'C3-14', 'Y', (TO_DATE('2019/08/15 09:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080005, 303948275, 'C3-14', 'Y', (TO_DATE('2019/08/15 10:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080006, 303948275, 'C3-14', 'Y', (TO_DATE('2019/08/15 11:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080007, 302948276, 'A1-50', 'Y', (TO_DATE('2019/08/30 09:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080008, 302948276, 'C3-14', 'Y', (TO_DATE('2019/08/30 12:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080009, 302948276, 'M1-01', 'Y', (TO_DATE('2019/08/30 15:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080010, 301948279, 'L1-33', 'Y', (TO_DATE('2019/08/16 10:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080011, 301948277, 'L1-33', 'Y', (TO_DATE('2019/08/16 11:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080012, 301948276, 'L1-33', 'Y', (TO_DATE('2019/08/16 12:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080013, 301948278, 'L1-33', 'Y', (TO_DATE('2019/08/16 13:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080014, 301948279, 'L1-33', 'Y', (TO_DATE('2019/08/16 14:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080015, 301948279, 'L1-33', 'Y', (TO_DATE('2019/08/16 15:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080016, 303948276, 'K2-30', 'Y', (TO_DATE('2019/08/15 13:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080017, 303948276, 'K2-30', 'Y', (TO_DATE('2019/08/15 14:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080018, 301948276, 'L1-33', 'Y', (TO_DATE('2019/08/15 12:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080019, 301948278, 'L1-33', 'Y', (TO_DATE('2019/08/15 13:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080020, 301948275, 'L1-33', 'N', (TO_DATE('2019/08/15 14:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080021, 301948277, 'L2-34', 'Y', (TO_DATE('2019/08/16 15:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080022, 303948276, 'L2-34', 'Y', (TO_DATE('2019/08/16 13:00', 'yyyy/mm/dd hh24:mi')))
 INTO RESERVATIONS (RESERVATION_ID, CENTENNIAL_ID, ROOM_ID, RESERVATIONSTATUS, RESERVATIONDATE)
 VALUES (2019080023, 303948275, 'L2-34', 'Y', (TO_DATE('2019/08/16 14:00', 'yyyy/mm/dd hh24:mi')))
SELECT * FROM DUAL;

INSERT ALL
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800001,2019080001, 301948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800002,2019080002, 301948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800003,2019080003, 301948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800004,2019080004, 303948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800005,2019080005, 303948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800006,2019080006, 303948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800007,2019080007, 302948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800008,2019080008, 302948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800009,2019080009, 302948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800010,2019080010, 301948279)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800011,2019080011, 301948277)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800012,2019080012, 301948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800013,2019080013, 301948278)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800014,2019080014, 301948279)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800015,2019080015, 301948279)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800016,2019080016, 303948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800017,2019080017, 303948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800018,2019080018, 301948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800019,2019080019, 301948278)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800020,2019080020, 301948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800021,2019080021, 301948277)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800022,2019080022, 303948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800023,2019080023, 303948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800024,2019080007, 302948277)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800025,2019080007, 303948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800026,2019080009, 302948277)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800027,2019080009, 303948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800028,2019080022, 301948275)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800029,2019080022, 301948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800030,2019080022, 301948277)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800031,2019080022, 301948279)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800032,2019080023, 301948279)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800033,2019080023, 301948277)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800034,2019080023, 301948276)
 INTO NOTIFICATIONS (NOTIFICATION_ID, RESERVATION_ID, CENTENNIAL_ID)
 VALUES (20190800035,2019080023, 301948278)
SELECT * FROM DUAL;

INSERT ALL
 INTO WAITLISTS (WAITLIST_ID, CENTENNIAL_ID, ROOMTYPE_ID, REQUESTDATE)
 VALUES (20190800001, 301948279, 0121, (TO_DATE('2019/08/15 13:00', 'yyyy/mm/dd hh24:mi')))
 INTO WAITLISTS (WAITLIST_ID, CENTENNIAL_ID, ROOMTYPE_ID, REQUESTDATE)
 VALUES (20190800002, 301948277, '0060', (TO_DATE('2019/08/15 12:00', 'yyyy/mm/dd hh24:mi')))
 INTO WAITLISTS (WAITLIST_ID, CENTENNIAL_ID, ROOMTYPE_ID, REQUESTDATE)
 VALUES (20190800003, 301948279, 0060, (TO_DATE('2019/08/16 11:00', 'yyyy/mm/dd hh24:mi')))
 INTO WAITLISTS (WAITLIST_ID, CENTENNIAL_ID, ROOMTYPE_ID, REQUESTDATE)
 VALUES (20190800004, 301948275, '0041', (TO_DATE('2019/08/16 15:00', 'yyyy/mm/dd hh24:mi')))
 INTO WAITLISTS (WAITLIST_ID, CENTENNIAL_ID, ROOMTYPE_ID, REQUESTDATE)
 VALUES (20190800005, 301948278, '0041', (TO_DATE('2019/08/16 15:00', 'yyyy/mm/dd hh24:mi')))
SELECT * FROM DUAL;

--****************COMMIT CHANGES TO THE DATABASE*******************

COMMIT;