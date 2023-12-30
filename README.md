# README

## ローカル環境構築

### 前提

- Docker Desktop をインストールしておくこと
- Docker Desktop が立ち上がっていること
- Windows / Intel Mac / Linux は未検証なので動かないところがあったら教えてください

### 手順

- リポジトリ直下の階層で `docker compose build`
- `docker compose run --rm web rails db:create`
- `docker compose run --rm web rails db:migrate`
- `docker compose up -d`
- ブラウザで `0.0.0.0:3001/home` or `localhost:3001/home` にアクセスし、 `{"status":"Your environment is successfully built."}` と表示されれば OK

- アプリ URL
  - `localhost:3001`
- Swagger Editor
  - `localhost:8001`
- Swagger UI(このアプリの API 定義書が確認できる。実態は api_doc/openapi.yaml)
  - `localhost:8002`

## 実装メモ

### ユーザー認証(devise)

- https://zenn.dev/shogo_matsumoto/articles/c6485b39c5f621
  - ユーザー認証は上記ページをもとに実装

### Swagger コンテナ

- https://qiita.com/A-Kira/items/3d17396c7cc98873e29d
