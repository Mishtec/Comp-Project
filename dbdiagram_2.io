// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

// Contriant: It has a fleet of a hundred trucks of all types,

Table Vehicle as V{
  Vehicle_ID INT [pk]
  Brand_Name VARCHAR(255)
  Hourly_Rate DECIMAL (5,2) [not null] //proportional fraction
  Kilometer_Rate DECIMAL (5,2) [not null] //proportianl fraction
  Vehicle_Type Vehicle_Type [not null]
}

Table Driver as D {
  Driver_ID INT [pk]
  First_Name VARCHAR(255) 
  Last_Name VARCHAR(255) 
  License_Type License_Type
}

Table Client as C  {
  Client_ID INT [pk]
  Client_Name VARCHAR(255)
  Address VARCHAR(255) 
  Client_Type Client_Type
}

Table Reservation as Res {
  Reservation_ID INT [pk] // pk can never be null
  Client_ID INT [ref: > C.Client_ID] // if referenced is pk, then won't be null, unless deleted
  Requested_Vehicle_Type Vehicle_Type [not null] 
  Location VARCHAR(255) [not null]
  Appointment_Date DATETIME [not null]// format YYYY-MM-DD hh:mm:ss
  Reservation_Length INT [note: "Expected_Duration > 1 year"]// time in minutes
  // Check Expected_Duration > 525600 // 1 year in minutes
  // The expected duration of making disposal of vehicle and driver.
  // Assume Expected_Duration = for both vehicle and driver
}

Table Mission as M{
  Mission_ID INT [pk]
  Vehicle_ID INT  [ref: < V.Vehicle_ID, not null]
  Driver_ID INT [ref: < D.Driver_ID, not null]
  Reservation_ID INT [ref: > Res.Reservation_ID, not null]
  Start_Mission DATETIME [not null]
  End_Mission DATETIME [not null]
  Actual_Start_Mission DATETIME
  Actual_End_Mission DATETIME
  Odometer_Start INT
  Odometer_Return INT
}

// Billing
Table Tax as T {
  Tax_ID INT [pk]
  Federal_tax DECIMAL(4, 2) [not null]
  Provincal_tax DECIMAL(4, 2) [not null]
}

Table Invoice as Invoi{
  Invoice_ID INT [pk]
  Tax_ID INT [ref: > T.Tax_ID]
  Payment_Type Payment_Type [not null]
  isPaid BOOLEAN [not null, default: "0"]
}

Table LineOrder as LO{
  Mission_ID INT [pk, ref: > M.Mission_ID]
  Invoice_ID INT [pk, ref: > Invoi.Invoice_ID]
}

// Enums 

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

enum Client_Type {
  Person
  Business
}

enum License_Type {
  1 // Heavy
  3 // Super Heavy
  5 // Tourist
}