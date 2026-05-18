-- SQL Server relational schema adapted from the course bird spotting project.
-- Kept intentionally compact: users, profiles, places, birds, posts, likes, flags.

IF DB_ID('BirdCourse') IS NULL
    CREATE DATABASE BirdCourse;
GO

USE BirdCourse;
GO

CREATE TABLE users (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    role NVARCHAR(20) NOT NULL CHECK (role IN ('admin', 'dev', 'moderator', 'basic')),
    email NVARCHAR(255) UNIQUE NOT NULL,
    encrypted_password NVARCHAR(255) NOT NULL,
    banned_until DATETIME NULL,
    deleted_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE()
);
GO

CREATE TABLE profiles (
    id UNIQUEIDENTIFIER PRIMARY KEY,
    username NVARCHAR(255) UNIQUE NOT NULL,
    country NVARCHAR(255),
    birthday DATE,
    CONSTRAINT profiles_user_fk FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);
GO

CREATE TABLE birds (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    species NVARCHAR(255) UNIQUE NOT NULL,
    slug NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NOT NULL,
    display_name NVARCHAR(255) UNIQUE NOT NULL
);
GO

CREATE TABLE places (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    lat NUMERIC(9, 6) NOT NULL,
    lng NUMERIC(9, 6) NOT NULL
);
GO

CREATE TABLE posts (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    modified_at DATETIME NOT NULL DEFAULT GETDATE(),
    description NVARCHAR(MAX) NOT NULL,
    place_id BIGINT NOT NULL UNIQUE,
    bird_id BIGINT NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    moderated BIT NOT NULL DEFAULT 0,
    CONSTRAINT posts_place_fk FOREIGN KEY (place_id) REFERENCES places(id),
    CONSTRAINT posts_bird_fk FOREIGN KEY (bird_id) REFERENCES birds(id),
    CONSTRAINT posts_user_fk FOREIGN KEY (user_id) REFERENCES profiles(id)
);
GO

CREATE TABLE post_likes (
    post_id BIGINT NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (post_id, user_id),
    CONSTRAINT post_likes_post_fk FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    CONSTRAINT post_likes_user_fk FOREIGN KEY (user_id) REFERENCES profiles(id)
);
GO

CREATE TABLE flagged_posts (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    user_id UNIQUEIDENTIFIER NOT NULL,
    reason NVARCHAR(30) NOT NULL CHECK (reason IN ('offending', 'other', 'erotic', 'not_bird')),
    resolved BIT NOT NULL DEFAULT 0,
    post_id BIGINT NOT NULL,
    CONSTRAINT flagged_posts_post_fk FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    CONSTRAINT flagged_posts_user_fk FOREIGN KEY (user_id) REFERENCES profiles(id)
);
GO
