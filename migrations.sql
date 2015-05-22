-- Create a database
CREATE DATABASE volunteer_data;
\c chirpr_data

-- Create a users table with  id   username   password_hash
CREATE TABLE volunteers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password_hash VARCHAR(255)
);

-- Create a chirps table with  id   message   user_id
CREATE TABLE admin (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password_hash VARCHAR(255)
);
