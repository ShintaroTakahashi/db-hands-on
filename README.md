# db-hands-on
FE勉強会用

# DB起動

`docker compose up -d`

## pg admin

`localhost:8080`

- user/email: `example@example.com`
- password: `password`

サーバ追加

- host: `postgres_service`
- port: `5432`
- database: `testdb01`
- username: `postgres`
- password: `postgres`

## postgres

コンテナに入る
`docker exec -it [container id] sh`

テストDBに接続
`psql -d testdb01 -U postgres`


# sql

[参考](https://qiita.com/H-A-L/items/fe8cb0e0ee0041ff3ceb)

db削除
`DROP DATABASE library_db;`
