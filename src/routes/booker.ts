import { Hono } from "hono";
import { sql } from "../database.js";
import type { IBooker } from "../types.js";

export const BookerRoutes = new Hono();

// * GET -> /booker/:id
BookerRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const booker = await sql<IBooker[]>`
	SELECT * FROM booker WHERE id = ${id};
`;

		if (booker.length === 0) {
			return context.json({ message: "Booker not found" }, 404);
		}

		return context.json(
			{ message: "Booker Found Successfully", booker: booker[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /bookers/:organization
BookerRoutes.get("/:organization", async (context) => {
	try {
		const organization = context.req.param("organization");

		const booker = await sql<IBooker[]>`
	SELECT * FROM bookers WHERE  = ${organization};
`;
		return context.json(
			{ message: "Booker Found Successfully", booker: booker[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// > PATCH -> /bookers/:id
BookerRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const booker = await sql<IBooker[]>`
		UPDATE bookers SET active = FALSE WHERE id = ${id}
			`
		;
		return context.json(
			{
				message: "Booker set to Inactive (deleted) Successfully",
				booker: booker[0],
			},
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /bookers
BookerRoutes.get("/", async (context) => {
	try {
		const bookers = await sql<IBooker[]>`
		SELECT * FROM bookers;
  	`;

		return context.json({ booker: bookers[0] }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});