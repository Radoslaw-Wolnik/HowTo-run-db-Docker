USE BirdCourse;
GO

-- Join posts with users, birds, places, and computed like counts.
SELECT
    p.id,
    pr.username,
    b.display_name AS bird,
    p.description,
    dbo.GetPostLikeCount(p.id) AS likes,
    pl.lat,
    pl.lng
FROM posts p
JOIN profiles pr ON pr.id = p.user_id
JOIN birds b ON b.id = p.bird_id
JOIN places pl ON pl.id = p.place_id
ORDER BY p.id;
GO

-- Stored procedure example.
EXEC dbo.FlagPost @post_id = 1, @username = 'user1', @reason = 'other';
GO

SELECT post_id, reason, resolved FROM flagged_posts;
GO
