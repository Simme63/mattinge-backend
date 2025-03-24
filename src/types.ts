export interface IBooker {
	id: number;
	firstName: string;
	lastName: string;
	email: string;
	phone: string;
	createdAt: Date;
	updatedAt: Date;
}

export interface ICustomer {
	id: number;
	booker_id: number;
	active: boolean;
	personnumer: string;
	companyname: string;
	customertype: string;
	orgnumber: string;
	street_adress: string;
	post_adress: string;
	faktureringsinfo: string;
	created_at: Date;
	updated_at: Date;
}

export interface IBookings {
	id: number;
	booker_id: number;
	booking_date: Date;
	check_in_date: Date;
	check_out_date: Date;
	booking_type: "regular" | "wedding";
	status: "pending" | "reserved" | "booked";
	totalPrice?: number;
	paymentmethod: "fakutra" | "swish" | "förskott" | "kreditkort" | "betalkort" | "klarna" | "stripe"
	createdAt: Date;
	updatedAt: Date;
}

export interface IBookingAddon {
	id: number;
	booking_id: number;
	house_id?: number;
	addon_type: string;
	quantity: number;
	price: number;
	start_time?: Date;
	end_time?: Date;
	createdAt: Date;
	updatedAt: Date;
}

export interface IGuest {
	id: number;
	personnummer: string;
	firstName: string;
	lastName: string;
	email: string;
	phone: string;
	streetAddress: string;
	postAddress: string;
	specKost?: string;
	assistants?: number;
	aid?: string;
	notes?: string;
	typeOfGuest?: string;
	roomId: number;
	userId: number;
	addonId: number;
}

export interface IHouse {
	id: number;
	booking_id: number;
	name: string;
	type: string;
	bed_configuration?: string;
	description?: string;
	aid?: string;
	check_in_date: Date;
	check_out_date: Date;
	capacity: number;
	price: number;
	created_at: Date;
	updated_at: Date;
}

export interface IStaff {
	id: number;
	personnumber: number;
	first_name: string;
	last_name: string;
	email: string;
	phone: string;
	created_at: Date;
	updated_at: Date;
}

export interface IRoom {
	id: number;
	name: string;
	description: string;
	size: number;
	aid: string;
}

export interface IHouse_Rooms {
	id: number;
	house_id: number;
	room_id: number;
}

export interface IBeds {
	id: number;
	bed_type: "queen" | "single" | "bunk" | "adjustable"
	aid: string;
	capacity: string
}

export interface IRoom_Beds {
	id: number;
	room_id: number;
	bed_id: number;
	quantity: number;
}