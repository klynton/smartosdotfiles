# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

FTPMODE=auto
MAIL=/usr/mail/${LOGNAME:?}
MANPATH=/opt/local/gcc47/man:/opt/local/java/sun6/man:/opt/local/lib/perl5/man:/opt/local/lib/perl5/vendor_perl/man:/opt/local/man:/usr/share/man
PAGER=less
PATH=/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin

export FTPMODE MAIL MANPATH PAGER PATH

# hook man with groff properly
if [ -x /opt/local/bin/groff ]; then
  alias man='TROFF="groff -T ascii" TCAT="cat" PAGER="less -is" /usr/bin/man -T -mandoc'
fi

# help ncurses programs determine terminal size
export COLUMNS LINES

HOSTNAME=`/usr/bin/hostname`
HISTSIZE=1000

