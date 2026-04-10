# GitHub 配置指南

## 1. 创建 GitHub 仓库

### 在 GitHub.com 上操作：
1. 登录 https://github.com
2. 点击右上角 **+** → **New repository**
3. 填写信息：
   - **Repository name**: `trek-pioneer` 或 `peakpal`
   - **Description**: 徒步先锋队 - 每一步，都算数
   - **Visibility**: Private (私有) 或 Public (公开)
   - **不要勾选** "Initialize this repository with a README"
4. 点击 **Create repository**

---

## 2. 配置本地 Git

### 方式 A: HTTPS (推荐新手)

```bash
# 在服务器上执行
cd /home/admin/openclaw/workspace/app

# 设置 Git 用户信息 (首次使用需要)
git config --global user.name "你的 GitHub 用户名"
git config --global user.email "你的 GitHub 邮箱"

# 添加远程仓库 (替换为你的仓库地址)
git remote add origin https://github.com/你的用户名/trek-pioneer.git

# 推送代码
git push -u origin master
```

### 方式 B: SSH (推荐长期使用)

```bash
# 1. 生成 SSH Key (如果已有可跳过)
ssh-keygen -t ed25519 -C "你的 GitHub 邮箱"

# 2. 查看公钥
cat ~/.ssh/id_ed25519.pub

# 3. 复制公钥内容，添加到 GitHub:
# Settings → SSH and GPG keys → New SSH key

# 4. 测试连接
ssh -T git@github.com

# 5. 添加远程仓库
git remote add origin git@github.com:你的用户名/trek-pioneer.git

# 6. 推送代码
git push -u origin master
```

---

## 3. 本地 Mac 获取代码

### 方式 A: 克隆仓库

```bash
# 在你的 Mac 上
cd ~/Projects  # 或你常用的代码目录
git clone https://github.com/你的用户名/trek-pioneer.git
# 或 SSH: git clone git@github.com:你的用户名/trek-pioneer.git

cd trek-pioneer

# 安装依赖
flutter pub get

# 运行
flutter run

# 构建 APK
flutter build apk --release
```

### 方式 B: 直接下载 ZIP

1. 打开仓库页面
2. 点击绿色 **Code** 按钮
3. 选择 **Download ZIP**
4. 解压后运行 `flutter pub get`

---

## 4. 后续更新流程

### 服务器端推送更新

```bash
cd /home/admin/openclaw/workspace/app

# 修改代码后
git add -A
git commit -m "描述你的修改"
git push
```

### 本地 Mac 获取更新

```bash
cd ~/Projects/trek-pioneer
git pull
flutter pub get
flutter build apk --release
```

---

## 5. 推荐工具

### Git 客户端 (可选)
- **GitHub Desktop** (Mac/Windows) - 图形化操作
- **SourceTree** - 免费 Git GUI
- **VS Code Git 插件** - 编辑器集成

### 命令行快捷方式

```bash
# 添加 Git 别名 (~/.zshrc 或 ~/.bashrc)
alias gp='git push'
alias gl='git pull'
alias gs='git status'
alias gc='git commit -m'
alias ga='git add -A'

# 使用
ga  # git add -A
gc "修改说明"  # git commit -m "修改说明"
gp  # git push
```

---

## 6. 常见问题

### Q: 推送时提示权限错误？
A: 检查 SSH key 是否已添加到 GitHub，或改用 HTTPS 方式。

### Q: 如何查看提交历史？
A: `git log --oneline`

### Q: 如何回退到之前的版本？
A: `git checkout <commit-hash>` 或 `git revert <commit-hash>`

### Q: 如何创建新版本标签？
A: `git tag v2.0 && git push origin v2.0`

---

## 7. 下一步

1. ✅ 在 GitHub 创建仓库
2. ✅ 配置 SSH 或 HTTPS
3. ✅ 推送代码到 GitHub
4. ✅ 在 Mac 上克隆仓库
5. ✅ 本地构建 APK (v4)
6. ✅ 安装体验

---

**需要帮助？** 随时告诉我遇到的问题！
