CREATE TABLE "gps" (
	"id"	INTEGER NOT NULL UNIQUE,
	"time"	NUMERIC,
	"status"	TEXT NOT NULL,
	"latitude"	NUMERIC,
	"north_or_south"	TEXT,
	"longitude"	NUMERIC,
	"east_or_west"	TEXT,
	"speed_in_knots"	NUMERIC,
	"course_over_ground_in_degrees"	NUMERIC,
	"date"	NUMERIC,
	"magnetic_variation"	TEXT,
	"mode"	TEXT,
	"checksum"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE "access_point" (
	"id"	INTEGER NOT NULL UNIQUE,
	"bssid"	TEXT NOT NULL,
	"ssid"	INTEGER NOT NULL,
	"rssid"	INTEGER,
	"auth_mode"	INTEGER,
	"channel"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT)
);


CREATE TABLE "ap_gps" (
	"id"	INTEGER,
	"bssid"	TEXT NOT NULL,
	"ssid"	TEXT NOT NULL,
	"rssid"	NUMERIC,
	"auth_mode"	INTEGER,
	"channel"	INTEGER,
	"time"	NUMERIC,
	"status"	TEXT,
	"latitude"	NUMERIC,
	"north_or_south"	NUMERIC,
	"longitude"	NUMERIC,
	"east_or_west"	TEXT,
	"speed"	NUMERIC,
	"course"	NUMERIC,
	"date"	TEXT,
	"magnetic_variation"	TEXT,
	"mode"	TEXT,
	"checksum"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
)

CREATE UNIQUE INDEX gps_index ON gps(status, mode, checksum);
