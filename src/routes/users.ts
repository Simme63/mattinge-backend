import { Hono } from "hono";
import { db } from "../database.js";
import type { IUser } from "../types.js";

export const UserRoutes = new Hono();

// * GET -> /users/:id
UserRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");

		const [rows] = await db.execute<IUser[]>(
			`SELECT * FROM users WHERE id = ${id};`
		);
		return context.json(
			{ message: "User Found Successfully", user: rows },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /users/:organization
UserRoutes.get("/:organization", async (context) => {
	try {
		const organization = context.req.param("organization");

		const [rows] = await db.execute<IUser[]>(
			`SELECT * FROM users WHERE  = ${organization};`
		);
		return context.json(
			{ message: "User Found Successfully", user: rows },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /users
UserRoutes.get("/", async (context) => {
	try {
		const [users] = await db.execute<IUser[]>("SELECT * FROM users;");

		return context.json({ users }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
