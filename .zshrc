# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/jordan/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


_zsh_terminal_set_256color() {
      if [[ "$TERM" =~ "-256color$" ]] ; then
              [[ -n "${ZSH_256COLOR_DEBUG}" ]] && echo "zsh-256color: 256 color terminal already set." >&2
                  return
                    fi

                    local TERM256="${TERM}-256color"

                    Use (n-)curses binaries, if installed.
                    if [[ -x "$( which toe )" ]] ; then
                        if toe -a | egrep -q "^$TERM256" ; then
                            _zsh_256color_debug "Found $TERM256 from (n-)curses binaries."
                            export TERM="$TERM256"
                            return
                        fi
                    fi

                    # Search through termcap descriptions, if binaries are not installed.
                    for termcaps in $TERMCAP "$HOME/.termcap" "/etc/termcap" "/etc/termcap.small" ; do
                        if [[ -e "$termcaps" ]] && egrep -q "(^$TERM256|\|$TERM256)\|" "$termcaps" ; then
                            _zsh_256color_debug "Found $TERM256 from $termcaps."
                            export TERM="$TERM256"
                            return
                        fi
                    done

                    # Search through terminfo descriptions, if binaries are not installed.
                    for terminfos in $TERMINFO "$HOME/.terminfo" "/etc/terminfo" "/lib/terminfo" "/usr/share/terminfo" ; do
                        if [[ -e "$terminfos"/$TERM[1]/"$TERM256" || \
                            -e "$terminfos"/"$TERM256" ]] ; then
                        _zsh_256color_debug "Found $TERM256 from $terminfos."
                        export TERM="$TERM256"
                        return
                    fi
                done
            }

            _colorize(){
                _zsh_terminal_set_256color
                unset -f _zsh_terminal_set_256color
            }

            _is_svn(){
                if [[ $(svn info 2>/dev/null) != "" ]]; then echo 1 ; else echo 0 ; fi
            }

            _svn_branch() {
                ref=$(svn info 2>/dev/null | grep Revision | awk '{print $2}') || return false;
                echo " SVN: @${ref} ";
                return true;
            }

            _is_git(){
                if [[ $(git branch 2>/dev/null) != "" ]]; then echo 1 ; else echo 0 ; fi
            }

            _git_branch() {
                ref=$(git symbolic-ref HEAD 2> /dev/null) || \
                    ref=$(git rev-parse --short HEAD 2> /dev/null) || return false;
                echo " GIT:  ${ref#refs/heads/} ";
                return true;
            }

            _is_hg(){
                if [[ $(hg branch 2>/dev/null) != "" ]]; then echo 1 ; else echo 0 ; fi
            }

            _hg_branch() {
                ref=$(hg branch 2> /dev/null) || return true;
                echo " HG:  ${ref} ";
                return true;
            }

            _vcs_info(){
                if [[ $(_is_git) == 1 ]]; then
                    _git_branch;
                elif [[ $(_is_hg) == 1 ]]; then
                    _hg_branch;
                elif [[ $(_is_svn) == 1 ]]; then
                    _svn_branch;
                else
                    echo " ";
                fi
            }

            __storage_info(){
                fs=`df -h . | tail -1 | awk '{print $1}' | sed "s|\.|•|g" `;
                size=`df -h . | tail -1 | awk '{print $2}' | sed "s|\.|•|g" `;
                used=`df -h . | tail -1 | awk '{print $3}' | sed "s|\.|•|g" `;
                usedp=`df -h . | tail -1 | awk '{print $5}' | sed "s|\.|•|g" `;
                free=`df -h . | tail -1 | awk '{print $4}' | sed "s|\.|•|g" `;
                echo "💾 $fs - F:$free U:$used T:$size";
            }

            __ssh_client(){
                if [ -n "$SSH_CLIENT" ]; then
                    echo $SSH_CLIENT | awk {'print $1 " "'};
                fi
            }

            alien0(){
                    color0=018    # time bg
                    color1=018    # init bg
                    color1r=196   # init bg error
                    color2=254    # time fg
                    color3=026    # user bg
                    color4=254    # user fg
                    color5=045    # dir bg
                    color6=019    # dir fg
                    color7=238    # vcs bg
                    color8=228    # prompt fg
                    color9=051    # vcs fg

                RPROMPT=''
                _user=`whoami`
                setopt promptsubst
                PROMPT='%(?.%f%k.%K{$color0}%F{$color1r}%f%k)%K{$color0}%F{$color2}%f%k%K{$color3}%F{$color0}%f%k%K{$color3}%F{$color4} $_user %f%k%K{$color5}%F{$color3}%f%k%K{$color5}%F{$color6} %3~ %f%k%F{$color5}%K{$color7}%k%f%K{$color7}%F{$color9}`_vcs_info`%f%k%F{$color7}%f'
                
                #%F{$color3}$(__ssh_client)%f%F{$color8}%B❱%b%f '
            }

            alien_prompts(){
                alien0
            }

            _colorize()
            autoload -U add-zsh-hook
            alien_prompts


