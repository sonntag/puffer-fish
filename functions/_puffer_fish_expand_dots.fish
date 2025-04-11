function _puffer_fish_expand_dots -d 'expand ... to ../.. etc'
    set -l cmd (commandline --cut-at-cursor)
    set -l split (string split -- ' ' $cmd)
    set -l lastword $split[-1]

    if string match --quiet --regex -- '^(\.)$' $lastword
        commandline --insert './'
    else if string match --quiet --regex -- '^(\.\./)+$' $lastword
        commandline --insert '../'
    else
        commandline --insert '.'
    end
end
