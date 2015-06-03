-- Create a database
CREATE DATABASE volunteer_data;
\c volunteer_data

-- Create a users table with  id   username   password_hash
CREATE TABLE volunteers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  duty VARCHAR(255),
  phone_number VARCHAR(255)
);

-- Create a chirps table with  id   message   user_id
CREATE TABLE admin (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password_hash VARCHAR(255)
);
