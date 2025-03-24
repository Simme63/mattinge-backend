import { Hono } from "hono";
import { sql } from "../database.js";
import type { IUser } from "../types.js";

export const UserRoutes = new Hono();

// * GET -> /users/:id
UserRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const user = await sql<IUser[]>`
	SELECT * FROM users WHERE id = ${id};
`;

		if (user.length === 0) {
			return context.json({ message: "User not found" }, 404);
		}

		return context.json(
			{ message: "User Found Successfully", user: user[0] },
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

		const user = await sql<IUser[]>`
	SELECT * FROM users WHERE  = ${organization};
`;
		return context.json(
			{ message: "User Found Successfully", user: user },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// > PATCH -> /users/:id
UserRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const user = await sql<IUser[]>`
		UPDATE users SET active = FALSE WHERE id = ${id}
			`
		;
		return context.json(
			{
				message: "User set to Inactive (deleted) Successfully",
				user: user,
			},
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /users
UserRoutes.get("/", async (context) => {
	try {
		const users = await sql<IUser[]>`
		SELECT * FROM users;
  	`;

		return context.json({ users }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
