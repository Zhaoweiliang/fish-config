alias ll="lsd -lh"
alias la="lsd -lha"

fzf_configure_bindings --directory=\ct --processes=\ck

function fzf-open-widget
    set -l preview_script '
set -l p {}
if test -d "$p"
    if type -q lsd
        lsd -lh --color=always "$p" | head -n 20
    else
        ls -lh "$p" | head -n 20
    end
else if test -f "$p"
    if file --mime "$p" | grep -q text
        if type -q bat
            bat --style=numbers --color=always --line-range :500 "$p" 2>/dev/null
        else
            head -n 200 "$p"
        end
    else
        file "$p"
    end
else
    echo "$p"
end
'
    set file (fzf --layout=reverse --preview "$preview_script" --preview-window=right:60%:wrap)

    if test -n "$file"
        if test -d "$file"
            cd "$file"; commandline -f repaint
        else if test -f "$file"
            open "$file"
        end
    end
end
bind \co fzf-open-widget






