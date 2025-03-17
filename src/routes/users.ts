import { Hono } from "hono";
import { db } from "../database.js";
import type { IUser } from "../types.js";

export const UserRoutes = new Hono();

// * GET -> /users
UserRoutes.get("/", async (context) => {
	try {
		const [users] = await db.execute<IUser[]>("SELECT * FROM users;");

		return context.json({ users }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
