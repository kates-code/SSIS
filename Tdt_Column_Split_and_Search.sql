--DROP TABLE Col_Serach;
--DROP TABLE Data_Type;

CREATE VOLATILE TABLE Col_Serach
(
 part_of_the_string VARCHAR(50) NOT NULL
) ON COMMIT PRESERVE ROWS;

CREATE VOLATILE TABLE Data_Type
(
 Code VARCHAR(2) NULL,
 DType VARCHAR(100) NULL
) ON COMMIT PRESERVE ROWS;

INSERT INTO Col_Serach
(part_of_the_string)
SELECT token
  FROM TABLE (StrTok_Split_To_Table('string1', 'Item_Identifier', '_')
RETURNS (outkey VARCHAR(10) CHARACTER SET Unicode
        ,tokennum INTEGER
        ,token VARCHAR(50) CHARACTER SET Unicode)
        ) AS dt;

INSERT INTO Data_Type
SELECT '++', 'TD_ANYTYPE';
INSERT INTO Data_Type
SELECT 'A1', 'ARRAY (one dimensional)';
INSERT INTO Data_Type
SELECT 'AN', 'ARRAY (multidimensional)';
INSERT INTO Data_Type
SELECT 'I8', 'BIGINT';
INSERT INTO Data_Type
SELECT 'BO', 'BINARY LARGE OBJECT';
INSERT INTO Data_Type
SELECT 'BF', 'BYTE';
INSERT INTO Data_Type
SELECT 'BV', 'BYTE VARYING';
INSERT INTO Data_Type
SELECT 'I1', 'BYTEINT';
INSERT INTO Data_Type
SELECT 'CF', 'CHARACTER (fixed)';
INSERT INTO Data_Type
SELECT 'CV', 'CHARACTER (varying)';
INSERT INTO Data_Type
SELECT 'CO', 'CHARACTER LARGE OBJECT';
INSERT INTO Data_Type
SELECT 'D', 'DECIMAL';
INSERT INTO Data_Type
SELECT 'DA', 'DATE';
INSERT INTO Data_Type
SELECT 'F', 'DOUBLE PRECISION; DOUBLE PRECISION, FLOAT, and REAL are different names for the same data type.';
INSERT INTO Data_Type
SELECT 'F', 'FLOAT; FLOAT, DOUBLE PRECISION, and REAL are different names for the same data type.';
INSERT INTO Data_Type
SELECT 'I', 'INTEGER';
INSERT INTO Data_Type
SELECT 'DY', 'INTERVAL DAY';
INSERT INTO Data_Type
SELECT 'DH', 'INTERVAL DAY TO HOUR';
INSERT INTO Data_Type
SELECT 'DM', 'INTERVAL DAY TO MINUTE';
INSERT INTO Data_Type
SELECT 'DS', 'INTERVAL DAY TO SECOND';
INSERT INTO Data_Type
SELECT 'HR', 'INTERVAL HOUR';
INSERT INTO Data_Type
SELECT 'HM', 'INTERVAL HOUR TO MINUTE';
INSERT INTO Data_Type
SELECT 'HS', 'INTERVAL HOUR TO SECOND';
INSERT INTO Data_Type
SELECT 'MI', 'INTERVAL MINUTE';
INSERT INTO Data_Type
SELECT 'MS', 'INTERVAL MINUTE TO SECOND';
INSERT INTO Data_Type
SELECT 'MO', 'INTERVAL MONTH';
INSERT INTO Data_Type
SELECT 'SC', 'INTERVAL SECOND';
INSERT INTO Data_Type
SELECT 'YR', 'INTERVAL YEAR';
INSERT INTO Data_Type
SELECT 'YM', 'INTERVAL YEAR TO MONTH';
INSERT INTO Data_Type
SELECT 'N', 'NUMBER';
INSERT INTO Data_Type
SELECT 'D', 'NUMERIC';
INSERT INTO Data_Type
SELECT 'PD', 'PERIOD(DATE)';
INSERT INTO Data_Type
SELECT 'PT', 'PERIOD(TIME(n))';
INSERT INTO Data_Type
SELECT 'PZ', 'PERIOD(TIME(n) WITH TIME ZONE)';
INSERT INTO Data_Type
SELECT 'PS', 'PERIOD(TIMESTAMP(n))';
INSERT INTO Data_Type
SELECT 'PM', 'PERIOD(TIMESTAMP(n) WITH TIME ZONE)';
INSERT INTO Data_Type
SELECT 'F', 'REAL; REAL, DOUBLE PRECISION, and FLOAT are different names for the same data type.';
INSERT INTO Data_Type
SELECT 'I2', 'SMALLINT';
INSERT INTO Data_Type
SELECT 'AT', 'TIME';
INSERT INTO Data_Type
SELECT 'TS', 'TIMESTAMP';
INSERT INTO Data_Type
SELECT 'TZ', 'TIME WITH TIME ZONE';
INSERT INTO Data_Type
SELECT 'SZ', 'TIMESTAMP WITH TIME ZONE';
INSERT INTO Data_Type
SELECT 'UT', 'USER-DEFINED TYPE (ALL types)';
INSERT INTO Data_Type
SELECT 'XM', 'XML';

--SELECT * FROM Col_Serach;
--SELECT * FROM Data_Type;

SELECT DatabaseName, TableName, ColumnName, part_of_the_string, DType, ColumnLength, Nullable
  FROM DBC.ColumnsV
       INNER JOIN Col_Serach ON ColumnName LIKE Coalesce(Concat('%', part_of_the_string, '%'), ColumnName)
	   INNER JOIN Data_Type ON Coalesce(ColumnType, '') = Code
 WHERE 1 = 1
   --AND DatabaseName = ''
   --AND TableName = ''
   --AND ColumnName LIKE '%%'
 ORDER BY ColumnName, DatabaseName, TableName;