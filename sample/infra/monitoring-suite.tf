########################################
# モニタリングスイート: ログ / メトリクスの保存先と連携
########################################

########################################
# 保存先ストレージ
########################################

resource "sakura_monitoring_suite_log_storage" "apprun_logs" {
  name = "intern2026-apprun-logs"
  description = "AppRun 専有型のログ保存先"
}

resource "sakura_monitoring_suite_log_storage" "database_logs" {
  name = "intern2026-database-logs"
  description = "データベースログ保存先"
}

resource "sakura_monitoring_suite_metric_storage" "apprun_metrics" {
  name = "intern2026-apprun-metrics"
  description = "AppRun 専有型のメトリクス保存先"
}

resource "sakura_monitoring_suite_metric_storage" "database_metrics" {
  name = "intern2026-database-metrics"
  description = "データベースメトリクス保存先"
}

########################################
# ログ連携 (3 本)
########################################

# エージェントログ
resource "sakura_monitoring_suite_log_routing" "agent" {
  publisher_code = "apprun-dedicated"
  variant        = "agent_logs"
  storage_id     = sakura_monitoring_suite_log_storage.apprun_logs.id
}

# コンテナログ
resource "sakura_monitoring_suite_log_routing" "container" {
  publisher_code = "apprun-dedicated"
  variant        = "container_logs"
  storage_id     = sakura_monitoring_suite_log_storage.apprun_logs.id
}

# ロードバランサーアクセスログ
resource "sakura_monitoring_suite_log_routing" "lb_access" {
  publisher_code = "apprun-dedicated"
  variant        = "lb_access_logs"
  storage_id     = sakura_monitoring_suite_log_storage.apprun_logs.id
}

# データベースログ
resource "sakura_monitoring_suite_log_routing" "database" {
  publisher_code = "database"
  variant        = "systemlog"
  storage_id     = sakura_monitoring_suite_log_storage.database_logs.id
}

########################################
# メトリクス連携 (3 本)
########################################

# ノードメトリクス
resource "sakura_monitoring_suite_metric_routing" "node" {
  publisher_code = "apprun-dedicated"
  variant        = "node_metrics"
  storage_id     = sakura_monitoring_suite_metric_storage.apprun_metrics.id
}

# コンテナメトリクス
resource "sakura_monitoring_suite_metric_routing" "container" {
  publisher_code = "apprun-dedicated"
  variant        = "container_metrics"
  storage_id     = sakura_monitoring_suite_metric_storage.apprun_metrics.id
}

# ロードバランサーメトリクス
resource "sakura_monitoring_suite_metric_routing" "lb" {
  publisher_code = "apprun-dedicated"
  variant        = "lb_metrics"
  storage_id     = sakura_monitoring_suite_metric_storage.apprun_metrics.id
}

# データベースメトリクス
resource "sakura_monitoring_suite_metric_routing" "database" {
  publisher_code = "database"
  variant        = "systemmetrics"
  storage_id     = sakura_monitoring_suite_metric_storage.database_metrics.id
}
