# 把网站文件同步到 GitHub

这次已生成一键脚本，但尚未连接并测试你本机的 Git 登录。它不是“每次保存立即上传”，而是双击后完成提交和上传。

## 第一次设置

1. 打开你电脑上已有的 **GitHub Desktop**，登录 `heidiyf`。
2. 点击菜单 **File → Clone Repository… → URL**。
3. Repository URL 填：

   ```text
   https://github.com/heidiyf/naruto-journey.git
   ```

4. Local Path 选择一个专门保存仓库的位置，例如：

   ```text
   /Users/heidiwang/Documents/ChatGPT/火影忍者/github/naruto-journey
   ```

5. 点击 **Clone**。这是从你自己的 GitHub 仓库下载当前版本，不是新建仓库。
6. 用 **Repository → Show in Finder** 打开克隆文件夹。
7. 把本次界面更新包中的 `index.html`、`app.js`、`styles.css`、`README.md`、`更新步骤.md`、`GitHub同步设置.md`、`同步到GitHub.command` 放进克隆文件夹根目录并替换同名文件。
8. 保留你已有的 `data` 文件夹与 `data-snapshot.js`。这次只是改界面，不需要覆盖 CSV。
9. 如果克隆版本只有旧的单个 HTML，还没有 `data` 文件夹，则改用完整网站包；将其中网站文件放到同一个克隆文件夹。
10. 在 GitHub Desktop 的 Changes 页面查看修改，填写 Summary，例如 `Update website layout`，点击 **Commit to main**，然后 **Push origin**。第一次建议这样操作，确认账号有权限且仓库连接正确。

官方克隆步骤：https://docs.github.com/en/desktop/adding-and-cloning-repositories/cloning-and-forking-repositories-from-github-desktop

## 以后更新

以后只修改上面这个**克隆文件夹**中的网站文件和 CSV。其他下载文件夹里的修改，不会自动进入仓库。

修改完成后，任选一种方式：

- **GitHub Desktop**：查看 Changes，填写 Summary，点击 **Commit to main**，再点 **Push origin**。
- **一键脚本**：在克隆文件夹中双击 `同步到GitHub.command`。

脚本只暂存网站文件、CSV、`images` 文件夹及相关说明；检查目标仓库必须是 `heidiyf/naruto-journey`，并且分支必须为 `main`。如果远端有新修改或已有其他暂存文件，会停止并说明原因，不会强制覆盖远端。

脚本使用本机命令行 Git 的凭据。GitHub Desktop 已登录不一定代表命令行凭据也已配置；如果脚本提示认证失败，可以继续使用 Desktop 的 Commit / Push origin，不影响网站。

官方推送步骤：https://docs.github.com/en/desktop/making-changes-in-a-branch/pushing-changes-to-github-from-github-desktop

## 网站什么时候更新？

成功 Push 后，GitHub Pages 会按你已经配置的 main 分支自动发布。到仓库 Actions 查看部署结果，然后刷新原网址：

https://heidiyf.github.io/naruto-journey/

仅修改文件、仅保存 CSV、仅导入网页预览，都不会上传到 GitHub。

## 这次已做与未做

- 已修改本地网站界面、生成更新包和脚本。
- 脚本语法检查已通过；尚未在已登录的真实克隆仓库中执行上传。
- 本次没有在电脑上新建克隆、改 Git 凭据，也没有向线上仓库写入。
- 先前 GitHub 连接的写入请求返回 403；这不是仓库改成 Public 就能解决的。GitHub Desktop 使用的是你本机自己的登录。
