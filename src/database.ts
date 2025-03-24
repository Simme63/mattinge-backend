import * as dotenv from "dotenv";
import postgres from "postgres";

dotenv.config();

// Skapa en PostgreSQL-anslutning
export const sql = postgres({
  host: process.env.PG_HOST,
  port: Number(process.env.PG_PORT) || 5432,
  user: process.env.PG_USER,
  password: process.env.PG_PASSWORD,
  database: process.env.PG_DATABASE,
  ssl: process.env.PG_SSL === "true" ? { rejectUnauthorized: false } : false,
});
