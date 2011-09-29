#!zsh
#
# Installation
# ------------
#
# To achieve git-flow completion nirvana:
#
#  0. Update your zsh's git-completion module to the newest verion.
#     From here. http://zsh.git.sourceforge.net/git/gitweb.cgi?p=zsh/zsh;a=blob_plain;f=Completion/Unix/Command/_git;hb=HEAD
#
#  1. Install this file. Either:
#
#     a. Place it in your .zshrc:
#
#     b. Or, copy it somewhere (e.g. ~/.git-now-completion.zsh) and put the following line in
#        your .zshrc:
#
#            source ~/.git-now-completion.zsh
#

_git-now ()
{
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments -C \
    ':command:->command' \
    '*::options:->options'

  case $state in
    (command)

      local -a subcommands
      subcommands=(
      'add:default subcommand.'
      'rebase:rebase for temporary commits.'
      'grep:grep temporary commits.'
      )
      _describe -t commands 'git now' subcommands
      __git-now-add
      ;;

    (options)
      case $line[1] in

        (add)
          __git-now-add
          ;;

        (rebase)
          _arguments \
            '-m[limit git-now commits by your name]'\
            ':branch-name:__git_branch_names'
          ;;

        (grep)
          _arguments \
            '-p[generate diff in patch format]'\
            '-s[generate diffstat instead of patch]'\
            '-m[limit git-now commits by your name]'\
            ':branch-name:__git_branch_names'
          ;;
        (*)
          __git-now-add
          ;;
      esac
      ;;
  esac
}

__git-now-add ()
{
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments \
    '-n[do not actually add files; only show which ones would be added]'\
    '-v[show files as they are added]'\
    '-f[allow adding otherwise ignored files]'\
    '-i[add contents interactively to index]'\
    '-p[like -i but go directly into patch mode for specified files]'\
    '-e[open diff against index in editor]'\
    '-u[update only files git already knows about]'\
    '-N[record only that path will be added later]'\
    ':filepattern:_files'
}

__git_remotes () {
  local expl gitdir remotes

  gitdir=$(_call_program gitdir git rev-parse --git-dir 2>/dev/null)
  __git_command_successful || return

  remotes=(${${(f)"$(_call_program remotes git config --get-regexp '"^remote\..*\.url$"')"}//#(#b)remote.(*).url */$match[1]})
  __git_command_successful || return

  # TODO: Should combine the two instead of either or.
  if (( $#remotes > 0 )); then
    _wanted remotes expl remote compadd $* - $remotes
  else
    _wanted remotes expl remote _files $* - -W "($gitdir/remotes)" -g "$gitdir/remotes/*"
  fi
}

__git_branch_names () {
  local expl
  declare -a branch_names

  branch_names=(${${(f)"$(_call_program branchrefs git for-each-ref --format='"%(refname)"' refs/heads 2>/dev/null)"}#refs/heads/})
  __git_command_successful || return

  _wanted branch-names expl branch-name compadd $* - $branch_names
}

__git_command_successful () {
  if (( ${#pipestatus:#0} > 0 )); then
    _message 'not a git repository'
    return 1
  fi
  return 0
}

zstyle ':completion:*:*:git:*' user-commands now:'description for foo'
