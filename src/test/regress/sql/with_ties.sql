CREATE TABLE with_ties_table (a INT, b INT, c INT);
SELECT create_distributed_table('with_ties_table', 'a');
INSERT INTO with_ties_table VALUES (10, 20, 1), (11, 21, 2), (12, 22, 3), (12, 22, 4), (12, 22, 5), (12, 23, 6), (14, 24, 7);

-- test ordering by distribution column
SELECT * FROM with_ties_table ORDER BY a OFFSET 1 FETCH FIRST 2 ROWS WITH TIES;

-- test ordering by non-distribution column
SELECT * FROM with_ties_table ORDER BY b OFFSET 1 FETCH FIRST 2 ROWS WITH TIES;

-- test ordering by distribution column filtering one shard
SELECT * FROM with_ties_table WHERE a=12 ORDER BY a OFFSET 1 FETCH FIRST 1 ROWS WITH TIES;

-- test ordering by non-distribution column filtering one shard
SELECT * FROM with_ties_table WHERE a=12 ORDER BY b OFFSET 1 FETCH FIRST 1 ROWS WITH TIES;


-- test INSERT SELECTs into local table
CREATE TABLE with_ties_table_2 (a INT, b INT, c INT);

-- test ordering by distribution column
INSERT INTO with_ties_table_2 SELECT * FROM with_ties_table ORDER BY a OFFSET 1 FETCH FIRST 2 ROWS WITH TIES;
SELECT * FROM with_ties_table_2 ORDER BY c;
TRUNCATE with_ties_table_2;

-- test ordering by non-distribution column
INSERT INTO with_ties_table_2 SELECT * FROM with_ties_table ORDER BY b OFFSET 1 FETCH FIRST 2 ROWS WITH TIES;
SELECT * FROM with_ties_table_2 ORDER BY c;
TRUNCATE with_ties_table_2;

-- test ordering by distribution column filtering one shard
INSERT INTO with_ties_table_2 SELECT * FROM with_ties_table WHERE a=12 ORDER BY a OFFSET 1 FETCH FIRST 1 ROWS WITH TIES;
SELECT * FROM with_ties_table_2 ORDER BY c;
TRUNCATE with_ties_table_2;

-- test ordering by non-distribution column filtering one shard
INSERT INTO with_ties_table_2 SELECT * FROM with_ties_table WHERE a=12 ORDER BY b OFFSET 1 FETCH FIRST 1 ROWS WITH TIES;
SELECT * FROM with_ties_table_2 ORDER BY c;
TRUNCATE with_ties_table_2;


-- test INSERT SELECTs into distributed table
SELECT create_distributed_table('with_ties_table_2', 'a');

-- test ordering by distribution column
INSERT INTO with_ties_table_2 SELECT * FROM with_ties_table ORDER BY a OFFSET 1 FETCH FIRST 2 ROWS WITH TIES;
SELECT * FROM with_ties_table_2 ORDER BY c;
TRUNCATE with_ties_table_2;

-- test ordering by non-distribution column
INSERT INTO with_ties_table_2 SELECT * FROM with_ties_table ORDER BY b OFFSET 1 FETCH FIRST 2 ROWS WITH TIES;
SELECT * FROM with_ties_table_2 ORDER BY c;
TRUNCATE with_ties_table_2;

-- test ordering by distribution column filtering one shard
INSERT INTO with_ties_table_2 SELECT * FROM with_ties_table WHERE a=12 ORDER BY a OFFSET 1 FETCH FIRST 1 ROWS WITH TIES;
SELECT * FROM with_ties_table_2 ORDER BY c;
TRUNCATE with_ties_table_2;

-- test ordering by non-distribution column filtering one shard
INSERT INTO with_ties_table_2 SELECT * FROM with_ties_table WHERE a=12 ORDER BY b OFFSET 1 FETCH FIRST 1 ROWS WITH TIES;
SELECT * FROM with_ties_table_2 ORDER BY c;
TRUNCATE with_ties_table_2;


-- test ordering by multiple columns
SELECT * FROM with_ties_table ORDER BY a, b OFFSET 1 FETCH FIRST 2 ROWS WITH TIES;

-- test ordering by multiple columns filtering one shard
SELECT * FROM with_ties_table WHERE a=12 ORDER BY a, b OFFSET 1 FETCH FIRST 1 ROWS WITH TIES;


-- test without ties
-- test ordering by distribution column
SELECT * FROM with_ties_table ORDER BY a OFFSET 1 FETCH FIRST 2 ROWS ONLY;

-- test ordering by non-distribution column
SELECT * FROM with_ties_table ORDER BY b OFFSET 1 FETCH FIRST 2 ROWS ONLY;

-- test ordering by distribution column filtering one shard
SELECT * FROM with_ties_table WHERE a=12 ORDER BY a OFFSET 1 FETCH FIRST 1 ROWS ONLY;

-- test ordering by non-distribution column filtering one shard
SELECT * FROM with_ties_table WHERE a=12 ORDER BY b OFFSET 1 FETCH FIRST 1 ROWS ONLY;


--test other syntaxes
SELECT * FROM with_ties_table ORDER BY a OFFSET 1 FETCH NEXT 2 ROW WITH TIES;
SELECT * FROM with_ties_table ORDER BY a OFFSET 2 FETCH NEXT ROW WITH TIES;
