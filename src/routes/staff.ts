import { Hono } from "hono";
import { sql } from "../database.js";
import type { IStaff } from "../types.js";

export const StaffRoutes = new Hono();

// * GET -> /staff/:id
StaffRoutes.get("/:id", async (context) => {
    try {
        const id = context.req.param("id");
        const staff = await sql<IStaff[]>`
            SELECT * FROM staff WHERE id = ${id};
        `;

        if (staff.length === 0) {
            return context.json({ message: "Staff member not found" }, 404);
        }

        return context.json(
            { message: "Staff member found successfully", staff: staff[0] },
            200
        );
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});

// * GET -> /staff
StaffRoutes.get("/", async (context) => {
    try {
        const staff = await sql<IStaff[]>`
            SELECT * FROM staff;
        `;

        return context.json({ staff }, 200);
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});

// * POST -> /staff
StaffRoutes.post("/", async (context) => {
    try {
        const newStaff = await context.req.json<IStaff>();
        const insertedStaff = await sql<IStaff[]>`
            INSERT INTO staff ${sql(newStaff)} RETURNING *;
        `;

        return context.json(
            { message: "Staff member created successfully", staff: insertedStaff[0] },
            201
        );
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});

// * PATCH -> /staff/:id
StaffRoutes.patch("/:id", async (context) => {
    try {
        const id = context.req.param("id");
        const updatedStaff = await context.req.json<Partial<IStaff>>();
        const updated = await sql<IStaff[]>`
            UPDATE staff SET ${sql(updatedStaff)} WHERE id = ${id} RETURNING *;
        `;

        if (updated.length === 0) {
            return context.json({ message: "Staff member not found" }, 404);
        }

        return context.json(
            { message: "Staff member updated successfully", staff: updated[0] },
            200
        );
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});

// * DELETE -> /staff/:id
StaffRoutes.delete("/:id", async (context) => {
    try {
        const id = context.req.param("id");
        const deleted = await sql<IStaff[]>`
            DELETE FROM staff WHERE id = ${id} RETURNING *;
        `;

        if (deleted.length === 0) {
            return context.json({ message: "Staff member not found" }, 404);
        }

        return context.json(
            { message: "Staff member deleted successfully", staff: deleted[0] },
            200
        );
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});