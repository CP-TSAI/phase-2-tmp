-- To check with SQLite3, run command: `$ sqlite3 < schema.sql`
-- What do we do about attributes / tables that show up in the lookup tables in our report but not in the EER mapping? -JA

CREATE TABLE `User` (
  email varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  first_name varchar(250) NOT NULL,
  last_name varchar(250) NOT NULL,
  nickname varchar(250) NOT NULL,
  postal_code varchar(250) NOT NULL,
  PRIMARY KEY (email),
  UNIQUE(nickname),
  FOREIGN KEY (postal_code) REFERENCES Location_Lookup (postal_code)
);

CREATE TABLE Platform (
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`name`)
);

CREATE TABLE Item (
  lister_email varchar(250) NOT NULL,
  title varchar(250) NOT NULL,
  item_no int(16) NOT NULL, -- Note: in SQLite an int primary key will autoincrement by itself, so no need to use "AUTO_INCREMENT"
  game_type varchar(250) NOT NULL, --delete?
  number_of_cards int(16) NULL, --delete?
  platform varchar(250) NULL, --delete?
  media varchar(250) NULL, --delete + all the above because of the new separate tables? -JA
  condition varchar(250) NOT NULL,
  description varchar(250) NULL,
  listing_url varchar(250) NOT NULL,
  PRIMARY KEY (item_no, lister_email),
  FOREIGN KEY (lister_email) REFERENCES `User` (email),
  FOREIGN KEY (game_type) REFERENCES Game_Platform_Map (game_type)
);

CREATE TABLE Item_Collectable_Card_Game (
  lister_email varchar(250) NOT NULL,
  item_no int(16) NOT NULL,
  number_of_cards int(16) NULL,
  PRIMARY KEY (item_no, lister_email),
  FOREIGN KEY (item_no) REFERENCES Item (item_no),
  FOREIGN KEY (lister_email) REFERENCES `User` (email)
);

CREATE TABLE Item_Board_Game (
  lister_email varchar(250) NOT NULL,
  item_no int(16) NOT NULL,
  PRIMARY KEY (item_no, lister_email),
  FOREIGN KEY (item_no) REFERENCES Item (item_no),
  FOREIGN KEY (lister_email) REFERENCES `User` (email)
);

CREATE TABLE Item_Playing_Card_Game (
  lister_email varchar(250) NOT NULL,
  item_no int(16) NOT NULL,
  PRIMARY KEY (item_no, lister_email),
  FOREIGN KEY (item_no) REFERENCES Item (item_no),
  FOREIGN KEY (lister_email) REFERENCES `User` (email)
);

CREATE TABLE Item_Computer_Game (
  lister_email varchar(250) NOT NULL,
  item_no int(16) NOT NULL,
  media varchar(250) NULL,
  PRIMARY KEY (item_no, lister_email),
  FOREIGN KEY (item_no) REFERENCES Item (item_no),
  FOREIGN KEY (lister_email) REFERENCES `User` (email)
);

CREATE TABLE Item_Video_Game (
  lister_email varchar(250) NOT NULL,
  item_no int(16) NOT NULL,
  platform varchar(250) NULL,
  media varchar(250) NULL,
  PRIMARY KEY (item_no, lister_email, platform),
  FOREIGN KEY (item_no) REFERENCES Item (item_no),
  FOREIGN KEY (lister_email) REFERENCES `User` (email)
  FOREIGN KEY (platform) REFERENCES Platform (`name`)
);

CREATE TABLE Item_Desired (
  lister_email varchar(250) NOT NULL,
  item_no int(16) NOT NULL,
  PRIMARY KEY (item_no, lister_email),
  FOREIGN KEY (item_no) REFERENCES Item (item_no),
  FOREIGN KEY (lister_email) REFERENCES `User` (email)
);

CREATE TABLE Item_Proposed (
  lister_email varchar(250) NOT NULL,
  item_no int(16) NOT NULL,
  PRIMARY KEY (item_no, lister_email),
  FOREIGN KEY (item_no) REFERENCES Item (item_no),
  FOREIGN KEY (lister_email) REFERENCES `User` (email)
);

CREATE TABLE Game_Platform_Map (
  game_type varchar(250) NOT NULL,
  platform varchar(250) NOT NULL,
  PRIMARY KEY (game_type)
);

CREATE TABLE Trade (
  proposer_email varchar(250) NOT NULL,
  counterparty_email varchar(250) NOT NULL,
  proposer_item_no int(16) NOT NULL,
  counterparty_item_no int(16) NOT NULL,
  proposed_date datetime NOT NULL,
  accept_reject_date datetime NULL,
  status varchar(250) NOT NULL,
  trade_history_link varchar(250) NOT NULL, -- what do we do if we delete the auto_trade_id attribute below? Since we don't need it anymore - JA
  auto_trade_id int(16) NOT NULL, -- Note: in SQLite an int primary key will autoincrement by itself, so no need to use "AUTO_INCREMENT"
  PRIMARY KEY (proposer_email, counterparty_email, proposer_item_no, counterparty_item_no),
  FOREIGN KEY (proposer_email) REFERENCES Item_Proposed (lister_email),
  FOREIGN KEY (counterparty_email) REFERENCES Item_Desired (lister_email),
  FOREIGN KEY (proposer_item_no) REFERENCES Item_Proposed (item_no),
  FOREIGN KEY (counterparty_item_no) REFERENCES Item_Desired (item_no)
);

CREATE TABLE Location_Lookup ( -- 1. this table and the tables number 1-4 down here below are not shown in the EER mapping -JA
  postal_code varchar(250) NOT NULL, -- (continued from above) Does this location_lookup table represent the postal_code table? - JA
  city varchar(250) NOT NULL,
  state varchar(250) NOT NULL,
  latitude float(8) NOT NULL,
  longitude float(8) NOT NULL,
  PRIMARY KEY (postal_code)
);

CREATE TABLE Distance_color_lookup ( -- 2
  distance_lower_range float(8) NOT NULL,
  distance_upper_range float(8) NOT NULL,
  background_color varchar(250) NOT NULL,
  PRIMARY KEY (distance_lower_range, distance_upper_range)
);

CREATE TABLE Response_color_lookup ( -- 3
  response_lower_range float(8) NOT NULL,
  response_upper_range float(8) NOT NULL,
  text_color varchar(250) NOT NULL,
  PRIMARY KEY (response_lower_range, response_upper_range)
);

CREATE TABLE Rank_lookup ( --4
  trade_lower_range int(16) NOT NULL,
  trade_upper_range int(16) NOT NULL,
  rank_label varchar(250) NOT NULL,
  PRIMARY KEY (trade_lower_range, trade_upper_range)
);