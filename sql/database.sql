CREATE TABLE users (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    phone           VARCHAR(20) NOT NULL UNIQUE,
    street_address  VARCHAR(255) NOT NULL,
    post_address    VARCHAR(255) NOT NULL UNIQUE,
    organization    VARCHAR(100),
    cardnummer      VARCHAR(40) NOT NULL UNIQUE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE bookings (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    user_id           INT NOT NULL,
    booking_date      DATE NOT NULL,
    check_in_date     DATE NOT NULL,
    check_out_date    DATE NOT NULL,
    booking_type      VARCHAR(20) DEFAULT 'regular',
    booking_name      VARCHAR(200),
    status            VARCHAR(20) DEFAULT 'pending',
    amount_of_guests  INT,
    total_price       DECIMAL(10,2),
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE room_booking (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    booking_id        INT NOT NULL,
    name              VARCHAR(100) NOT NULL,
    person_name       VARCHAR(100) NOT NULL,
    type              VARCHAR(50) NOT NULL,
    bed_configuration VARCHAR(100),
    description       VARCHAR(255),
    aid               VARCHAR(100),
    check_in_date     DATE NOT NULL,
    check_out_date    DATE NOT NULL,
    capacity          INT,
    price             DECIMAL(10,2),
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
);

CREATE TABLE booking_addons (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    booking_id  INT NOT NULL,
    room_id     INT,
    addon_type  VARCHAR(50) NOT NULL,
    quantity    INT NOT NULL DEFAULT 1,
    price       DECIMAL(10,2) NOT NULL,
    start_time  DATETIME NULL,
    end_time    DATETIME NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES room_booking(id) ON DELETE SET NULL
);

CREATE TABLE guests (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    personnummer     VARCHAR(100) NOT NULL,
    first_name       VARCHAR(200) NOT NULL,
    last_name        VARCHAR(200) NOT NULL,
    email            VARCHAR(200) NOT NULL,
    phone            VARCHAR(200) NOT NULL,
    street_address   VARCHAR(200) NOT NULL,
    post_address     VARCHAR(200) NOT NULL,
    spec_kost        VARCHAR(200),
    assistants       INT,
    aid              VARCHAR(255),
    notes            VARCHAR(255),
    type_of_guest    VARCHAR(200),
    room_id          INT NOT NULL,
    user_id          INT NOT NULL,
    addon_id         INT NOT NULL,
    FOREIGN KEY (room_id) REFERENCES room_booking(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (addon_id) REFERENCES booking_addons(id) ON DELETE SET NULL
);
