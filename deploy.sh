#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

push_addr="https://github.com/chenhuizhu-0930/VuePress-Blog.git" # git提交地址，也可以手动设置，比如：push_addr=git@github.com:xugaoyi/vuepress-theme-vdoing.git
commit_info=`git describe --all --always --long`
dist_path=docs/.vuepress/dist # 打包生成的文件夹路径
push_branch=main # 推送的分支

# 0. 提交 Markdown 源文件变更（显示上次更新时间用）
git add docs/
git commit -m "更新文档内容 $(date '+%Y-%m-%d %H:%M:%S')" || echo "无文档变更，无需提交"
echo "✅ Markdown 文件提交完毕"

# 生成静态文件 windows的话这里用build:win
npm run build:win 
echo "✅ 构建完成，生成新 dist"

# 进入生成的文件夹
cd "$dist_path"

git init
git add -A
git commit -m "deploy, $测试上次更新时间"
git push -f $push_addr HEAD:$push_branch
echo "✅ 推送完成！dist 已部署到 $push_branch 分支"

cd -
rm -rf $dist_path
echo "✅ 清理 dist 完毕，部署流程全部完成 🎉"