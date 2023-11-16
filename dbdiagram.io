// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Table Reservation as Res {
  Reservation_ID INT [pk] // pk can never be null
  Client_ID INT [ref: > C.Client_ID, not null]
  Vehicle_ID INT [ref: < V.Vehicle_ID, not null]
  Rendezvous VARCHAR(255) [not null]
  Appointment DATETIME [not null]// format YYYY-MM-DD hh:mm:ss
  Expected_Duration INT [note: "Expected_Duration > 1 year"]// time in minutes
  // Check Expected_Duration > 525600 // 1 year in minutes
}



Table Client as C  {
  Client_ID INT [pk]
  Name VARCHAR(255) 
  Address VARCHAR(255) 
}

Table Vehicle as V{
  Vehicle_ID INT [pk]
  Odometer INT [not null]
  Duration DECIMAL (1,2) [not null] //proportional fraction
  Browsed_Kilometers DECIMAL (1,2) [not null] //proportianl fraction
}

Table Mission as M{
  Mission_ID INT [pk]
  Client_ID INT [ref: > C.Client_ID, not null]
  Start_Mission DATETIME
  END_Mission DATETIME
  Actual_Start_Mission DATETIME [not null]
  Actual_END_Mission DATETIME [not null]
  Odometer_Start INT [not null]
  Odometer_Return INT [not null]

}


// Billing
Table Invoice as Invoi{
  Invoice_ID INT [pk]
  Mission_ID INT [ref: < M.Mission_ID, not null]
  Amount DECIMAL (10,2) [not null]
  Payment Payment_Type [not null]
}

enum Payment_Type {
    Credit_Card
    Cash
    Check
}

