import { Hono } from "hono";
import { sql } from "../database.js";
import type { IBeds } from "../types.js";

export const BedsRoutes = new Hono();

// * GET -> /beds/:id
BedsRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const bed = await sql<IBeds[]>`
            SELECT * FROM beds WHERE id = ${id};
        `;

		if (bed.length === 0) {
			return context.json({ message: "Bed not found" }, 404);
		}

		return context.json(
			{ message: "Bed found successfully", bed: bed[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /beds
BedsRoutes.get("/", async (context) => {
	try {
		const beds = await sql<IBeds[]>`
            SELECT * FROM beds;
        `;

		return context.json({ beds }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * POST -> /beds
BedsRoutes.post("/", async (context) => {
	try {
		const newBed = await context.req.json<IBeds>();
		const insertedBed = await sql<IBeds[]>`
            INSERT INTO beds ${sql(newBed)} RETURNING *;
        `;

		return context.json(
			{ message: "Bed created successfully", bed: insertedBed[0] },
			201
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * PATCH -> /beds/:id
BedsRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const updatedBed = await context.req.json<Partial<IBeds>>();
		const updated = await sql<IBeds[]>`
            UPDATE beds SET ${sql(updatedBed)} WHERE id = ${id} RETURNING *;
        `;

		if (updated.length === 0) {
			return context.json({ message: "Bed not found" }, 404);
		}

		return context.json(
			{ message: "Bed updated successfully", bed: updated[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * DELETE -> /beds/:id
BedsRoutes.delete("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const deleted = await sql<IBeds[]>`
            DELETE FROM beds WHERE id = ${id} RETURNING *;
        `;

		if (deleted.length === 0) {
			return context.json({ message: "Bed not found" }, 404);
		}

		return context.json(
			{ message: "Bed deleted successfully", bed: deleted[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
