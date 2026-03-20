#!/usr/bin/env bash
# 将本仓库推送到 GitHub（需已登录 GitHub，且网络可访问 github.com）
# 用法：
#   1) 在网页新建公开仓库：agibot-certis-embodied-security-report（不要勾选 README）
#   2) 执行：GITHUB_USERNAME=你的用户名 bash scripts/push-to-github.sh
# 或设置完整远程地址：
#   GIT_REMOTE_URL=https://github.com/你的用户名/agibot-certis-embodied-security-report.git bash scripts/push-to-github.sh

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

REPO_NAME="agibot-certis-embodied-security-report"

if [[ -n "${GIT_REMOTE_URL:-}" ]]; then
  URL="$GIT_REMOTE_URL"
elif [[ -n "${GITHUB_USERNAME:-}" ]]; then
  URL="https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
else
  echo "请设置环境变量之一："
  echo "  GITHUB_USERNAME=你的GitHub用户名"
  echo "或"
  echo "  GIT_REMOTE_URL=https://github.com/你的用户名/${REPO_NAME}.git"
  exit 1
fi

if git remote get-url origin &>/dev/null; then
  echo "已存在 origin，将更新为: $URL"
  git remote set-url origin "$URL"
else
  git remote add origin "$URL"
fi

git branch -M main
git push -u origin main
echo "完成。仓库: $URL"
