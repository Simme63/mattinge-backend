import { Hono } from "hono";
import { sql } from "../database.js";
import type { IHouse } from "../types.js";

export const HouseRoutes = new Hono();

// * GET -> /house/:id
HouseRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const house = await sql<IHouse[]>`
			SELECT * FROM house WHERE id = ${id};
		`;

		if (house.length === 0) {
			return context.json({ message: "House not found" }, 404);
		}

		return context.json(
			{ message: "House Found Successfully", house: house[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /house
HouseRoutes.get("/", async (context) => {
	try {
		const houses = await sql<IHouse[]>`
			SELECT * FROM house;
		`;

		return context.json({ houses }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * POST -> /house
HouseRoutes.post("/", async (context) => {
	try {
		const body = await context.req.json<IHouse>();
		const result = await sql`
			INSERT INTO house ${sql(body)}
			RETURNING *;
		`;

		return context.json(
			{ message: "House Created Successfully", house: result[0] },
			201
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * PATCH -> /house/:id
HouseRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const body = await context.req.json<Partial<IHouse>>();
		const result = await sql`
			UPDATE house SET ${sql(body)} WHERE id = ${id}
			RETURNING *;
		`;

		return context.json(
			{ message: "House Updated Successfully", house: result[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * DELETE -> /house/:id
HouseRoutes.delete("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		await sql`
			DELETE FROM house WHERE id = ${id};
		`;

		return context.json({ message: "House Deleted Successfully" }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});