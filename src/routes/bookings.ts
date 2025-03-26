import { Hono } from "hono";
import { sql } from "../database.js";
import type { IBookings } from "../types.js";

export const BookingRoutes = new Hono();

// * GET -> /bookings
BookingRoutes.get("/", async (context) => {
	try {
		const bookings = await sql<IBookings[]>`
      SELECT * FROM bookings;
      `;

		return context.json({ bookings: bookings }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
