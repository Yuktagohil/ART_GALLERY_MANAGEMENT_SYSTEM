# 🎨 Art Gallery Management System

A centralized database management system designed to digitize and streamline 
art gallery operations — managing artworks, exhibitions, sales, and customer 
relationships through a robust SQL-based backend.

## 📌 Project Overview

Traditional art galleries are limited by physical space and geographic reach. 
This system solves that by providing an online platform where artists can 
showcase their work globally and customers can browse and purchase artwork 
from anywhere in the world.

## 🎯 Business Problems Solved

- Eliminated manual inventory tracking through centralized database management
- Enabled online exhibitions removing geographic limitations for artists
- Automated sales and order management reducing human errors
- Built role-based access control for Admins, Artists and Customers

## 🛠️ Technical Stack

- **Database:** Oracle SQL / PL-SQL
- **Concepts Used:** Entity Relationship Modeling, Normalization, 
  Stored Procedures, User Access Control, Transaction Management

## 📊 Database Design Highlights

- Designed complex ER diagrams with 10+ entities
- Implemented strict business rules and constraints
- Built user role management — Admin, Artist, Customer
- Secure transaction handling with non-cancellable order logic
- Multi-user access control using GRANT permissions

## 🔍 Key Features

- Artwork inventory management across multiple categories
- Online exhibition scheduling and management
- Customer order processing and shipment tracking
- Artist registration and portfolio management
- Role based access — different permissions per user type

## 👥 Team

Developed as part of DMDD coursework at Northeastern University, Boston.

## 🚀 How to Run

1. Run `USERGRANT.sql` as Admin to create users and grant access
2. Login with credentials created in step 1
3. Run `PROJECT3.sql` to create and populate the database
