DROP DATABASE IF EXISTS it_company;
CREATE DATABASE it_company;
USE it_company;

DROP TABLE IF EXISTS members;
CREATE TABLE members (
	id SERIAL PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE,
    phone BIGINT, 
    INDEX users_phone_idx(phone), 
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	members_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NULL,
    created_at DATETIME DEFAULT NOW(),
    POSITION_member VARCHAR(100),
    FOREIGN KEY (members_id) REFERENCES members(id) 
    	ON UPDATE CASCADE 
    	ON DELETE restrict 
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_members_id BIGINT UNSIGNED NOT NULL,
    to_members_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), 
    INDEX messages_from_members_id (from_members_id),
    INDEX messages_to_members_id (to_members_id),
    FOREIGN KEY (from_members_id) REFERENCES members(id),
    FOREIGN KEY (to_members_id) REFERENCES members(id)
);

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
	initiator_members_id BIGINT UNSIGNED NOT NULL,
    target_members_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM ('admins', 'team_leaders', 'developers','testers'),
	requested_at DATETIME DEFAULT NOW(),
	confirmed_at DATETIME,
	
    PRIMARY KEY (initiator_members_id, target_members_id),
	INDEX (initiator_members_id),
    INDEX (target_members_id),
    FOREIGN KEY (initiator_members_id) REFERENCES members(id),
    FOREIGN KEY (target_members_id) REFERENCES members(id)
);

DROP TABLE IF EXISTS proects;
CREATE TABLE proects(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),

	INDEX proects_name_idx(name)
);

DROP TABLE IF EXISTS members_proects;
CREATE TABLE members_proects(
	members_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (members_id, proects_id), 
    FOREIGN KEY (members_id) REFERENCES members(id),
    FOREIGN KEY (proects_id) REFERENCES proects(id)
);

DROP TABLE IF EXISTS instructions;
CREATE TABLE instructions(
	id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);

DROP TABLE IF EXISTS instruction_sucsess;
CREATE TABLE instruction_sucsess(
	id SERIAL PRIMARY KEY,
    instruction_id BIGINT UNSIGNED NOT NULL,
    members_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX (members_id),
    FOREIGN KEY (members_id) REFERENCES members(id),
    FOREIGN KEY (instructions_id) REFERENCES instructions(id)
);

DROP TABLE IF EXISTS plan;
CREATE TABLE plan (
	id SERIAL PRIMARY KEY,
	embers_proects_id BIGINT unsigned NOT NULL,
	instructions_id BIGINT unsigned NOT NULL,

	FOREIGN KEY (members_proects_id) REFERENCES members_proects(id),
    FOREIGN KEY (instructions_id) REFERENCES media(id)
);
DROP TABLE IF EXISTS membersproects;
CREATE TABLE membersproects(  
	members_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,     
	PRIMARY KEY (members_id, proects_id),
	FOREIGN KEY (members_id) REFERENCES members(id),
	FOREIGN KEY (proects_id) REFERENCES proects(id) )


