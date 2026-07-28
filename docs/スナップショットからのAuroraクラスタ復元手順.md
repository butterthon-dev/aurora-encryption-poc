1. 手動でAuroraクラスターのスナップショットを取得
2. infra/stacks/compute/main.tfに`module "database_v2"`を追加  
※ スナップショットから復元する場合はstorage_encrypted=trueだけでなくkms_key_id（aws/rds）の指定も必須
※ snapshot_identifierに取得したクラスタースナップショットのARNを指定
3. terraform apply
4. スナップショットから暗号化が有効化されたAuroraクラスタおよびインスタンスが復元されたことを確認  
※ 実際にAuroraに接続してデータの確認なども行う
5. infra/stacks/compute/main.tfから`module "database"`を削除（本ソースコード上はコメントアウトしている）
6. terraform apply  
（クラスターとインスタンスがreplaceされないことを確認）
以上
