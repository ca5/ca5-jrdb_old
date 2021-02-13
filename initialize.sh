# 参考:
# https://yomon.hatenablog.com/entry/2019/12/gcf_serverless_fw_deploy

# プロジェクト名は操作対象のプロジェクト名に変更してください
PROJECT=ca5-jrdb

# サービスアカウント名
SERVICE_ACCOUNT=ca5-jrdb-batch

# 認証情報をダウンロードするファイル
KEY_FILE=~/.gcloud/ca5-jrdb-batch.json

# 上記のデプロイに必要なロール
ROLES="roles/deploymentmanager.editor roles/storage.admin roles/logging.admin roles/cloudfunctions.developer"

# SA(Service Account) 作成
gcloud iam service-accounts create ${SERVICE_ACCOUNT} --display-name "Cloud Functions deployment account for Serverless Framework"

# SAにロールを割り当て
for role in ${ROLES};do
gcloud projects add-iam-policy-binding ${PROJECT} \
--member=serviceAccount:${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com \
--role=${role}
done

# サービスアカウントの認証情報取得
gcloud iam service-accounts keys create ${KEY_FILE} \
  --iam-account ${SERVICE_ACCOUNT}@${PROJECT}.iam.gserviceaccount.com