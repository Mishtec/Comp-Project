// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

// Contriant: It has a fleet of a hundred trucks of all types,

Table Tax {
  tax_id INT [pK]
  federal_taxes DECIMAL (4,2) [not null]
  provincial_taxes DECIMAL (4,2)
}

Table Invoice {
  invoice_id INT [pk]
  tax_id INT [ref: > Tax.tax_id]
  payment_method VARCHAR(20)
  is_paid BOOLEAN [not null, default: 0]
}

Table LineOrder {
  Mission_ID INT [pK, ref: > Mission.mission_id]
  Invoice_ID INT [pK, ref: > Invoice.invoice_id]
}

Table Mission {
  mission_id INT [pk]
  vehicle_id INT  [ref: > Vehicle.vehicle_id]
  driver_id INT [ref: > Driver.driver_id]
  reservation_id INT [ref: > Reservation.reservation_id]
  expected_start DATETIME
  expected_end DATETIME
  actual_start DATETIME
  actual_end DATETIME
  odometer_start INT [not null]
  odometer_end INT [not null]
}

Table Vehicle {
  vehicle_id INT [pk]
  brand_name VARCHAR(50)
  vehicle_type VARCHAR(30)
  rental_hour_price DECIMAL (5, 2) [not null]
  kilometer_price DECIMAL (5, 2) [not null]
  // Odometer INT [not null]
}

Table Driver {
  driver_id INT [pk]
  driver_name VARCHAR(255) 
  driver_licence INT [not null]
}

Table Reservation {
  reservation_id INT [pk]
  client_id INT [ref: > C.Client_ID]
  requested_vehicle_type VARCHAR(30) [not null] 
  location VARCHAR(255) [not null]
  appointment_date DATETIME [not null]// format YYYY-MM-DD hh:mm:ss
  appointment_duration DATETIME [note: "Expected_Duration > 1 year"]// time in minutes
  // Check Expected_Duration > 525600 // 1 year in minutes
  // The expected duration of making disposal of vehicle and driver.
  // Assume Expected_Duration = for both vehicle and driver
}



Table Client as C  {
  Client_ID INT [pk]
  Address VARCHAR(255) 
}

Table Business as B{
  Business_ID INT UNIQUE [ ref: - C.Client_ID]
  Name VARCHAR(255)
}

Table Person as P{
  Person_ID INT [ref: - C.Client_ID]
  Name VARCHAR(255)
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