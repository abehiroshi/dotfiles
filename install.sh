#!/bin/sh

pushd $(cd $(dirname $0); pwd)

for f in .??*; do
  [ "$f" = ".git" ] && continue
  ln -snfv ~/dotfiles/"$f" ~/
done

popd
