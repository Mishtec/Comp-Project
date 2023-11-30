// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

// Contriant: It has a fleet of a hundred trucks of all types,



Table LineOrder as LO{
  Mission_ID INT [pk, ref: > M.Mission_ID]
  Invoice_ID INT [pk, ref: > Invoi.Invoice_ID]
}

// Billing
Table Invoice as Invoi{
  Invoice_ID INT [pk]
  Tax_ID INT [ref: > T.Tax_ID]
  Payment Payment_Type [not null]
  isPaid BOOLEAN [not null, default: "0"]
}

Table Tax as T {
  Tax_ID INT [pk]
  Federal_tax DECIMAL(4, 2) [not null]
  Provincal_tax DECIMAL(4, 2) [not null]
}

Table Client as C  {
  Client_ID INT [pk]
  Address VARCHAR(255) 
}

Table Business as B{
  Business_ID INT  [pk, ref: - C.Client_ID]
  Name VARCHAR(255) UNIQUE
}

Table Person as P{
  Person_ID INT [pk, ref: - C.Client_ID]
  Name VARCHAR(255)
}

Table Reservation as Res {
  Reservation_ID INT [pk] // pk can never be null
  Client_ID INT [ref: > C.Client_ID] // if referenced is pk, then won't be null, unless deleted
  Vehicle_Type Vehicle_Type [not null] 
  Location VARCHAR(255) [not null]
  Appointment DATETIME [not null]// format YYYY-MM-DD hh:mm:ss
  Reservation_Length INT [note: "Expected_Duration > 1 year"]// time in minutes
  // Check Expected_Duration > 525600 // 1 year in minutes
  // The expected duration of making disposal of vehicle and driver.
  // Assume Expected_Duration = for both vehicle and driver
}

Table Vehicle as V{
  Vehicle_ID INT [pk]
  Odometer INT [not null]
  Hourly_rate DECIMAL (5,2) [not null] //proportional fraction
  Kilometer_rate DECIMAL (5,2) [not null] //proportianl fraction
  Vehicle_Type Vehicle_Type [not null]
}

Table Driver as D {
  Driver_ID INT [pk]
  Name VARCHAR(255) 
}

Table DriverLicence as DL {
  DriverLicence_ID VARCHAR(255) [pk]
  Driver_ID INT [ref: > D.Driver_ID]
  Licence_Type Vehicle_Type [not null]
}



Table Mission as M{
  Mission_ID INT [pk]
  Vehicle_ID INT  [ref: < V.Vehicle_ID]
  Driver_ID INT [ref: < D.Driver_ID]
  Reservation_ID INT [ref: > Res.Reservation_ID]
  Start_Mission DATETIME
  END_Mission DATETIME
  Actual_Start_Mission DATETIME [not null]
  Actual_END_Mission DATETIME [not null]
  Odometer_Start INT [not null]
  Odometer_Return INT [not null]

}




enum Payment_Type {
    Credit_Card
    Cash
    Check
}

enum Vehicle_Type {
  Heavyweight
  Tourist
  SuperHeavyweight
}
