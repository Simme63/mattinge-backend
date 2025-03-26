import { Hono } from "hono";
import { sql } from "../database.js";
import type { IBookingAddon } from "../types.js";

export const BookingAddonRoutes = new Hono();

// * GET -> /booking_addons/:id
BookingAddonRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const bookingAddon = await sql<IBookingAddon[]>`
            SELECT * FROM booking_addons WHERE id = ${id};
        `;

		if (bookingAddon.length === 0) {
			return context.json({ message: "Booking Addon not found" }, 404);
		}

		return context.json(
			{
				message: "Booking Addon Found Successfully",
				bookingAddon: bookingAddon[0],
			},
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /booking_addons
BookingAddonRoutes.get("/", async (context) => {
	try {
		const bookingAddons = await sql<IBookingAddon[]>`
            SELECT * FROM booking_addons;
        `;

		return context.json({ bookingAddons }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// > POST -> /booking_addons
BookingAddonRoutes.post("/", async (context) => {
	try {
		const newBookingAddon = await context.req.json<IBookingAddon>();
		const insertedBookingAddon = await sql<IBookingAddon[]>`
            INSERT INTO booking_addons ${sql(newBookingAddon)} RETURNING *;
        `;

		return context.json(
			{
				message: "Booking Addon Created Successfully",
				bookingAddon: insertedBookingAddon[0],
			},
			201
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * PATCH -> /booking_addons/:id
BookingAddonRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const updatedBookingAddon = await context.req.json<
			Partial<IBookingAddon>
		>();
		const updated = await sql<IBookingAddon[]>`
            UPDATE booking_addons SET ${sql(
				updatedBookingAddon
			)} WHERE id = ${id} RETURNING *;
        `;

		if (updated.length === 0) {
			return context.json({ message: "Booking Addon not found" }, 404);
		}

		return context.json(
			{
				message: "Booking Addon Updated Successfully",
				bookingAddon: updated[0],
			},
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * DELETE -> /booking_addons/:id
BookingAddonRoutes.delete("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const deleted = await sql<IBookingAddon[]>`
            DELETE FROM booking_addons WHERE id = ${id} RETURNING *;
        `;

		if (deleted.length === 0) {
			return context.json({ message: "Booking Addon not found" }, 404);
		}

		return context.json(
			{
				message: "Booking Addon Deleted Successfully",
				bookingAddon: deleted[0],
			},
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
