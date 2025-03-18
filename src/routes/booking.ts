import { Hono } from "hono";
import { db } from "../database.js";
import type { IBooking } from "../types.js";

export const BookingRoutes = new Hono();

// * GET -> /booking
BookingRoutes.get("/", async (context) => {
  try {
    const [booking] = await db.execute<IBooking[]>("SELECT * FROM booking;");

    return context.json({ booking }, 200);
  } catch (error: unknown) {
    return context.json({ message: String(error) }, 500);
  }
});
