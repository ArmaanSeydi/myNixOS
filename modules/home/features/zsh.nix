{ ... }: {
  flake.homeModules.zsh = { ... }: {
    programs.zsh = {
      enable = true;

      autosuggestion.enable  = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;

      history = {
        size       = 10000;
        save       = 10000;
        ignoreDups = true;
        share      = true;
      };

      initContent = ''
        # ── Prompt ────────────────────────────────────────────────────────────
        _git_branch() {
          local branch
          branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
          echo " ($branch)"
        }

        setopt PROMPT_SUBST
        NEWLINE=$'\n'
        PROMPT='$NEWLINE%F{4}%1~%f%F{9}$(_git_branch)%f %F{7}%(!.#.$)%f '

        # ── ls after cd ───────────────────────────────────────────────────────
        chpwd() { ls --color=auto }
      '';
    };
  };
}
