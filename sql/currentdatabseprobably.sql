-- Adminer 5.0.6 PostgreSQL 17.4 (Debian 17.4-1.pgdg120+2) dump

DROP TABLE IF EXISTS "beds";
DROP SEQUENCE IF EXISTS beds_id_seq;
CREATE SEQUENCE beds_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."beds" (
    "id" integer DEFAULT nextval('beds_id_seq') NOT NULL,
    "bed_type" text NOT NULL,
    "aid" character varying(255),
    "capacity" integer NOT NULL,
    CONSTRAINT "beds_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "beds_bed_type_check" CHECK (bed_type = ANY (ARRAY['queen'::text, 'single'::text, 'bunk'::text, 'adjustable'::text]))
) WITH (oids = false);


DROP TABLE IF EXISTS "booker";
DROP SEQUENCE IF EXISTS booker_id_seq;
CREATE SEQUENCE booker_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."booker" (
    "id" integer DEFAULT nextval('booker_id_seq') NOT NULL,
    "first_name" character varying(50) NOT NULL,
    "last_name" character varying(50) NOT NULL,
    "email" character varying(100) NOT NULL,
    "phone" character varying(20) NOT NULL,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "booker_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE UNIQUE INDEX booker_email_key ON public.booker USING btree (email);

CREATE UNIQUE INDEX booker_phone_key ON public.booker USING btree (phone);


DROP TABLE IF EXISTS "booking_addons";
DROP SEQUENCE IF EXISTS booking_addons_id_seq;
CREATE SEQUENCE booking_addons_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."booking_addons" (
    "id" integer DEFAULT nextval('booking_addons_id_seq') NOT NULL,
    "booking_id" integer NOT NULL,
    "house_id" integer NOT NULL,
    "addon_type" text NOT NULL,
    "quantity" integer DEFAULT '1' NOT NULL,
    "price" numeric(10,2) NOT NULL,
    "start_time" timestamp,
    "end_time" timestamp,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "booking_addons_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "booking_addons_addon_type_check" CHECK (addon_type = ANY (ARRAY['towels'::text, 'kayak'::text, 'sauna'::text, 'breakfast'::text, 'lunch'::text, 'dinner'::text, 'fika'::text]))
) WITH (oids = false);


DROP TABLE IF EXISTS "bookings";
DROP SEQUENCE IF EXISTS bookings_id_seq;
CREATE SEQUENCE bookings_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."bookings" (
    "id" integer DEFAULT nextval('bookings_id_seq') NOT NULL,
    "booker_id" integer NOT NULL,
    "booking_date" date NOT NULL,
    "check_in_date" date NOT NULL,
    "check_out_date" date NOT NULL,
    "booking_type" text DEFAULT 'regular',
    "status" text DEFAULT 'pending',
    "total_price" numeric(10,2) NOT NULL,
    "paymentmethod" text NOT NULL,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "bookings_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "bookings_booking_type_check" CHECK (booking_type = ANY (ARRAY['regular'::text, 'wedding'::text])),
    CONSTRAINT "bookings_status_check" CHECK (status = ANY (ARRAY['pending'::text, 'reserved'::text, 'booked'::text])),
    CONSTRAINT "bookings_paymentmethod_check" CHECK (paymentmethod = ANY (ARRAY['faktura'::text, 'swish'::text, 'förskott'::text, 'kreditkort'::text, 'betalkort'::text, 'klarna'::text, 'stripe'::text]))
) WITH (oids = false);


DROP TABLE IF EXISTS "customer";
DROP SEQUENCE IF EXISTS customer_id_seq;
CREATE SEQUENCE customer_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."customer" (
    "id" integer DEFAULT nextval('customer_id_seq') NOT NULL,
    "booker_id" integer NOT NULL,
    "active" boolean DEFAULT true,
    "personnummer" character varying(20),
    "companyname" character varying(100),
    "orgnummer" character varying(20),
    "customertype" text NOT NULL,
    "street_address" character varying(255) NOT NULL,
    "post_address" character varying(255) NOT NULL,
    "faktureringsinfo" character varying(100),
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "customer_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "customer_customertype_check" CHECK (customertype = ANY (ARRAY['privatperson'::text, 'företag'::text, 'förening'::text, 'stiftelse'::text, 'organisation'::text]))
) WITH (oids = false);

CREATE UNIQUE INDEX customer_personnummer_key ON public.customer USING btree (personnummer);

CREATE UNIQUE INDEX customer_orgnummer_key ON public.customer USING btree (orgnummer);


DROP TABLE IF EXISTS "guests";
DROP SEQUENCE IF EXISTS guests_id_seq;
CREATE SEQUENCE guests_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."guests" (
    "id" integer DEFAULT nextval('guests_id_seq') NOT NULL,
    "personnummer" character varying(12) NOT NULL,
    "first_name" character varying(50) NOT NULL,
    "last_name" character varying(50) NOT NULL,
    "email" character varying(100),
    "phone" character varying(20),
    "street_address" character varying(100),
    "post_address" character varying(100),
    "spec_kost" text,
    "assistants" integer DEFAULT '0',
    "aid" text,
    "notes" text,
    "type_of_guest" character varying(50),
    "room_id" integer NOT NULL,
    "booker_id" integer NOT NULL,
    "addon_id" integer NOT NULL,
    CONSTRAINT "guests_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE UNIQUE INDEX guests_personnummer_key ON public.guests USING btree (personnummer);

CREATE UNIQUE INDEX guests_email_key ON public.guests USING btree (email);

INSERT INTO "guests" ("id", "personnummer", "first_name", "last_name", "email", "phone", "street_address", "post_address", "spec_kost", "assistants", "aid", "notes", "type_of_guest", "room_id", "booker_id", "addon_id") VALUES
(1,	'199001011234',	'Alice',	'Andersson',	'alice@example.com',	'0701234567',	'Storgatan 1',	'12345 Stockholm',	'Vegetarian',	1,	'Wheelchair',	'Prefers quiet rooms',	'VIP',	1,	2,	3),
(2,	'198506152345',	'Bob',	'Bergström',	'bob@example.com',	'0707654321',	'Lillgatan 3',	'54321 Göteborg',	NULL,	0,	NULL,	'Allergic to cats',	'Regular',	2,	1,	2),
(3,	'200012241111',	'Charlie',	'Carlsson',	'charlie@example.com',	'0734567890',	'Huvudvägen 5',	'67890 Malmö',	'Gluten-free',	2,	NULL,	NULL,	'Business',	3,	2,	1);

DROP TABLE IF EXISTS "house";
DROP SEQUENCE IF EXISTS house_id_seq;
CREATE SEQUENCE house_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."house" (
    "id" integer DEFAULT nextval('house_id_seq') NOT NULL,
    "booking_id" integer NOT NULL,
    "name" character varying(100) NOT NULL,
    "type" character varying(50) NOT NULL,
    "bed_configuration" character varying(100),
    "description" character varying(255),
    "aid" character varying(100),
    "check_in_date" date NOT NULL,
    "check_out_date" date NOT NULL,
    "capacity" integer NOT NULL,
    "price" numeric(10,2) NOT NULL,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "house_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "house_rooms";
DROP SEQUENCE IF EXISTS house_rooms_id_seq;
CREATE SEQUENCE house_rooms_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."house_rooms" (
    "id" integer DEFAULT nextval('house_rooms_id_seq') NOT NULL,
    "house_id" integer NOT NULL,
    "room_id" integer NOT NULL,
    CONSTRAINT "house_rooms_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "room";
DROP SEQUENCE IF EXISTS room_id_seq;
CREATE SEQUENCE room_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."room" (
    "id" integer DEFAULT nextval('room_id_seq') NOT NULL,
    "name" character varying(100) NOT NULL,
    "description" character varying(255),
    "size" integer,
    "aid" character varying(100),
    CONSTRAINT "room_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "room_beds";
DROP SEQUENCE IF EXISTS room_beds_id_seq;
CREATE SEQUENCE room_beds_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."room_beds" (
    "id" integer DEFAULT nextval('room_beds_id_seq') NOT NULL,
    "room_id" integer NOT NULL,
    "bed_id" integer NOT NULL,
    "quantity" integer DEFAULT '1' NOT NULL,
    CONSTRAINT "room_beds_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "staff";
DROP SEQUENCE IF EXISTS staff_id_seq;
CREATE SEQUENCE staff_id_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

CREATE TABLE "public"."staff" (
    "id" integer DEFAULT nextval('staff_id_seq') NOT NULL,
    "personnummer" character varying(20),
    "first_name" character varying(100) NOT NULL,
    "last_name" character varying(100) NOT NULL,
    "email" character varying(100) NOT NULL,
    "phone" character varying(20) NOT NULL,
    "created_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "staff_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

CREATE UNIQUE INDEX staff_personnummer_key ON public.staff USING btree (personnummer);

CREATE UNIQUE INDEX staff_email_key ON public.staff USING btree (email);


ALTER TABLE ONLY "public"."booking_addons" ADD CONSTRAINT "booking_addons_booking_id_fkey" FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."booking_addons" ADD CONSTRAINT "booking_addons_house_id_fkey" FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."bookings" ADD CONSTRAINT "bookings_booker_id_fkey" FOREIGN KEY (booker_id) REFERENCES booker(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."customer" ADD CONSTRAINT "customer_booker_id_fkey" FOREIGN KEY (booker_id) REFERENCES booker(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."guests" ADD CONSTRAINT "fk_addon" FOREIGN KEY (addon_id) REFERENCES booking_addons(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."guests" ADD CONSTRAINT "fk_booker" FOREIGN KEY (booker_id) REFERENCES booker(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."guests" ADD CONSTRAINT "fk_room" FOREIGN KEY (room_id) REFERENCES room(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."house" ADD CONSTRAINT "house_booking_id_fkey" FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."house_rooms" ADD CONSTRAINT "house_rooms_house_id_fkey" FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."house_rooms" ADD CONSTRAINT "house_rooms_room_id_fkey" FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE CASCADE NOT DEFERRABLE;

ALTER TABLE ONLY "public"."room_beds" ADD CONSTRAINT "room_beds_bed_id_fkey" FOREIGN KEY (bed_id) REFERENCES beds(id) ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."room_beds" ADD CONSTRAINT "room_beds_room_id_fkey" FOREIGN KEY (room_id) REFERENCES room(id) ON DELETE CASCADE NOT DEFERRABLE;

-- 2025-03-26 12:53:06 UTC