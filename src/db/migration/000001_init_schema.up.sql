CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "first_name" varchar(50) NOT NULL,
  "last_name" varchar(50) NOT NULL,
  "email" varchar(50) NOT NULL,
  "phone_number" varchar(50) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "messages" (
  "id" uuid PRIMARY KEY,
  "sent_to" varchar(50) NOT NULL,
  "body" varchar(100) NOT NULL,
  "user_id" uuid,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX ON "users" ("phoneNumber");

CREATE INDEX ON "messages" ("user_id");

ALTER TABLE "messages" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");