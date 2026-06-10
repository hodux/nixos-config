function sesh
  if count $argv > /dev/null
    command sesh $argv
  else
    set -l session (command sesh list | fzf)
    if test -n "$session"
      command sesh connect $session
    end
  end
end
