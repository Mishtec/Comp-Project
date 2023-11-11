// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Table Reservation as Res {
  Reservation_ID INT [pk]
  Client_ID INT [ref: > C.Client_ID]
  Vehicle_ID INT [ref: < V.Vehicle_ID]
  Rendezvous VARCHAR(255)
  Appointment DATETIME // format YYYY-MM-DD hh:mm:ss
  Expected_Duration INT // time in minutes
}



Table Client as C  {
  Client_ID INT [pk]
  Name VARCHAR(255)
  Address VARCHAR(255)
}

Table Vehicle as V{
  Vehicle_ID INT [pk]
  Odometer INT [not null]
  Duration DECIMAL (1,2) //proportional fraction
  Browsed_Kilometers DECIMAL (1,2) //proportianl fraction
}

Table Mission as M{
  Mission_ID INT [pk]
  Client_ID INT [ref: > C.Client_ID]
  Start_Mission DATETIME
  END_Mission DATETIME
  Actual_Start_Mission DATETIME
  Actual_END_Mission DATETIME
  Odometer_Start INT [not null]
  Odometer_Return INT [not null]

}


// Billing
Table Invoice as Invoi{
  Invoice_ID INT [pk]
  Mission_ID INT [ref: < M.Mission_ID]
  Amount DECIMAL (10,2)
  Payment Payment_Type
}

enum Payment {
    Credit_Card
    Cash
    Check
}

