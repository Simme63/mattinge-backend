import { Hono } from "hono";
import { sql } from "../database.js";
import type { IGuest } from "../types.js";

export const GuestRoutes = new Hono();

// * GET -> /guests/:id
GuestRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const guest = await sql<IGuest[]>`
			SELECT * FROM guests WHERE id = ${id};
		`;

		if (guest.length === 0) {
			return context.json({ message: "Guest not found" }, 404);
		}

		return context.json(
			{ message: "Guest Found Successfully", guest: guest[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /guests
GuestRoutes.get("/", async (context) => {
	try {
		const guests = await sql<IGuest[]>`
			SELECT * FROM guests;
		`;

		return context.json({ guests }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * POST -> /guests
GuestRoutes.post("/", async (context) => {
	try {
		const body = await context.req.json<IGuest>();
		const result = await sql`
			INSERT INTO guests ${sql(body)}
			RETURNING *;
		`;

		return context.json(
			{ message: "Guest Created Successfully", guest: result[0] },
			201
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * PATCH -> /guests/:id
GuestRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const body = await context.req.json<Partial<IGuest>>();
		const result = await sql`
			UPDATE guests SET ${sql(body)} WHERE id = ${id}
			RETURNING *;
		`;

		return context.json(
			{ message: "Guest Updated Successfully", guest: result[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * DELETE -> /guests/:id
GuestRoutes.delete("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		await sql`
			DELETE FROM guests WHERE id = ${id};
		`;

		return context.json({ message: "Guest Deleted Successfully" }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});