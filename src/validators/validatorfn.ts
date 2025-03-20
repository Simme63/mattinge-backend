import type { Context } from "hono";
import type { z } from "zod";

const formatZodErrors = (error: z.ZodError) => {
	return error.issues.reduce(
		(acc, issue) => {
			const field = issue.path.join(".");
			if (!acc[field]) acc[field] = [];
			acc[field].push(issue.message);
			return acc;
		},
		{} as Record<string, string[]>,
	);
};

export const validatorFn = <T extends z.ZodTypeAny>(schema: T) => {
	return (
		value: Record<string, string | string[]>,
		// biome-ignore lint/suspicious/noExplicitAny: <explanation>
		// biome-ignore lint/complexity/noBannedTypes: <explanation>
		c: Context<any, string, {}>,
	) => {
		const parsed = schema.safeParse(value);
		if (!parsed.success) {
			return c.json({ message: "Validation error", errors: formatZodErrors(parsed.error) }, 400);
		}
		return parsed.data as z.infer<T>;
	};
};