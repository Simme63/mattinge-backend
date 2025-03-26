import { Hono } from "hono";
import { sql } from "../database.js";
import type { IHouse_Rooms } from "../types.js";

export const HouseRoomsRoutes = new Hono();

// * GET -> /house_rooms/:id
HouseRoomsRoutes.get("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const houseRoom = await sql<IHouse_Rooms[]>`
            SELECT * FROM house_rooms WHERE id = ${id};
        `;

		if (houseRoom.length === 0) {
			return context.json({ message: "House room not found" }, 404);
		}

		return context.json(
			{
				message: "House room found successfully",
				houseRoom: houseRoom[0],
			},
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * GET -> /house_rooms
HouseRoomsRoutes.get("/", async (context) => {
	try {
		const houseRooms = await sql<IHouse_Rooms[]>`
            SELECT * FROM house_rooms;
        `;

		return context.json({ houseRooms }, 200);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * POST -> /house_rooms
HouseRoomsRoutes.post("/", async (context) => {
	try {
		const newHouseRoom = await context.req.json<IHouse_Rooms>();
		const insertedHouseRoom = await sql<IHouse_Rooms[]>`
            INSERT INTO house_rooms ${sql(newHouseRoom)} RETURNING *;
        `;

		return context.json(
			{
				message: "House room created successfully",
				houseRoom: insertedHouseRoom[0],
			},
			201
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * PATCH -> /house_rooms/:id
HouseRoomsRoutes.patch("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const updatedHouseRoom = await context.req.json<
			Partial<IHouse_Rooms>
		>();
		const updated = await sql<IHouse_Rooms[]>`
            UPDATE house_rooms SET ${sql(
				updatedHouseRoom
			)} WHERE id = ${id} RETURNING *;
        `;

		if (updated.length === 0) {
			return context.json({ message: "House room not found" }, 404);
		}

		return context.json(
			{
				message: "House room updated successfully",
				houseRoom: updated[0],
			},
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});

// * DELETE -> /house_rooms/:id
HouseRoomsRoutes.delete("/:id", async (context) => {
	try {
		const id = context.req.param("id");
		const deleted = await sql<IHouse_Rooms[]>`
            DELETE FROM house_rooms WHERE id = ${id} RETURNING *;
        `;

		if (deleted.length === 0) {
			return context.json({ message: "House room not found" }, 404);
		}

		return context.json(
			{
				message: "House room deleted successfully",
				houseRoom: deleted[0],
			},
			200
		);
	} catch (error: unknown) {
		return context.json({ message: String(error) }, 500);
	}
});
