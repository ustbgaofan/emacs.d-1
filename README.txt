File: README.txt  -*- Encoding: utf-8 -*-
Time-stamp: <luanma 02/08/2010 21:33:31>

git user
========

mkdir -p ~/projects && cd ~/projects
git clone git://github.com/mrluanma/emacs.d.git
cd emacs.d/
git submodule init && git submodule update
cp -r .emacs* ~/

cd ~/.emacs.d/
find . -name '*.el' | xargs emacs -batch -f batch-byte-compile
