#!/bin/bash



# newer rsync version
#rsync --bwlimit=50000 --append-verify drip:/home/deluge/ /Users/lol/Documents/deluge/

# rsync version < 3
rsync -rz --progress --exclude=.config --bwlimit=50000 --append shine:/home/deluge/ /Users/lol/Documents/deluge/
