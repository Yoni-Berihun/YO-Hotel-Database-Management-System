-- ================================
-- Hotel Management Database
-- ================================

CREATE DATABASE Hotel_Management;
USE Hotel_Management;

-- ================================
-- Hotel Table
-- ================================
CREATE TABLE Hotel (
    Hotel_ID VARCHAR(10) PRIMARY KEY,
    Branch_name VARCHAR(50),
    Location VARCHAR(100),
    Phone_number VARCHAR(20)
);

-- ================================
-- Room Table
-- ================================
CREATE TABLE Room (
    Room_ID VARCHAR(10) PRIMARY KEY,
    Hotel_ID VARCHAR(10),
    Room_type VARCHAR(50),
    Price DECIMAL(10,2),
    Availability BOOLEAN,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);

-- ================================
-- Room Feature Table
-- ================================
CREATE TABLE Room_Feature (
    Feature_ID VARCHAR(10) PRIMARY KEY,
    Feature_name VARCHAR(50)
);

-- ================================
-- Room-Feature Mapping
-- ================================
CREATE TABLE Room_Room_Feature (
    Room_ID VARCHAR(10),
    Feature_ID VARCHAR(10),
    PRIMARY KEY (Room_ID, Feature_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID),
    FOREIGN KEY (Feature_ID) REFERENCES Room_Feature(Feature_ID)
);

-- ================================
-- Guest Table
-- ================================
CREATE TABLE Guest (
    Guest_ID VARCHAR(10) PRIMARY KEY,
    Guest_name VARCHAR(50),
    Guest_address VARCHAR(100),
    Guest_phone_number VARCHAR(20) UNIQUE,
    Guest_email VARCHAR(50) UNIQUE
);

-- ================================
-- Payment Table
-- ================================
CREATE TABLE Payment (
    Payment_ID VARCHAR(10) PRIMARY KEY,
    Amount DECIMAL(10,2),
    Payment_method VARCHAR(20),
    Payment_status VARCHAR(20)
);

-- ================================
-- Reservation Table
-- ================================
CREATE TABLE Reservation (
    Reservation_ID VARCHAR(10) PRIMARY KEY,
    Total_cost DECIMAL(10,2),
    Number_of_guests INT,
    Check_in_date DATE,
    Check_out_date DATE,
    Guest_ID VARCHAR(10),
    Hotel_ID VARCHAR(10),
    Room_ID VARCHAR(10),
    Payment_ID VARCHAR(10),
    FOREIGN KEY (Guest_ID) REFERENCES Guest(Guest_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    CHECK (Total_cost >= 0),
    CHECK (Number_of_guests > 0),
    CHECK (Check_out_date > Check_in_date)
);

-- ================================
-- Staff Table
-- ================================
CREATE TABLE Staff (
    Staff_ID VARCHAR(10) PRIMARY KEY,
    Staff_name VARCHAR(50),
    Job_title VARCHAR(50),
    Salary DECIMAL(10,2),
    Hotel_ID VARCHAR(10),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
    CHECK (Salary >= 0)
);

-- ================================
-- Staff Contact Table (NEW)
-- ================================
CREATE TABLE Staff_Contact (
    Staff_ID VARCHAR(10),
    Phone_number VARCHAR(20),
    PRIMARY KEY (Staff_ID, Phone_number),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);

-- ================================
-- Services Table
-- ================================
CREATE TABLE Services (
    Service_ID VARCHAR(10) PRIMARY KEY,
    Service_name VARCHAR(50),
    Service_description VARCHAR(100),
    Price DECIMAL(10,2)
);

-- ================================
-- Reservation-Service Mapping
-- ================================
CREATE TABLE Reservation_Service (
    Reservation_ID VARCHAR(10),
    Service_ID VARCHAR(10),
    PRIMARY KEY (Reservation_ID, Service_ID),
    FOREIGN KEY (Reservation_ID) REFERENCES Reservation(Reservation_ID),
    FOREIGN KEY (Service_ID) REFERENCES Services(Service_ID)
);

-- ================================
-- Review Table
-- ================================
CREATE TABLE Review (
    Review_ID VARCHAR(10) PRIMARY KEY,
    Guest_ID VARCHAR(10),
    Hotel_ID VARCHAR(10),
    Rating INT CHECK (Rating BETWEEN 0 AND 5),
    Comments VARCHAR(200),
    FOREIGN KEY (Guest_ID) REFERENCES Guest(Guest_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID)
);

-- ================================
-- Room Service Availability
-- ================================
CREATE TABLE Room_Service_Availability (
    Room_ID VARCHAR(10),
    Hotel_ID VARCHAR(10),
    Service_ID VARCHAR(10),
    Availability_status VARCHAR(20),
    Date DATE,
    PRIMARY KEY (Room_ID, Hotel_ID, Service_ID, Date),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel(Hotel_ID),
    FOREIGN KEY (Service_ID) REFERENCES Services(Service_ID)
);

-- ================================
-- INSERT DATA
-- ================================

-- Hotel data
INSERT INTO Hotel VALUES 
('h.01', 'Addis Branch', 'Addis Ababa, Ethiopia', '+251922234455'),
('h.02', 'Hawassa Branch', 'Hawassa, Ethiopia', '+251934353637'),
('h.03', 'Adama Branch', 'Adama, Ethiopia', '+251911222333'),
('h.04', 'Bahir Dar Branch', 'Bahir Dar, Ethiopia', '+251922233344');

-- Room data
INSERT INTO Room VALUES 
('rm.01', 'h.01', 'Suite', 500.00, TRUE),
('rm.02', 'h.02', 'Deluxe', 350.00, TRUE),
('rm.03', 'h.03', 'Standard', 200.00, FALSE),
('rm.04', 'h.04', 'Suite', 600.00, TRUE);

-- Room Feature data
INSERT INTO Room_Feature VALUES 
('f.01', 'Wi-Fi'),
('f.02', 'TV'),
('f.03', 'Air Conditioning'),
('f.04', 'Mini Bar');

-- Room-Feature data
INSERT INTO Room_Room_Feature VALUES 
('rm.01', 'f.01'),
('rm.01', 'f.02'),
('rm.02', 'f.01'),
('rm.03', 'f.03'),
('rm.04', 'f.04');

-- Guest data
INSERT INTO Guest VALUES 
('g.01', 'Yonatan Berihun', 'Addis Ababa, Ethiopia', '0923456789', 'yoniberihun9@gmail.com'),
('g.02', 'Danel Asefa', 'Hawassa, Ethiopia', '0911111111', 'dani@gmail.com'),
('g.03', 'Melat Zewdu', 'Adama, Ethiopia', '0934343434', 'melat@gmail.com'),
('g.04', 'Samson Taye', 'Bahir Dar, Ethiopia', '0945454545', 'samson@gmail.com'),
('g.05', 'Lily Mekonnen', 'Mekelle, Ethiopia', '0956565656', 'lily@gmail.com'),
('g.06', 'Miki Tadesse', 'Dire Dawa, Ethiopia', '0967676767', 'miki@gmail.com'),
('g.07', 'Sara Bekele', 'Jimma, Ethiopia', '0978787878', 'sara@gmail.com'),
('g.08', 'Daniel Fekadu', 'Gondar, Ethiopia', '0989898989', 'daniel@gmail.com'),
('g.09', 'Hanna Girma', 'Shashamane, Ethiopia', '0990909090', 'hanna@gmail.com'),
('g.10', 'Bereket Hailu', 'Addis Ababa, Ethiopia', '0901010101', 'bereket@gmail.com'),
('g.11', 'Kalab Abera', 'Hawassa, Ethiopia', '0912121212', 'kal@gmail.com');

-- Payment data
INSERT INTO Payment VALUES 
('p.01', 1000.00, 'Cash', 'Authorized'),
('p.02', 500.00, 'Credit Card', 'Declined'),
('p.03', 2000.00, 'Mobile Money', 'Authorized'),
('p.04', 750.00, 'Cash', 'Authorized'),
('p.05', 3000.00, 'Credit Card', 'Authorized'),
('p.06', 1200.00, 'Mobile Money', 'Declined'),
('p.07', 1800.00, 'Cash', 'Authorized'),
('p.08', 900.00, 'Credit Card', 'Authorized'),
('p.09', 2200.00, 'Mobile Money', 'Authorized'),
('p.10', 1500.00, 'Cash', 'Authorized');

-- Reservation data
INSERT INTO Reservation VALUES 
('r.01', 1000.00, 2, '2023-09-01', '2023-09-05', 'g.01', 'h.01', 'rm.01', 'p.01'),
('r.02', 500.00, 1, '2023-08-15', '2023-08-18', 'g.02', 'h.02', 'rm.02', 'p.02'),
('r.03', 2000.00, 4, '2023-07-10', '2023-07-20', 'g.03', 'h.03', 'rm.03', 'p.03'),
('r.04', 750.00, 2, '2023-06-05', '2023-06-08', 'g.04', 'h.04', 'rm.04', 'p.04'),
('r.05', 3000.00, 3, '2023-05-12', '2023-05-20', 'g.05', 'h.01', 'rm.01', 'p.05'),
('r.06', 1200.00, 2, '2023-04-01', '2023-04-05', 'g.06', 'h.02', 'rm.02', 'p.06'),
('r.07', 1800.00, 3, '2023-03-15', '2023-03-22', 'g.07', 'h.03', 'rm.03', 'p.07'),
('r.08', 900.00, 1, '2023-02-10', '2023-02-14', 'g.08', 'h.04', 'rm.04', 'p.08'),
('r.09', 2200.00, 4, '2023-01-05', '2023-01-15', 'g.09', 'h.01', 'rm.01', 'p.09'),
('r.10', 1500.00, 2, '2022-12-01', '2022-12-07', 'g.10', 'h.02', 'rm.02', 'p.10');

-- Staff data (with proper names & roles)
INSERT INTO Staff VALUES 
('s.11', 'Abebe Kebede', 'General Manager', 10000.00, 'h.01'),
('s.22', 'Marta Alemu', 'Receptionist', 5000.00, 'h.02'),
('s.33', 'Getachew Tadesse', 'Housekeeping Supervisor', 4000.00, 'h.03'),
('s.44', 'Helen Fisseha', 'Restaurant Manager', 7000.00, 'h.04');

-- Staff contact data
INSERT INTO Staff_Contact VALUES 
('s.11', '0945654434'),
('s.11', '0930231011'),
('s.22', '0912334455'),
('s.33', '0922445566'),
('s.44', '0933556677');

-- Services data
INSERT INTO Services VALUES 
('srv.01', 'Room Cleaning', 'Daily housekeeping services', 50.00),
('srv.02', 'Spa', 'Relaxing spa treatments', 200.00),
('srv.03', 'Airport Shuttle', 'Transportation to/from airport', 100.00);

-- Reservation-Service data
INSERT INTO Reservation_Service VALUES 
('r.01', 'srv.01'),
('r.02', 'srv.02'),
('r.03', 'srv.03'),
('r.04', 'srv.01'),
('r.05', 'srv.02');

-- Review data
INSERT INTO Review VALUES 
('rev.01', 'g.01', 'h.01', 5, 'Excellent service!'),
('rev.02', 'g.02', 'h.02', 4, 'Very good, but room was small.'),
('rev.03', 'g.03', 'h.03', 3, 'Average experience.'),
('rev.04', 'g.04', 'h.04', 2, 'Not satisfied with cleanliness.');

-- Room Service Availability data
INSERT INTO Room_Service_Availability VALUES 
('rm.01', 'h.01', 'srv.01', 'Available', '2023-09-01'),
('rm.02', 'h.02', 'srv.02', 'Available', '2023-08-15'),
('rm.03', 'h.03', 'srv.03', 'Unavailable', '2023-07-10'),
('rm.04', 'h.04', 'srv.01', 'Available', '2023-06-05');
