{ ... }:
let
  capL = "";
  capR = "";
in
{
  flake.homeModules.tmux = { ... }: {
    programs.tmux = {
      enable        = true;
      baseIndex     = 1;
      escapeTime    = 0;
      historyLimit  = 10000;
      keyMode       = "vi";
      mouse         = true;
      sensibleOnTop = false;
      terminal      = "tmux-256color";

      extraConfig = ''
        # ── True color ────────────────────────────────────────────────────────
        set -ag terminal-overrides ",xterm-256color:RGB"

        # ── Refresh & titles ──────────────────────────────────────────────────
        set -g status-interval 5
        set -g set-titles on
        set -g set-titles-string "#W"

        # ── Pane numbering ────────────────────────────────────────────────────
        set -g pane-base-index 1
        set -g renumber-windows on

        # ── Status bar ────────────────────────────────────────────────────────
        set -g status on
        set -g status-position bottom
        set -g status-justify left
        set -g status-style          "bg=default"
        set -g status-left-length    60
        set -g status-left           "#[fg=colour8,bg=#E5E9F0,bold] 󱄅 #S #[fg=#E5E9F0,bg=colour8]${capR}#[fg=colour7,bg=colour8,nobold] #(whoami) #[fg=colour8,bg=default]${capR} "
        set -g status-right-length   80
        set -g status-right          " #[fg=colour7,bg=default]  %H:%M #[fg=colour8,bg=default]${capL}#[fg=colour7,bg=colour8]  %d %b #[fg=#E5E9F0,bg=colour8]${capL}#[fg=colour0,bg=#E5E9F0] 󰒋 #H #[bg=default]"

        # ── Windows ───────────────────────────────────────────────────────────
        set -g window-status-separator      "  "
        set -g window-status-format         "#[fg=colour8,bg=default]${capL}#[fg=colour7,bg=colour8] #I  #W #[fg=colour8,bg=default]${capR}"
        set -g window-status-current-format "#[fg=colour4,bg=default]${capL}#[fg=colour0,bg=colour4,bold] #I  #W #[fg=colour4,bg=default]${capR}"

        # ── Pane borders ──────────────────────────────────────────────────────
        set -g pane-border-lines        heavy
        set -g pane-border-style        "fg=colour8"
        set -g pane-active-border-style "fg=colour8"

        # ── Messages ──────────────────────────────────────────────────────────
        set -g message-style         "fg=colour3,bg=colour0,bold"
        set -g message-command-style "fg=colour4,bg=colour0"

        # ── Mode (copy-mode etc.) ─────────────────────────────────────────────
        set -g mode-style "fg=colour0,bg=colour4"

        # ── Keybindings ───────────────────────────────────────────────────────
        bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded"
      '';
    };
  };
}
