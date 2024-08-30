-- Drop foreign key constraint from messages table
ALTER TABLE "messages" DROP CONSTRAINT IF EXISTS "messages_user_id_fkey";

-- Drop indexes
DROP INDEX IF EXISTS "messages_user_id_idx";  -- Assuming a default index name
DROP INDEX IF EXISTS "users_phoneNumber_idx";  -- Assuming a default index name

-- Drop the messages table
DROP TABLE IF EXISTS "messages";

-- Drop the users table
DROP TABLE IF EXISTS "users";