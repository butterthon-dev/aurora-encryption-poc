# infra/setup

Terraform を実行するための前提リソースを CloudFormation で作成します。

## 作成されるリソース

| リソース | 説明 |
|---|---|
| S3 バケット | Terraform state ファイルの保存先（バージョニング・暗号化有効） |

## パラメータ

| パラメータ | 説明 |
|---|---|
| `Env` | 環境名（`dev`, `stg`, `prod`） |
| `System` | システム名 |

## デプロイ

```bash
aws cloudformation deploy \
  --template-file cloud-formation.yaml \
  --stack-name aurora-encryption-poc \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    Env=dev \
    System=poc
```
