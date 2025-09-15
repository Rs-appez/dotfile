gclone() {
  local repos
  repos=$(gh repo list "${1:-Rs-appez}" --limit 20 | fzf --multi | awk '{print $1}')
  if [[ -z "$repos" ]]; then
    echo "No repository selected."
    return 1
  fi
  echo "$repos" | xargs -n 1 gh repo clone
}
