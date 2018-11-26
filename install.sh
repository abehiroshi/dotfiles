#!/bin/sh

DIR="$(cd $(dirname $0); pwd)"
pushd $DIR

for f in .??*; do
  [ "$f" = ".git" ] && continue
  ln -snfv "$DIR/$f" ~/
done

popd
