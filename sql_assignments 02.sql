Q2:From the following tables, write a query to get the histogram of specialties of the
unique physicians who have done the procedures but never did prescribe anything.

Patient treatment table:
Patient Id | Event Name | Physician ID
1 Radiation 1000
2 Chemotherapy 2000
1 Biopsy 1000
3 Immunosuppressants 2000
4 BTKI 3000
5 Radiation 4000
4 Chemotherapy 2000
1 Biopsy 5000
6 Chemotherapy 6000


Event category table:
Event Name | Category
Chemotherapy Procedure
Radiation Procedure
Immunosuppressants Prescription
BTKI Prescription
Biopsy Test

Physician Speciality Table:
Physician Id | specialty
1000 Radiologist
2000 Oncologist
3000 Hematologist
4000 Oncologist
5000 Pathologist
6000 Oncologist


-- create a table
CREATE TABLE Patient_treatment (
  Patient_Id INTEGER NOT NULL,
  event_name TEXT NOT NULL,
  physician_id INTEGER NOT NULL
);
-- insert some values
INSERT INTO Patient_treatment VALUES (1, 'Radiation', 1000);
INSERT INTO Patient_treatment VALUES (2, 'Chemotherapy', 2000);
INSERT INTO Patient_treatment VALUES (1, 'Biopsy', 1000);
INSERT INTO Patient_treatment VALUES (3, 'Immunosuppressants', 2000);
INSERT INTO Patient_treatment VALUES (4, 'BTKI', 3000);
INSERT INTO Patient_treatment VALUES (5, 'Radiation', 4000);
INSERT INTO Patient_treatment VALUES (4, 'Chemotherapy', 2000);
INSERT INTO Patient_treatment VALUES (1, 'Biopsy', 5000);
INSERT INTO Patient_treatment VALUES (6, 'Chemotherapy', 6000);

-- fetch some values
SELECT * FROM Patient_treatment;

CREATE TABLE Event_category (
   Event_Name TEXT, 
   Category TEXT NOT NULL,
   FOREIGN KEY(Event_Name) REFERENCES Patient_treatment(Event_Name)
   
);
INSERT INTO Event_category values('Chemotherapy','procedure');
INSERT INTO Event_category values('Radiation','procedure');
INSERT INTO Event_category values('Immunosuppressants','Presciption');
INSERT INTO Event_category values('BTKI','Presciption');
INSERT INTO Event_category values('Biopsy','Test');

SELECT * FROM Event_category;

CREATE TABLE Physician_Speciality(
   physician_id integer,
   specialty TEXT NOT NULL,
   FOREIGN KEY (Physician_Id) REFERENCES Patient_treatment(Physician_Id)

);

INSERT INTO Physician_Speciality VALUES(1000,'Radiologist');
INSERT INTO Physician_Speciality VALUES(2000,'Oncologist');
INSERT INTO Physician_Speciality VALUES(3000,'Hematologist');
INSERT INTO Physician_Speciality VALUES(4000,'Oncologist');
INSERT INTO Physician_Speciality VALUES(5000,'Pathologist');
INSERT INTO Physician_Speciality VALUES(6000,'Oncologist');



select specialty, count(*) specialty_count from  Physician_Speciality
where physician_id not in 
 (select physician_id from Patient_treatment where event_name in 
  (select event_name from Event_category where category='Prescription'))
and physician_id in
 (select physician_id from Patient_treatment  where event_name in 
  (select event_name from Event_category where category='procedure'))
group by specialty; 
