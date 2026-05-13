# HowTo-run-db-in-container

A beginner-friendly tutorial for running database servers in Docker instead of installing them locally.

At my university, database servers were installed on every machine by default.  
This repository shows a faster and easier alternative: run the database in a container and connect to it from your tools.

## Why use Docker for databases?

- No local database server installation needed
- Faster setup
- Easy to reset and rebuild
- Reproducible environment for everyone
- Works well for learning, labs, and short-term projects

## What is in this repository?

This repository contains two examples:

- **MongoDB**
- **Oracle Database**

Each example shows how to start a database in Docker and how to connect to it afterward.

## Requirements

Before you start, make sure you have:

- Docker
- Docker Compose
- A database client, if you want to connect with a GUI tool

Suggested clients:

- MongoDB Compass for MongoDB
- Oracle SQL Developer for Oracle

## Project structure

- `mongo/containers/` — MongoDB example with Dockerfile, Compose file, config, and initialization script
- `oracle/` — Oracle examples with Compose files, `.env` setup, and connection instructions

## MongoDB example

The MongoDB example runs MongoDB in a container and stores data in a Docker volume, so your data stays available after restarts.

### What it includes

- Docker image based on `mongo:6.0`
- Custom `mongod.conf`
- Initialization script that creates users
- Docker Compose setup
- Persistent volume for database data

### Quick start

1. Go to the MongoDB example folder.
2. Make the initialization script executable.
3. Start the container with Docker Compose.
4. Connect using MongoDB Compass or another MongoDB client.

### Example connection string

`mongodb://root:your_secure_password@localhost:27017/`

## Oracle example

The Oracle example shows two approaches:

- a **community image** setup
- an **official Oracle image** setup

Both approaches use Docker Compose and `.env` variables to keep configuration simple.

### Quick start with the community image

1. Copy `.env.example` to `.env`
2. Fill in the values you need
3. Start the container with Docker Compose
4. Connect with SQL*Plus or Oracle SQL Developer

### Quick start with the official image

1. Create your `.env` file
2. Log in to the Oracle container registry
3. Start the container with Docker Compose
4. Connect using SQL*Plus or Oracle SQL Developer

## What this project teaches

This repository is meant to show that you do not always need to install a database server directly on your machine.  
With Docker, you can run the database in a container, keep it isolated, and remove it whenever you are done.

## Notes

- Make sure script files have the correct permissions before running them.
- Check the `howTo.md` file in each folder for the exact connection details and commands.
- Data is stored in Docker volumes, so deleting a container does not necessarily delete the database files.

## License

MIT
