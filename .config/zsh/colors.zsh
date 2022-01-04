if [ -f $HOME/.cache/wal/sequences ]; then
	(cat ~/.cache/wal/sequences &)
else
	wal --theme sexy-material &
fi
