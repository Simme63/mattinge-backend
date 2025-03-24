CREATE TABLE booker (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE customer (
  id INT PRIMARY KEY AUTO_INCREMENT,
  booker_id INT NOT NULL,
  active BOOLEAN DEFAULT TRUE,
  personnummer VARCHAR(20) UNIQUE COMMENT 'Unique identifier for individuals in Sweden',
  companyname VARCHAR(100) COMMENT 'Only applies if customer is a business',
  orgnummer VARCHAR(20) UNIQUE COMMENT 'Company registration number',
  customertype ENUM('privatperson', 'företag', 'förening', 'stiftelse', 'organisation') NOT NULL,
  street_address VARCHAR(255) NOT NULL,
  post_address VARCHAR(255) NOT NULL,
  faktureringsinfo VARCHAR(100) COMMENT 'Billing information',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (booker_id) REFERENCES booker(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
  id INT PRIMARY KEY AUTO_INCREMENT,
  booker_id INT NOT NULL,
  booking_date DATE NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  booking_type ENUM('regular', 'wedding') DEFAULT 'regular',
  status ENUM('pending', 'reserved', 'booked') DEFAULT 'pending',
  total_price DECIMAL(10,2) NOT NULL,
  paymentmethod ENUM('faktura', 'swish', 'förskott', 'kreditkort', 'betalkort', 'klarna', 'stripe') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (booker_id) REFERENCES booker(id) ON DELETE CASCADE
);

CREATE TABLE house (
  id INT PRIMARY KEY AUTO_INCREMENT,
  booking_id INT NOT NULL,
  name VARCHAR(100) NOT NULL COMMENT 'Name of the house',
  type VARCHAR(50) NOT NULL COMMENT 'Type of house',
  bed_configuration VARCHAR(100) COMMENT 'Description of bed setup',
  description VARCHAR(255),
  aid VARCHAR(100) COMMENT 'Accessibility ID',
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  capacity INT NOT NULL COMMENT 'Maximum number of people allowed',
  price DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

CREATE TABLE guests (
  id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  first_name VARCHAR(200) NOT NULL,
  last_name VARCHAR(200) NOT NULL,
  email VARCHAR(200) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  street_address VARCHAR(200) NOT NULL,
  post_address VARCHAR(200) NOT NULL,
  personnummer VARCHAR(100) UNIQUE COMMENT 'Personal identification number',
  spec_kost VARCHAR(200) COMMENT 'Special dietary requirements',
  req_aid VARCHAR(200) COMMENT 'Required Aid',
  staff_id INT,
  room_id INT,
  notes VARCHAR(255) COMMENT 'Custom user-defined notes',
  type_of_guest ENUM('deltagare', 'vip', 'volontär') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE,
  FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE SET NULL,
  FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE SET NULL
);

CREATE TABLE booking_addons (
  id INT PRIMARY KEY AUTO_INCREMENT,
  booking_id INT NOT NULL,
  house_id INT NOT NULL,
  addon_type ENUM('towels', 'kayak', 'sauna', 'breakfast', 'lunch', 'dinner', 'fika') NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  price DECIMAL(10,2) NOT NULL,
  start_time DATETIME,
  end_time DATETIME,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE
);

CREATE TABLE staff (
  id INT PRIMARY KEY AUTO_INCREMENT,
  personnummer VARCHAR(20) UNIQUE COMMENT 'Unique identifier for staff',
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE room (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL COMMENT 'Room name, e.g., Kitchen, Dining Room, Bedroom',
  description VARCHAR(255),
  size INT COMMENT 'Capacity of the room',
  aid VARCHAR(100) COMMENT 'Accessibility ID'
);

CREATE TABLE house_rooms (
  id INT PRIMARY KEY AUTO_INCREMENT,
  house_id INT NOT NULL,
  room_id INT NOT NULL,
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE,
  FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE CASCADE
);

CREATE TABLE beds (
  id INT PRIMARY KEY AUTO_INCREMENT,
  bed_type ENUM('queen', 'single', 'bunk', 'adjustable') NOT NULL,
  aid VARCHAR(255),
  capacity INT NOT NULL COMMENT 'Number of people that can sleep in this bed'
);

CREATE TABLE room_beds (
  id INT PRIMARY KEY AUTO_INCREMENT,
  room_id INT NOT NULL,
  bed_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1 COMMENT 'Number of this bed type in the room',
  FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE CASCADE,
  FOREIGN KEY (bed_id) REFERENCES beds(id) ON DELETE CASCADE
);
