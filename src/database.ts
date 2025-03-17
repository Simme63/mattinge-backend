import * as dotenv from "dotenv";
import { drizzle } from "drizzle-orm/mysql2";
import mysql from "mysql2/promise";

dotenv.config();

// Skapa en anslutningspool
const pool = mysql.createPool({
	host: process.env.MYSQL_HOST,
	port: Number(process.env.MYSQL_PORT) || 3306,
	user: process.env.MYSQL_USER,
	password: process.env.MYSQL_PASSWORD,
	database: process.env.MYSQL_DATABASE,
	waitForConnections: true,
	connectionLimit: 10,
	queueLimit: 0,
});

// Koppla Drizzle till MariaDB
export const db = drizzle(pool);
