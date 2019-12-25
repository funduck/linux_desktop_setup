ps -aux | grep linuxsampler | grep -v grep | sed 's/oomilekh \s*\([0-9]*\)\s.*/\1/' | xargs -n 1 kill -9
