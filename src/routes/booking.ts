import { Hono } from "hono";
import { db } from "../database.js";
import type { IBooking } from "../types.js";
import { eq, gt, lt, gte, lte, sql } from "drizzle-orm";
import { number, z } from "zod";
import { validator } from "hono/validator";
import { validatorFn } from "../validators/validatorfn.js";

export const BookingRoutes = new Hono();

const bookingsSchema = z.object({
  id: z.coerce.number({ message: "Invalid booksid format!" }),
  userId: z.coerce.number({ message: "Invalid booksid format!" }),
  bookingDate: z.coerce.date({ message: "Book name is required!" }),
  checkInDate: z.coerce.date({ message: "Author name is required!" }),
  checkOutDate: z.coerce.date({ message: "Category is required!" }),
  bookingType: z.string({ message: "Invalid inventory ID format!" }),
  bookingName: z.string({ message: "Invalid inventory ID format!" }),
  status: z.string({ message: "Invalid inventory ID format!" }),
  amountOfGuests: z.coerce.number({ message: "Invalid inventory ID format!" }),
  totalPrice: z.coerce.number({ message: "Invalid inventory ID format!" }),
  createdAt: z.coerce.date({ message: "Invalid inventory ID format!" }),
  updatedAt: z.coerce.date({ message: "Invalid inventory ID format!" }),
});

// * GET -> /booking

BookingRoutes.get("/", async (context) => {
  try {
    const [booking] = await db.execute<IBooking[]>("SELECT * FROM bookings;");

    return context.json({ booking }, 200);
  } catch (error: unknown) {
    console.log(error);
    return context.json({ message: String(error) }, 500);
  }
});

BookingRoutes.get("/:bookingID", async (context) => {
  const bookingsID = context.req.param("bookingID");
  try {
    const [booking] = await db.execute<IBooking[]>(
      `SELECT * FROM booking WHERE user_id = ${bookingsID}`
    );

    return context.json({ booking }, 200);
  } catch (error: unknown) {
    console.log(error);
    return context.json({ message: String(error) }, 500);
  }
});

BookingRoutes.get("/date/:date", async (context) => {
  const bookingDate = context.req.param("date");
  try {
    const [booking] = await db.execute<IBooking[]>(
      sql`SELECT * FROM bookings WHERE check_in_date = DATE(${new Date(
        bookingDate
      )})`
    );
    return context.json({ booking }, 200);
  } catch (error: unknown) {
    console.log(error);
    return context.json({ message: String(error) }, 500);
  }
});

BookingRoutes.post(
  "/bookingpost",
  validator("json", validatorFn(bookingsSchema)),

  async (context) => {
    const booking = context.req.valid("json");

    try {
      const newBooking = await sql<IBooking[]>`
				INSERT INTO books (booksid, serialnumber, name, author, category, inventoryid)
				VALUES (${booking.id}, ${booking.bookingDate}, ${booking.checkInDate}, ${booking.checkOutDate}, ${booking.bookingType}, ${booking.bookingName},${booking.status},${booking.amountOfGuests},${booking.createdAt})
				RETURNING *;
			`;

      return context.json(
        { message: "Booking created successfully", booking: "booking!" },
        201
      );
    } catch (error: unknown) {
      return context.json({ message: String(error) }, 500);
    }
  }
);

BookingRoutes.delete(
  "/:userId",
  validator("json", validatorFn(bookingsSchema)),
  async (context) => {
    const userId = Number(context.req.param("userId"));

    try {
      // Check if booking exists
      const [booking] = await db.execute<IBooking[]>(
        sql`SELECT * FROM bookings WHERE userId = ${userId} LIMIT 1;`
      );

      if (!booking) {
        return context.json({ message: "Booking not found" }, 404);
      }

      // Delete the booking
      await db.execute(sql`DELETE FROM bookings WHERE userId = ${userId};`);

      return context.json({ message: "Booking deleted successfully" }, 200);
    } catch (error: unknown) {
      return context.json({ message: String(error) }, 500);
    }
  }
);

BookingRoutes.put(
  "/:id",
  validator("param", validatorFn(bookingsSchema)),
  validator("json", validatorFn(bookingsSchema)),
  async (context) => {
    const { id } = context.req.valid("param");
    const body = context.req.valid("json");

    try {
      // Check if the booking exists
      const [existingBooking] = await db.execute<IBooking[]>(
        sql`SELECT * FROM bookings WHERE id = ${id} LIMIT 1;`
      );

      if (!existingBooking) {
        return context.json({ message: "Booking not found" }, 404);
      }

      // Update the booking
      const updatedBooking = await db.execute<IBooking[]>(
        sql`
          UPDATE bookings
          SET 
            userId = ${body.userId},
            bookingDate = ${body.bookingDate},
            checkInDate = ${body.checkInDate},
            checkOutDate = ${body.checkOutDate},
            bookingType = ${body.bookingType},
            bookingName = ${body.bookingName},
            status = ${body.status},
            amountOfGuests = ${body.amountOfGuests},
            totalPrice = ${body.totalPrice},
            updatedAt = NOW()
          WHERE id = ${id}
          RETURNING *;
        `
      );

      return context.json(
        { message: "Booking updated successfully", updatedBooking },
        200
      );
    } catch (error: unknown) {
      return context.json({ message: String(error) }, 500);
    }
  }
);
