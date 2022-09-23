if [[ -f "$HOME/.cache/wal/sequences" ]]; then
	cat "$HOME/.cache/wal/sequences"
else
  [[ -x $(which wal) ]] && wal --theme 'sexy-material' || echo "command 'wal' is unreachable"
fi
