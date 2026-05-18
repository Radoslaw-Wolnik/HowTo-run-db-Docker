USE BirdCourse;
GO

INSERT INTO users (role, email, encrypted_password) VALUES
    ('admin', 'admin@example.com', 'password123'),
    ('basic', 'user1@example.com', 'password456'),
    ('moderator', 'mod@example.com', 'password012');
GO

INSERT INTO profiles (id, username, country, birthday) VALUES
    ((SELECT id FROM users WHERE email = 'admin@example.com'), 'adminUser', 'Poland', '1980-01-01'),
    ((SELECT id FROM users WHERE email = 'user1@example.com'), 'user1', 'Canada', '1985-02-10'),
    ((SELECT id FROM users WHERE email = 'mod@example.com'), 'modUser', 'Australia', '1988-04-25');
GO

INSERT INTO birds (species, slug, description, display_name) VALUES
    ('Sparrow', 'sparrow', 'Small city bird', 'Chirpy'),
    ('Robin', 'robin', 'Red-breasted bird', 'Red'),
    ('Hawk', 'hawk', 'Bird of prey', 'SharpEye');
GO

INSERT INTO places (lat, lng) VALUES
    (54.3520, 18.6466),
    (52.2297, 21.0122),
    (50.0647, 19.9450);
GO

INSERT INTO posts (description, place_id, bird_id, user_id, moderated) VALUES
    ('Saw a sparrow near the station.', 1, 1, (SELECT id FROM profiles WHERE username = 'adminUser'), 0),
    ('Robin spotted near the lake.', 2, 2, (SELECT id FROM profiles WHERE username = 'user1'), 1),
    ('Hawk sighting during a hike.', 3, 3, (SELECT id FROM profiles WHERE username = 'modUser'), 1);
GO

INSERT INTO post_likes (post_id, user_id) VALUES
    (1, (SELECT id FROM profiles WHERE username = 'user1')),
    (2, (SELECT id FROM profiles WHERE username = 'adminUser')),
    (3, (SELECT id FROM profiles WHERE username = 'modUser'));
GO
