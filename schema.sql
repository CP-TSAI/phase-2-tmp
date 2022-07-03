-- ################ Naming Convention ################
-- Entity/Table Names (singular noun): UpperCamelCase
--    Example: RegularUser  (note: without the ‘s’ singular)
-- Attribute Names: lowercase_underscore
--    Example: start_date
-- Primary Surrogate Keys: tableNameID
--    Example: userID  (where ‘ID’ is capitalized)
-- Foreign Keys: FK_ChildTable_childColumn_ParentTable_parentColumn     
--    Example: fk_AdminUser_email_User_email


-- ###################### Notes ######################
-- Note: Change the table name to the naming convention (TODO: the TABLE in report doesn't 100% follow the naming convention)
-- run the file with SQLite: `sqlite3 < schema.sql`

CREATE TABLE `User` (
  email varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  first_name varchar(250) NOT NULL,
  last_name varchar(250) NOT NULL,
  nickname varchar(250) NOT NULL,
  postal_code varchar(250) NOT NULL,
  PRIMARY KEY (email),
  UNIQUE(nickname),
  FOREIGN KEY (postal_code) REFERENCES LocationLookup (postal_code)
);

CREATE TABLE "Item" (
  "lister_email" varchar(250) NOT NULL,
  "title" varchar(250) NOT NULL,
  "item_no" int(16) NOT NULL, -- Note: in SQLite an int primary key will autoincrement by itself, so no need to use "AUTO_INCREMENT"
  "game_type" varchar(250) NOT NULL,
  "number_of_cards" int(16) NULL,
  "platform" varchar(250) NULL,
  "media" varchar(250) NULL,
  "condition" varchar(250) NOT NULL,
  "description" varchar(250) DEFAULT NULL,
  "listing_url" varchar(250) NOT NULL,
  PRIMARY KEY ("item_no"),
  UNIQUE("item_no"),
  FOREIGN KEY ("lister_email") REFERENCES "User" ("email"),
  FOREIGN KEY ("game_type") REFERENCES "GamePlatformMap" ("game_type");
);


CREATE TABLE "GamePlatformMap" (
  "game_type" varchar(250) NOT NULL,
  "platform" varchar(250) NOT NULL,
  PRIMARY KEY ("game_type"),
  UNIQUE("game_type");
);

CREATE TABLE "Trade" (
  "proposer_email" varchar(250) NOT NULL,
  "counterparty_email" varchar(250) NOT NULL,
  "proposer_item_no" int(16) NOT NULL,
  "counterparty_item_no" int(16) NOT NULL,
  "proposed_date" datetime NOT NULL,
  "accept_reject_date" datetime DEFAULT NULL,
  "status" varchar(250) NOT NULL,
  "trade_history_link" varchar(250) NOT NULL,
  "auto_trade_id" int(16) NOT NULL, -- Note: in SQLite an int primary key will autoincrement by itself, so no need to use "AUTO_INCREMENT"
  PRIMARY KEY ("auto_trade_id"),
  FOREIGN KEY ("proposer_email") REFERENCES "User" ("email"),
  FOREIGN KEY ("counterparty_email") REFERENCES "User" ("email"),
  FOREIGN KEY ("proposer_item_no") REFERENCES "Item" ("item_no"),
  FOREIGN KEY ("counterparty_item_no") REFERENCES "Item" ("item_no");
);

CREATE TABLE "LocationLookup" (
  "postal_code" varchar(250) NOT NULL,
  "city" varchar(250) NOT NULL,
  "state" varchar(250) NOT NULL,
  "latitude" float(8) NOT NULL,
  "longitude" float(8) NOT NULL,
  PRIMARY KEY ("postal_code"),
  UNIQUE("postal_code")
);

CREATE TABLE "ResponseColorLookup" (
  "response_lower_range" float(8) NOT NULL,
  "response_upper_range" float(8) NOT NULL,
  "text_color" varchar(250) NOT NULL,
  PRIMARY KEY ("response_lower_range", "response_upper_range")
);


CREATE TABLE "RankLookup" (
  "trade_lower_range" int(16) NOT NULL,
  "trade_upper_range" int(16) NOT NULL,
  "rank_label" varchar(250) NOT NULL,
  PRIMARY KEY ("trade_lower_range", "trade_upper_range")
);