# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

local cs_ok='23a563e80249a866c7cba3ac44eaedb1ca38f20c35690fb764a7cb75e95d38be'
local cs_get=$(sha256sum <(curl -sL init.zshell.dev) | awk '{print $1}')
[[ $cs_ok == $cs_get ]] && { source <(curl -sL init.zshell.dev); zzinit; } || {
  print -P "%F{160}▓▒░ Houston, we have a problem, the %F{226}$cs_get%F{160} do not match\!%f%b"; return 1
}
unset cs_ok cs_get

# Plugins
zi snippet OMZP::brew
zi snippet OMZP::fzf
zi snippet OMZP::git
zi snippet OMZP::golang
zi snippet OMZP::kubectl
zi snippet OMZP::poetry
zi snippet OMZP::tldr
zi snippet OMZP::tmux
zi snippet OMZP::terraform
zi snippet https://github.com/zsh-users/zsh-autosuggestions/blob/master/zsh-autosuggestions.zsh
#zi snippet OMZP::zsh-syntax-highlighting
zi snippet https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/zsh-syntax-highlighting.zsh

# Custom aliases
alias tree='tree -a -I .git'

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Custom aliases
alias rg="rg -i"
alias vim="nvim"
alias gitlab='source /usr/local/bin/get-gitlab-token.sh'
alias glb='cd ~/gitlab'
alias jenkins='cd ~/gitlab/jenkins'
#alias bkp='(){cp "$1"\{,.bkp\}}'

#alias ssm='(){aws ssm start-session --target "$1" ;}'

alias tfps='terraform plan -no-color | grep -E "(^.*[#~+-] .*|^[[:punct:]]|Plan)"'

alias ls='eza --color=always --git --icons=always'
alias l='ls -lars modified'
alias cat='bat -pp'
alias v=vim
alias c=clear

alias awsp='/usr/local/bin/idpcli.sh prod && export AWS_PROFILE=prod'
alias awsi='/usr/local/bin/idpcli.sh int && export AWS_PROFILE=int'
alias awsd='/usr/local/bin/idpcli.sh dev && export AWS_PROFILE=dev'
alias awsl='/usr/local/bin/idpcli.sh logging && export AWS_PROFILE=logging'
alias awsss='/usr/local/bin/idpcli.sh sharedSecurity && export AWS_PROFILE=sharedSecurity'
alias awssn='/usr/local/bin/idpcli.sh sharedNetwork && export AWS_PROFILE=sharedNetwork'
alias awspriv='export AWS_PROFILE=private'
alias instances='(){/usr/local/bin/awscli_cheatsheet.sh ec2 describe-instances "$1" ;}'

alias awscreds='(){. /Users/snigaly/gitlab/my-setup/scripts/set_aws_creds.sh "$1" "$2" ;}'

alias vaultp='export VAULT_ADDR=https://hcvault.app.corpintra.net && export VAULT_NAMESPACE=shinyjenkins'
alias vaulti='export VAULT_ADDR=https://vault-int.app.corpintra.net && export VAULT_NAMESPACE=shinyjenkins'
alias vaultd='export VAULT_ADDR=https://vault-int.app.corpintra.net && export VAULT_NAMESPACE=shinyjenkins-dev'
alias vtp='(){vaultp && export VAULT_TOKEN="$1" ;}'
alias vti='(){vaulti && export VAULT_TOKEN="$1" ;}'
alias vtd='(){vaultd && export VAULT_TOKEN="$1" ;}'alias ssm='(){aws ssm start-session --target "$1" --document-name param --parameters linuxcmd="echo $(base64 -i ~/gitlab/my-setup/config/bashrc_for_ssm) | base64 -d > /home/ssm-user/.bashrc; bash" ;}'

# Hishtory Config:
export PATH="$PATH:/Users/snigaly/.hishtory"
source /Users/snigaly/.hishtory/config.zsh

# thefuck
eval $(thefuck --alias)

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Use zoxide instad of the cd command
eval "$(zoxide init --cmd cd zsh)"

# fzf variables
export FZF_BASE=/opt/homebrew/bin/fzf
export FZF_DEFAULT_COMMAND='fd' # fd or rg
DISABLE_FZF_AUTO_COMPLETION="true"
DISABLE_FZF_KEY_BINDINGS="true"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zi ice depth=1; zi light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Load zsh completion system
autoload -Uz compinit && compinit

# This tells zsh that small letters will match small and capital letters. 
# (i.e. capital letters match only capital letters.)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
## If you want that capital letters also match small letters use instead:
## zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

## If you want case-insensitive matching only if there are no case-sensitive matches add '', e.g.
## zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/snigaly/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
