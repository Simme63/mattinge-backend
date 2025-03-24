import { Hono } from "hono";
import { sql } from "../database.js";
import type { IBookings } from "../types.js";

export const BookingRoutes = new Hono();

// * GET -> /booking
BookingRoutes.get("/", async (context) => {
  try {
    const booking = await sql<IBookings[]>`
      SELECT * FROM booking;
      `

    return context.json({ booking }, 200);
  } catch (error: unknown) {
    return context.json({ message: String(error) }, 500);
  }
});
