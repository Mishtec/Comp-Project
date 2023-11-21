CREATE TABLE `LineOrder` (
  `Line_ID` INT PRIMARY KEY,
  `Mission_ID` INT,
  `Invoice_ID` INT
);

CREATE TABLE `Invoice` (
  `Invoice_ID` INT PRIMARY KEY,
  `Amount` DECIMAL(10,2) NOT NULL,
  `Payment` ENUM ('Credit_Card', 'Cash', 'Check') NOT NULL,
  `Paid` Bool NOT NULL DEFAULT "0"
);

CREATE TABLE `Client` (
  `Client_ID` INT PRIMARY KEY,
  `Name` VARCHAR(255),
  `Address` VARCHAR(255)
);

CREATE TABLE `Business` (
  `Name` VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `Person` (
  `Name` VARCHAR(255) NOT NULL
);

CREATE TABLE `Reservation` (
  `Reservation_ID` INT PRIMARY KEY,
  `Client_ID` INT,
  `Vehicle_Type` ENUM ('Heavyweight', 'Tourist', 'SuperHeavyweight') NOT NULL,
  `Rendezvous` VARCHAR(255) NOT NULL,
  `Appointment` DATETIME NOT NULL,
  `Expected_Duration` INT COMMENT 'Expected_Duration > 1 year'
);

CREATE TABLE `Vehicle` (
  `Vehicle_ID` INT PRIMARY KEY,
  `Odometer` INT NOT NULL,
  `Duration` DECIMAL(1,2) NOT NULL,
  `Browsed_Kilometers` DECIMAL(1,2) NOT NULL,
  `Vehicle_Type` ENUM ('Heavyweight', 'Tourist', 'SuperHeavyweight') NOT NULL
);

CREATE TABLE `Driver` (
  `Driver_ID` INT PRIMARY KEY,
  `Name` VARCHAR(255)
);

CREATE TABLE `DriverLicence` (
  `DriverLicence_ID` VARCHAR(255) PRIMARY KEY,
  `Driver_ID` INT,
  `Licence_Type` ENUM ('Heavyweight', 'Tourist', 'SuperHeavyweight') NOT NULL
);

CREATE TABLE `Mission` (
  `Mission_ID` INT PRIMARY KEY,
  `Client_ID` INT,
  `Vehicle_ID` INT,
  `Driver_ID` INT,
  `Start_Mission` DATETIME,
  `END_Mission` DATETIME,
  `Actual_Start_Mission` DATETIME NOT NULL,
  `Actual_END_Mission` DATETIME NOT NULL,
  `Odometer_Start` INT NOT NULL,
  `Odometer_Return` INT NOT NULL
);

ALTER TABLE `LineOrder` ADD FOREIGN KEY (`Mission_ID`) REFERENCES `Mission` (`Mission_ID`);

ALTER TABLE `LineOrder` ADD FOREIGN KEY (`Invoice_ID`) REFERENCES `Invoice` (`Invoice_ID`);

ALTER TABLE `Client` ADD FOREIGN KEY (`Name`) REFERENCES `Business` (`Name`);

ALTER TABLE `Client` ADD FOREIGN KEY (`Name`) REFERENCES `Person` (`Name`);

ALTER TABLE `Reservation` ADD FOREIGN KEY (`Client_ID`) REFERENCES `Client` (`Client_ID`);

ALTER TABLE `DriverLicence` ADD FOREIGN KEY (`Driver_ID`) REFERENCES `Driver` (`Driver_ID`);

ALTER TABLE `Mission` ADD FOREIGN KEY (`Client_ID`) REFERENCES `Client` (`Client_ID`);

ALTER TABLE `Vehicle` ADD FOREIGN KEY (`Vehicle_ID`) REFERENCES `Mission` (`Vehicle_ID`);

ALTER TABLE `Driver` ADD FOREIGN KEY (`Driver_ID`) REFERENCES `Mission` (`Driver_ID`);
