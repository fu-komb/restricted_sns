# README

## ローカル環境構築

### 前提

-   Docker Desktop をインストールしておくこと
-   Docker Desktop が立ち上がっていること
-   Windows / Intel Mac / Linux は未検証なので動かないところがあったら教えてください

### 手順

-   リポジトリ直下の階層で `docker compose build`
-   `docker compose run --rm web rails db:create`
-   `docker compose up -d`
-   ブラウザで `0.0.0.0:3001/home` or `localhost:3001/home` にアクセスし、 `{"status":"Your environment is successfully built."}` と表示されれば OK
