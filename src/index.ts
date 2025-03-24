import { serve } from "@hono/node-server";
import { Hono } from "hono";
import { logger } from "hono/logger";
import { BookerRoutes } from "./routes/booker.js";
import { BookingRoutes } from "./routes/bookings.js";
import { RoomBedsRoutes } from "./routes/room_beds.js";
import { BedsRoutes } from "./routes/beds.js";
import { RoomRoutes } from "./routes/room.js";
import { HouseRoomsRoutes } from "./routes/house_rooms.js";
import { StaffRoutes } from "./routes/staff.js";
import { BookingAddonRoutes } from "./routes/booking_addons.js";
import { HouseRoutes } from "./routes/house.js";
import { CustomerRoutes } from "./routes/customer.js";
import { GuestRoutes } from "./routes/guests.js";

const port = 3000;
const app = new Hono({ strict: false }).basePath("/api");

app.get("/", (c) => {
  return c.text("Hello! You shouldn't be here!");
});

if (!process.env.TEST) {
  app.use(logger());
}

// * Routes
app.route("/booker", BookerRoutes);
app.route("/booking", BookingRoutes);
app.route("/room_beds", RoomBedsRoutes);
app.route("/beds", BedsRoutes);
app.route("/room", RoomRoutes);
app.route("/house_rooms", HouseRoomsRoutes);
app.route("/staff", StaffRoutes);
app.route("/booking_addons", BookingAddonRoutes);
app.route("/house", HouseRoutes);
app.route("/customers", CustomerRoutes);
app.route("/guests", GuestRoutes);


// * 404 Route
app.use(async (context) => {
  return context.json(
    {
      error: `The specified route was not found. ${context.req.url.toString()}`,
    },
    404
  );
});

serve({
  fetch: app.fetch,
  // Set port to something unused to allow for tests while running api locally
  port: process.env.TEST ? Math.floor(Math.random() * 3200) : port,
});

if (!process.env.TEST) {
  console.log(`Server is running on http://localhost:${port}`);
}

export { app as mainApp };
