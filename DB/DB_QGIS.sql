

select * from [dbo].[10m_urban_areas]

select * from dbo.[spatial_ref_sys]

select * from dbo.[geometry_columns]

select qgs_fid, geom.STAsText() as wkt
from dbo.[10m_urban_areas]

--10.1.	Нахождение пересечения пространственных объектов;

SELECT geom.STIntersection(geom) AS intersection_geom
FROM [dbo].[10m_urban_areas];

--10.2.	Нахождение объединения пространственных объектов;
SELECT geom.STUnion(geom) AS union_geom
FROM [dbo].[10m_urban_areas];

-------------------------------------
--10.3 task
-------------------------------------
SELECT geom.STWithin(geom) AS is_within
FROM [dbo].[10m_urban_areas];

-------------------------------------
--10.4 task
-------------------------------------
SELECT geom.Reduce(0.5) AS simplified_geom
FROM [dbo].[10m_urban_areas];


-------------------------------------
--10.5 task
-------------------------------------
SELECT geom.STAsText() AS well_known_text
FROM [dbo].[10m_urban_areas];

-------------------------------------
--10.6 task
-------------------------------------
SELECT geom.STDimension() AS object_dimension
FROM [dbo].[10m_urban_areas];

-------------------------------------
--10.7 task
-------------------------------------
SELECT geom.STLength() AS object_length
FROM [dbo].[10m_urban_areas];

SELECT geom.STArea() AS object_area
FROM [dbo].[10m_urban_areas];

-------------------------------------
--10.8 task
-------------------------------------
SELECT 
    A.geom.STDistance(B.geom) AS distance_between_objects
FROM 
    [dbo].[10m_urban_areas] A
    CROSS JOIN [dbo].[10m_urban_areas] B
WHERE 
    A.qgs_fid <> B.qgs_fid; -- чтобы исключить измерение расстояния до самого себя

-------------------------------------
--11 task
-------------------------------------
--Point
DECLARE @point geometry;
SET @point = geometry::STGeomFromText('POINT(1 2)', 4326);
SELECT @point AS Point;

--Line
DECLARE @line geometry;
SET @line = geometry::STGeomFromText('LINESTRING(0 0, 50 50)', 4326);
SELECT @line AS Line;

--Polygon
DECLARE @polygon geometry;
SET @polygon = geometry::STGeomFromText('POLYGON((0 0, 0 1, 1 1, 1 0, 0 0))', 4326);
SELECT @polygon AS Polygon;

---------------------------------
--12 task
---------------------------------
--Point
DECLARE @point geometry;
SET @point = geometry::STGeomFromText('POINT(28.179 53.501)', 4326);
SELECT *
FROM [dbo].[10m_admin_0_map_units]
WHERE @point.STIntersects(geom) = 1;

--Line
DECLARE @line geometry;
SET @line = geometry::STGeomFromText('LINESTRING(20 10 , 25 15)', 4326);
SELECT *
FROM [dbo].[10m_admin_0_map_units]
WHERE @line.STIntersects(geom) = 1;

--Polygon
DECLARE @polygon geometry;
SET @polygon = geometry::STGeomFromText('POLYGON((20 10, 25 10, 25 15, 20 10))', 4326);
SELECT *
FROM [dbo].[10m_admin_0_map_units]
WHERE @polygon.STIntersects(geom) = 1;