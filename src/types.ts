export interface IUser {
	id: number;
	firstName: string;
	lastName: string;
	email: string;
	phone: string;
	streetAddress: string;
	postAddress: string;
	organization?: string;
	cardnummer: string;
	createdAt: Date;
	updatedAt: Date;
}

export interface IBooking {
	id: number;
	userId: number;
	bookingDate: Date;
	checkInDate: Date;
	checkOutDate: Date;
	bookingType: "regular" | "wedding";
	bookingName?: string;
	status: "pending" | "reserved" | "booked";
	amountOfGuests?: number;
	totalPrice?: number;
	createdAt: Date;
	updatedAt: Date;
}

export interface IRoomBooking {
	id: number;
	bookingId: number;
	name: string;
	personName: string;
	type: string;
	bedConfiguration?: string;
	description?: string;
	aid?: string;
	checkInDate: Date;
	checkOutDate: Date;
	capacity?: number;
	price?: number;
	createdAt: Date;
	updatedAt: Date;
}

export interface IBookingAddon {
	id: number;
	bookingId: number;
	roomId?: number;
	addonType: string;
	quantity: number;
	price: number;
	startTime?: Date;
	endTime?: Date;
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
