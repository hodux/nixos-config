function fish_prompt
    set -l last_status $status
    
    set -l separator ""
    set -l separator_round ""
    set -l branch_icon ""

    set -l os_bg magenta
    set -l os_fg black
    set -l dir_bg blue
    set -l dir_fg black
    set -l git_bg cyan
    set -l git_fg black
    set -l err_bg red
    set -l err_fg black

    set_color -b $dir_bg $current_bg
    set_color -b $dir_bg $dir_fg
    echo -n " "(prompt_pwd)" "
    set current_bg $dir_bg

    set -l git_branch (command git branch --show-current 2>/dev/null)
    if test -n "$git_branch"
        set_color -b $git_bg $current_bg
        echo -n $separator
        set_color -b $git_bg $git_fg
        echo -n " $branch_icon $git_branch "
        set current_bg $git_bg
    end

    if test $last_status -ne 0
        set_color -b $err_bg $current_bg
        echo -n $separator
        set_color -b $err_bg $err_fg
        echo -n " ✘ $last_status "
        set current_bg $err_bg
    end

    set_color normal
    set_color $current_bg
    echo -n $separator
    
    set_color normal
    echo -n " "
end
