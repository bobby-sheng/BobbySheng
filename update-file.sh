#!/bin/bash

set -e

rsync -avzc --progress --delete --chmod=Du=rwx,Dg=rx,Do=rx,Fu=rw,Fg=r,Fo=r /mnt/c/Users/Bobby/OneDrive/1-Bobby/obsidian/Bobby/blog/* content/posts/

hugo server -D
