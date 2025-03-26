import { Hono } from "hono";
import { sql } from "../database.js";
import type { ICustomer } from "../types.js";

export const CustomerRoutes = new Hono();

// * GET -> /customers/:id
CustomerRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const customer = await sql<ICustomer[]>`
			SELECT * FROM customer WHERE id = ${id};
		`;

		if (customer.length === 0) {
			return context.json({ message: "Customer not found" }, 404);
		}

		return context.json(
			{ message: "Customer Found Successfully", customer: customer[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /customers
CustomerRoutes.get("/", async (context) => {
	try {
		const customers = await sql<ICustomer[]>`
			SELECT * FROM customer;
		`;

		return context.json({ customers }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * POST -> /customers
CustomerRoutes.post("/", async (context) => {
	try {
		const body = await context.req.json<ICustomer>();
		const result = await sql`
			INSERT INTO customer ${sql(body)}
			RETURNING *;
		`;

		return context.json(
			{ message: "Customer Created Successfully", customer: result[0] },
			201
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * PATCH -> /customers/:id
CustomerRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const body = await context.req.json<Partial<ICustomer>>();
		const result = await sql`
			UPDATE customer SET ${sql(body)} WHERE id = ${id}
			RETURNING *;
		`;

		return context.json(
			{ message: "Customer Updated Successfully", customer: result[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * DELETE -> /customers/:id
CustomerRoutes.delete("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		await sql`
			DELETE FROM customer WHERE id = ${id};
		`;

		return context.json({ message: "Customer Deleted Successfully" }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
