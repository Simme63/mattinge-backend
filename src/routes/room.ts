import { Hono } from "hono";
import { sql } from "../database.js";
import type { IRoom } from "../types.js";

export const RoomRoutes = new Hono();

// * GET -> /room/:id
RoomRoutes.get("/:id", async (context) => {
    try {
        const id = context.req.param("id");
        const room = await sql<IRoom[]>`
            SELECT * FROM room WHERE id = ${id};
        `;

        if (room.length === 0) {
            return context.json({ message: "Room not found" }, 404);
        }

        return context.json(
            { message: "Room found successfully", room: room[0] },
            200
        );
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});

// * GET -> /room
RoomRoutes.get("/", async (context) => {
    try {
        const rooms = await sql<IRoom[]>`
            SELECT * FROM room;
        `;

        return context.json({ rooms }, 200);
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});

// * POST -> /room
RoomRoutes.post("/", async (context) => {
    try {
        const newRoom = await context.req.json<IRoom>();
        const insertedRoom = await sql<IRoom[]>`
            INSERT INTO room ${sql(newRoom)} RETURNING *;
        `;

        return context.json(
            { message: "Room created successfully", room: insertedRoom[0] },
            201
        );
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});

// * PATCH -> /room/:id
RoomRoutes.patch("/:id", async (context) => {
    try {
        const id = context.req.param("id");
        const updatedRoom = await context.req.json<Partial<IRoom>>();
        const updated = await sql<IRoom[]>`
            UPDATE room SET ${sql(updatedRoom)} WHERE id = ${id} RETURNING *;
        `;

        if (updated.length === 0) {
            return context.json({ message: "Room not found" }, 404);
        }

        return context.json(
            { message: "Room updated successfully", room: updated[0] },
            200
        );
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});

// * DELETE -> /room/:id
RoomRoutes.delete("/:id", async (context) => {
    try {
        const id = context.req.param("id");
        const deleted = await sql<IRoom[]>`
            DELETE FROM room WHERE id = ${id} RETURNING *;
        `;

        if (deleted.length === 0) {
            return context.json({ message: "Room not found" }, 404);
        }

        return context.json(
            { message: "Room deleted successfully", room: deleted[0] },
            200
        );
    } catch (error: unknown) {
        return context.json({ message: String(error) }, 500);
    }
});