import { serve } from "@hono/node-server";
import { Hono } from "hono";
import { logger } from "hono/logger";
import { UserRoutes } from "./routes/users.js";
import { BookingRoutes } from "./routes/booking.js";

const port = 3000;
const app = new Hono({ strict: false }).basePath("/api");

app.get("/", (c) => {
  return c.text("Hello! You shouldn't be here!");
});

if (!process.env.TEST) {
  app.use(logger());
}

// * Routes
app.route("/users", UserRoutes);
app.route("/booking", BookingRoutes);

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
