set -gx PATH $PATH $HOME/.krew/bin
set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Direnv + Zoxide
    zoxide init fish | source
    eval (direnv hook fish)

    # aliases
    alias vim nvim
    alias v nvim
    alias zs sesh
    # pretty ls
    alias ls='eza --icons --group-directories-first'

    # Abbrs
    abbr k kubectl

end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/rintaro/.lmstudio/bin
# End of LM Studio CLI section

