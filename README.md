## docker-composeを使う場合
### 初回作成時
#### イメージの初回作成&コンテナの起動
```
docker compose up -d
```

#### 起動確認
```
docker ps
```

#### コンテナ停止
```
docker compose stop
```

#### コンテナ削除
```
docker compose down -v
```

### 更新時
#### イメージの更新
```
docker compose up --build --no-start
```

#### イメージが存在するかの確認
```
docker images
```
#### コンテナ起動
```
docker compose start
```

### コンテナ起動確認
```
docker ps
```

#### コンテナ停止
```
docker compose stop
```

#### コンテナ停止確認
```
docker ps
```

#### コンテナ削除
```
docker compose down -v
```

## docker-composeを使わない場合
#### Dockerイメージの作成
```
docker build -t [リポジトリ名]:[タグ名] .
```

#### イメージが存在するかの確認
以下のコマンドで作成した[リポジトリ名]と[タグ名]で調べる
```
docker images
```

#### イメージからコンテナを起動
-itd: インタラクティブモードで実行し、端末に接続し、デタッチドモード（バックグラウンドで実行）でコンテナを起動
-p [ホストのポート]:[コンテナのポート]: [ホストのポート]を[コンテナのポート]にマッピング。
[リポジトリ名]:[タグ名]: default_repo という名前のリポジトリから default_tag というタグのイメージを使用してコンテナを起動します。
```
docker run -itd -p [ホストのポート]:[コンテナのポート] [リポジトリ名]:[タグ名]
```

#### コンテナの起動確認
-aをつけると停止中のコンテナも見つけられる
```
docker ps
```

#### コンテナにssh
自分のPC上のためlocalhostを指定
[ホストのポート]を指定することで先ほどマッピングしたコンテナ側のポートに割り当てられる
```
ssh [コンテナ環境のユーザ名]@localhost -p [ホストのポート]
```

#### コンテナの停止
```
docker stop [コンテナIDまたはコンテナ名]
```

#### コンテナ停止の確認
statusでExited担っていることを確認
```
docker ps -a
```

#### コンテナの削除
```
docker rm [コンテナIDまたはコンテナ名]
```

#### コンテナ停止の確認
確認できなくなったら削除完了
```
docker ps -a
```
