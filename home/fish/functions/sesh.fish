function sesh
  if test (count $argv) -eq 0
    set -l session (command sesh list | fzf)
    if test -n "$session"
      command sesh connect "$session"
    end
  else if contains $argv[1] list connect clone root help preview window last mkdir
    command sesh $argv
  else
    set -l match (command sesh list | grep -i $argv[1] | head -n 1)
    
    if test -n "$match"
      command sesh connect "$match"
    else
      command sesh connect $argv
    end
  end
end
