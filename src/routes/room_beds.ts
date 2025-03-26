import { Hono } from "hono";
import { sql } from "../database.js";
import type { IRoom_Beds } from "../types.js";

export const RoomBedsRoutes = new Hono();

// * GET -> /room_beds/:id
RoomBedsRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const roomBed = await sql<IRoom_Beds[]>`
            SELECT * FROM room_beds WHERE id = ${id};
        `;

		if (roomBed.length === 0) {
			return context.json({ message: "Room bed not found" }, 404);
		}

		return context.json(
			{ message: "Room bed found successfully", roomBed: roomBed[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /room_beds
RoomBedsRoutes.get("/", async (context) => {
	try {
		const roomBeds = await sql<IRoom_Beds[]>`
            SELECT * FROM room_beds;
        `;

		return context.json({ roomBeds }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * POST -> /room_beds
RoomBedsRoutes.post("/", async (context) => {
	try {
		const newRoomBed = await context.req.json<IRoom_Beds>();
		const insertedRoomBed = await sql<IRoom_Beds[]>`
            INSERT INTO room_beds ${sql(newRoomBed)} RETURNING *;
        `;

		return context.json(
			{
				message: "Room bed created successfully",
				roomBed: insertedRoomBed[0],
			},
			201
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * PATCH -> /room_beds/:id
RoomBedsRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const updatedRoomBed = await context.req.json<Partial<IRoom_Beds>>();
		const updated = await sql<IRoom_Beds[]>`
            UPDATE room_beds SET ${sql(
				updatedRoomBed
			)} WHERE id = ${id} RETURNING *;
        `;

		if (updated.length === 0) {
			return context.json({ message: "Room bed not found" }, 404);
		}

		return context.json(
			{ message: "Room bed updated successfully", roomBed: updated[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * DELETE -> /room_beds/:id
RoomBedsRoutes.delete("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const deleted = await sql<IRoom_Beds[]>`
            DELETE FROM room_beds WHERE id = ${id} RETURNING *;
        `;

		if (deleted.length === 0) {
			return context.json({ message: "Room bed not found" }, 404);
		}

		return context.json(
			{ message: "Room bed deleted successfully", roomBed: deleted[0] },
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
