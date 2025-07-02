#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

push_addr="https://github.com/chenhuizhu-0930/VuePress-Blog.git" # git提交地址，也可以手动设置，比如：push_addr=git@github.com:xugaoyi/vuepress-theme-vdoing.git
commit_info=`git describe --all --always --long`
dist_path=docs/.vuepress/dist # 打包生成的文件夹路径
src_branch=main # 源分支
site_branch=gh-pages # 推送的分支

# 推送源码到main
git add . # 把修改放入暂存区（staging area）

# 提交 Markdown 源文件变更（显示上次更新时间用）
git commit -m "deploy 源码推送end $(date '+%Y-%m-%d %H:%M:%S')" || echo "没有文档变更，无需提交" # 提交到本地仓库
echo "✅ Markdown 文件提交完毕"

# 推送到远程仓库
git push -f origin $src_branch
echo "✅ 源码已推送到 $src_branch"

# 生成静态文件 windows的话这里用build:win
npm run build:win 
echo "✅ 构建完成，生成新 dist"

# 进入生成的文件夹
cd "$dist_path"

git init
git checkout -b gh-pages
git add -A
git commit -m "更新右上角github地址&移除draft $(date '+%Y-%m-%d %H:%M:%S')"
git push -f $push_addr HEAD:$site_branch
echo "✅ 推送完成！dist 已部署到 $site_branch 分支"

cd -
rm -rf $dist_path
echo "✅ 清理 dist 完毕，部署流程全部完成 🎉"