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
-- Note: Change the table name to the naming convention


CREATE TABLE "User" (
  "email" varchar(250) NOT NULL,
  "password" varchar(250) NOT NULL,
  "first_name" varchar(250) NOT NULL,
  "last_name" varchar(250) NOT NULL,
  "nickname" varchar(250) NOT NULL,
  "postal_code" varchar(250) NOT NULL,
  PRIMARY KEY ("email")
);

CREATE TABLE "Item" (
  "lister_email" varchar(250) NOT NULL,
  "title" varchar(250) NOT NULL,
  "item_no" int(16) NOT NULL,
  "game_type" varchar(250) NOT NULL,
  "number_of_cards" int(16) NULL,
  "platform" varchar(250) NULL,
  "media" varchar(250) NULL,
  "condition" varchar(250) NOT NULL,
  "description" varchar(250) NULL,
  "listing_url" varchar(250) NOT NULL,
  PRIMARY KEY ("item_no"), 
);


-- TODO: couldn't find the entity in EER
CREATE TABLE "GamePlatformMap" (
  "lister_email" varchar(250) NOT NULL,
  "title" varchar(250) NOT NULL,
  -- PRIMARY KEY (email), 
);

CREATE TABLE "Trade" (
  "proposer_email" varchar(250) NOT NULL,
  "counterparty_email" varchar(250) NOT NULL,
  "proposer_item_no" int(16) NOT NULL,
  "counterparty_item_no" int(16) NOT NULL,
  "proposed_date" datetime NOT NULL,
  "accept_reject_date" datetime NULL,
  "status" varchar(250) NOT NULL,
  "trade_history_link" varchar(250) NOT NULL,
  PRIMARY KEY ("proposer_email","counterparty_email","proposer_item_no","counterparty_item_no"),
  FOREIGN KEY ("proposer_email") REFERENCES "User" ("email"),
  FOREIGN KEY ("counterparty_email") REFERENCES "User" ("email"),
  FOREIGN KEY ("proposer_item_no") REFERENCES "Item" ("item_no"),
  FOREIGN KEY ("counterparty_item_no") REFERENCES "Item" ("item_no"),
);

CREATE TABLE "LocationLookup" (
  "postal_code" varchar(250) NOT NULL,
  "city" varchar(250) NOT NULL,
  "state" varchar(250) NOT NULL,
  "latitude" float(8) NOT NULL,
  "longitude" float(8) NOT NULL,
  -- PRIMARY KEY (email), 
);

CREATE TABLE ResponseColorLookup (
  response_lower_range float(8) NOT NULL,
  response_upper_range float(8) NOT NULL,
  text_color varchar(250) NOT NULL,
  -- PRIMARY KEY (email), 
);


CREATE TABLE RankLookup (
  trade_lower_range int(16) NOT NULL,
  trade_upper_range int(16) NOT NULL,
  rank_label varchar(250) NOT NULL,
  -- PRIMARY KEY (email), 
);