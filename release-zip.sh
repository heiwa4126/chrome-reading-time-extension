#!/bin/bash
set -e
pnpm build
RELEASE_DIR=release
PACKAGE_NAME=chrome-reading-time-extension
# manifest.jsonからバージョン番号を取得（fxコマンド使用）
VERSION=$(fx '.version' manifest.json)
ZIP_NAME=$PACKAGE_NAME-$VERSION.zip
rm -rf "$RELEASE_DIR"
mkdir -p "$RELEASE_DIR/$PACKAGE_NAME"
# 必要ファイルをパッケージ名ディレクトリにコピー
cp -r dist "$RELEASE_DIR/$PACKAGE_NAME/"
cp -r public "$RELEASE_DIR/$PACKAGE_NAME/"
cp manifest.json "$RELEASE_DIR/$PACKAGE_NAME/"
# READMEや他の必要ファイルがあればここで追加

cd "$RELEASE_DIR"
zip -r "../$ZIP_NAME" "$PACKAGE_NAME"
cd ..
echo "Release ZIP created at $ZIP_NAME"
