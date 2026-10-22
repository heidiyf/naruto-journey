#!/bin/bash
set -euo pipefail

# Only run inside a local clone of the intended website repository.
# Uses existing Git credentials; no passwords or access tokens are stored here.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
finish() {
  printf '\n按回车关闭此窗口。'
  read -r _reply || true
}
trap finish EXIT
fail() { printf '\n%s\n' "$1" >&2; exit 1; }

command -v git >/dev/null 2>&1 || fail '未找到 Git。请先安装并登录 GitHub Desktop。'
repo_root="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null || true)"
[[ "$repo_root" == "$SCRIPT_DIR" ]] || fail '请先用 GitHub Desktop 克隆 heidiyf/naruto-journey，再把新版文件和本脚本放到克隆文件夹根目录。下载包本身不是 Git 仓库。'
remote_url="$(git -C "$SCRIPT_DIR" remote get-url origin 2>/dev/null || true)"
case "$remote_url" in
  https://github.com/heidiyf/naruto-journey|https://github.com/heidiyf/naruto-journey.git|git@github.com:heidiyf/naruto-journey.git|ssh://git@github.com/heidiyf/naruto-journey.git) ;;
  *) fail '仓库地址不是 heidiyf/naruto-journey，已停止，未上传。' ;;
esac
[[ "$(git -C "$SCRIPT_DIR" branch --show-current)" == main ]] || fail '请在 GitHub Desktop 切换到 main 分支后再运行。'
git -C "$SCRIPT_DIR" diff --cached --quiet || fail '已有暂存的修改。请先在 GitHub Desktop 完成或取消暂存，再使用本脚本。'

printf '检查 GitHub 最新版本…\n'
git -C "$SCRIPT_DIR" fetch origin main || fail '无法连接或登录 GitHub。请在 GitHub Desktop 登录，并确认有此仓库的写入权限。'
git -C "$SCRIPT_DIR" merge-base --is-ancestor origin/main HEAD || fail 'GitHub 上有尚未合入的修改。请先在 GitHub Desktop 使用 Fetch origin / Pull origin，再重试。脚本不会覆盖远端历史。'

paths=()
for path in index.html app.js styles.css data-snapshot.js data images README.md .nojekyll 更新步骤.md GitHub同步设置.md 同步到GitHub.command; do
  if [[ -e "$SCRIPT_DIR/$path" ]]; then paths+=("$path"); fi
done
git -C "$SCRIPT_DIR" add -- "${paths[@]}"
if ! git -C "$SCRIPT_DIR" diff --cached --quiet; then
  git -C "$SCRIPT_DIR" commit -m 'Update Naruto Journey website and CSV data' || fail '提交失败，请在 GitHub Desktop 检查作者信息和文件状态。'
fi
git -C "$SCRIPT_DIR" push origin main || fail '上传失败。请在 GitHub Desktop 检查登录状态、远端更新和分支权限；不要使用强制推送。'
printf '\n已同步到 GitHub。请等待 Pages 发布成功，再刷新：\nhttps://heidiyf.github.io/naruto-journey/\n'
