USE BirdCourse;
GO

-- Scalar function: reusable calculation for post popularity.
CREATE OR ALTER FUNCTION dbo.GetPostLikeCount(@post_id BIGINT)
RETURNS INT
AS
BEGIN
    DECLARE @like_count INT;
    SELECT @like_count = COUNT(*) FROM post_likes WHERE post_id = @post_id;
    RETURN @like_count;
END;
GO

-- Trigger: keep modified_at current when a post changes.
CREATE OR ALTER TRIGGER dbo.UpdatePostModifiedDate
ON posts
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE posts
    SET modified_at = GETDATE()
    FROM posts p
    JOIN inserted i ON i.id = p.id;
END;
GO

-- Stored procedure: flag a post from one clear call.
CREATE OR ALTER PROCEDURE dbo.FlagPost
    @post_id BIGINT,
    @username NVARCHAR(255),
    @reason NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO flagged_posts (post_id, user_id, reason)
    SELECT @post_id, id, @reason
    FROM profiles
    WHERE username = @username;
END;
GO
