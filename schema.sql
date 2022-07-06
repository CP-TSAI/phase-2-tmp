-- To check with SQLite3, run command: `$ sqlite3 < schema.sql`

CREATE TABLE `User` (
  Email varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  first_name varchar(250) NOT NULL,
  last_name varchar(250) NOT NULL,
  nickname varchar(250) NOT NULL,
  postal_code varchar(250) NOT NULL,
  PRIMARY KEY (Email),
  UNIQUE(nickname),
  FOREIGN KEY (postal_code) REFERENCES Location_Lookup (postal_code)
);

CREATE TABLE Item (
  lister_email varchar(250) NOT NULL,
  title varchar(250) NOT NULL,
  Item_no int(16) NOT NULL, -- Note: in SQLite an int primary key will autoincrement by itself, so no need to use "AUTO_INCREMENT"
  game_type varchar(250) NOT NULL,
  number_of_cards int(16) NULL,
  platform varchar(250) NULL,
  media varchar(250) NULL,
  condition varchar(250) NOT NULL,
  description varchar(250) NULL,
  listing_url varchar(250) NOT NULL,
  PRIMARY KEY (Item_no),
  FOREIGN KEY (lister_email) REFERENCES `User` (email),
  FOREIGN KEY (game_type) REFERENCES Game_Platform_Map (game_type)
);


CREATE TABLE Game_Platform_Map (
  Game_type varchar(250) NOT NULL,
  platform varchar(250) NOT NULL,
  PRIMARY KEY (Game_type)
);

CREATE TABLE Trade (
  proposer_email varchar(250) NOT NULL,
  counterparty_email varchar(250) NOT NULL,
  proposer_item_no int(16) NOT NULL,
  counterparty_item_no int(16) NOT NULL,
  proposed_date datetime NOT NULL,
  accept_reject_date datetime NULL,
  status varchar(250) NOT NULL,
  trade_history_link varchar(250) NOT NULL,
  Auto_trade_id int(16) NOT NULL, -- Note: in SQLite an int primary key will autoincrement by itself, so no need to use "AUTO_INCREMENT"
  PRIMARY KEY (Auto_trade_id),
  FOREIGN KEY (proposer_email) REFERENCES `User` (email),
  FOREIGN KEY (counterparty_email) REFERENCES `User` (email),
  FOREIGN KEY (proposer_item_no) REFERENCES Item (item_no),
  FOREIGN KEY (counterparty_item_no) REFERENCES Item (item_no)
);

CREATE TABLE Location_Lookup (
  Postal_code varchar(250) NOT NULL,
  city varchar(250) NOT NULL,
  state varchar(250) NOT NULL,
  latitude float(8) NOT NULL,
  longitude float(8) NOT NULL,
  PRIMARY KEY (Postal_code)
);

CREATE TABLE Distance_color_lookup (
  distance_lower_range float(8) NOT NULL,
  distance_upper_range float(8) NOT NULL,
  background_color varchar(250) NOT NULL,
  PRIMARY KEY (distance_lower_range, distance_upper_range)
);

CREATE TABLE Response_color_lookup (
  Response_lower_range float(8) NOT NULL,
  Response_upper_range float(8) NOT NULL,
  text_color varchar(250) NOT NULL,
  PRIMARY KEY (Response_lower_range, Response_upper_range)
);


CREATE TABLE Rank_lookup (
  Trade_lower_range int(16) NOT NULL,
  Trade_upper_range int(16) NOT NULL,
  rank_label varchar(250) NOT NULL,
  PRIMARY KEY (Trade_lower_range, Trade_upper_range)
);