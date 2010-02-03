File: README.txt  -*- Encoding: utf-8 -*-
Time-stamp: <luanma 02/03/2010 23:19:48>

git user
========

$ mkdir -p ~/projects && cd ~/projects
$ git clone git@github.com:mrluanma/emacs.d.git
$ git submodule init && git submodule update
$ cd emacs.d
$ cp -r .emacs* ~/

$ cd ~/.emacs.d/
$ find . -name '*.el' | xargs emacs -batch -f batch-byte-compile
