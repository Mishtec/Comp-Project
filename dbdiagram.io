// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Table Reservation as Res {
  Reservation_ID INT [pk]
  Client_ID INT [ref: < C.Client_ID]
  Vehicle_ID INT [ref: - V.Vehicle_ID]
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
}
