SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://<storage_Account>.dfs.core.windows.net/<container_name>/<folder_path>/OrdersByState/part-00000-83ea4f3d-173b-413e-9b7e-45959f6b78d0-c000.snappy.parquet',
        FORMAT='PARQUET'
    ) AS [result]
