function sesh
  if test (count $argv) -eq 0
    set -l session (command sesh list | fzf)
    if test -n "$session"
      if not tmux has-session -t "$session" 2>/dev/null
        command sesh connect --command "nvim" "$session"
      else
        command sesh connect "$session"
      end
    end
  else if contains $argv[1] list connect clone root help preview window last mkdir
    command sesh $argv
  else
    set -l match (command sesh list | grep -i $argv[1] | head -n 1)
    
    if test -n "$match"
      if not tmux has-session -t "$match" 2>/dev/null
        command sesh connect --command "nvim" "$match"
      else
        command sesh connect "$match"
      end
    else
      if not tmux has-session -t "$argv[1]" 2>/dev/null
        command sesh connect --command "nvim" "$argv[1]"
      else
        command sesh connect $argv
      end
    end
  end
end
