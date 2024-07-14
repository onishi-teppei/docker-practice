# FROM ubuntu:24.04との違いは、Docker Hubが提供しているイメージから取得するか、AWS ECRが提供しているイメージから取得するかの違い
FROM public.ecr.aws/ubuntu/ubuntu:24.04

# -qqはapt-getの出力を抑制するオプション
RUN apt-get update -qq && apt-get install -y \
      openssh-server \
      curl \
      sudo

# /var/run/sshdはsshdサービスが実行中にログや一時ファイルを書き込む場所、ないとサービスが起動できない
RUN mkdir /var/run/sshd

# userグループを作成
# userユーザを作成、userグループとsudoグループに追加、ユーザーのログインシェルを/bin/bashに設定
# userユーザのパスワードをuser1に設定
# /etc/sudoersにuserを追加することで、userがsudoコマンドを実行できるようにする
RUN groupadd -g 1001 user \
    && useradd -m -s /bin/bash -u 1001 -g user -G sudo user \
    && echo user:user1 | chpasswd \
    && echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# sed -iで既存のファイルの中身を書き換える。今回は/etc/ssh/sshd_configを書き換えた。
# PermitRootLoginをprohibit-passwordからyesに変更することで、rootユーザーでのログインを許可する。ただし、パスワード認証は許可しない。
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config

# github_accountと言う環境変数を定義する。中身はcompose.ymlファイルで定義する。
# ARG github_account

# github_accountの公開鍵をダウンロードして、authorized_keysに追加する。
RUN mkdir -p /home/user/.ssh && curl https://github.com/onishi-teppei.keys >> /home/user/.ssh/authorized_keys
# sshするためのポートを開ける
EXPOSE 22

# CMDはコンテナが起動した際に実行されるコマンドを指定する。今回はsshdを起動する。
CMD ["/usr/sbin/sshd", "-D"]
