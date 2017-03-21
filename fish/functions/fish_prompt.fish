function fish_prompt

  function _git_branch_name
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end

  function _is_git_dirty
    echo (git status -s --ignore-submodules=dirty ^/dev/null)
  end

  set -l c0 (set_color -o 009eff)
  set -l c1 (set_color -o ff8a00)
  set -l c2 (set_color -o red)
  set -l c3 (set_color -o 6dc7ff)
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l blue (set_color -o 0066aa)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  set -l cwd $c0(prompt_pwd)
  set -l cwd "$cwd"

  if [ (_git_branch_name) ]
    set -l git_branch $c1(_git_branch_name)
    set git_info "$git_branch"

    if [ (_is_git_dirty) ]
      set git_info " $c2❰$git_info $c1✗$c2❱"
    else 
      set git_info " $c2❰$git_info $green✔$c2❱"
    end
  end

  echo -n -s $cwd $git_info $normal "$blue➤ "
end
