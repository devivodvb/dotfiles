# General
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias flushdns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias reloaddns="flushdns"
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias updatedb="sudo /usr/libexec/locate.updatedb"
# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; mas upgrade; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'
alias swagger-editor="docker run -d -p 37658:8080 swaggerapi/swagger-editor && echo Running on http://127.0.0.1:37658"

# Files and directories
alias c="clear"
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
sizes () { du -hsc * | sort -h }
alias s='sizes'
countfiles() { ls -al | wc -l }
alias cf='countfiles'
# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias sites="cd $HOME/Sites"

# Laravel
alias a="php artisan"
alias ams="php artisan migrate:fresh --seed"

# PHP
alias pst='phpstan analyse --level=max'
setphp() { echo "$1" > "$HOME/.php_version" && source "$HOME/.zshrc" }
alias gphp='ps aux | grep php'

# Vagrant
alias v="vagrant global-status"
alias vup="vagrant up"
alias vhalt="vagrant halt"
alias vssh="vagrant ssh"
alias vreload="vagrant reload"
alias vrebuild="vagrant destroy --force && vagrant up"

# Docker
alias dc="docker-compose"
dstop() { docker stop $(docker ps -a -q) }
dpurgecontainers() { dstop && docker rm $(docker ps -a -q) }
dpurgeimages() { docker rmi $(docker images -q) }
drma() {
    echo "docker ps -a | tail -n+2 | awk '{print \$1}' | xargs docker rm -f ; docker volume ls | tail -n+2 | awk '{print \$2}' | xargs docker volume rm ; docker network ls | tail -n+2 | awk '{print \$2}' | xargs docker network rm" | pbcopy
}
alias dps="docker ps"

# Git
alias commit="git add . && git commit -m"
alias gcommit="git add . && git commit"
alias wip="commit wip"
alias igst="git status"
alias igs="git status"
alias igb="git branch"
alias igc="git checkout"
alias igd="git diff"
alias igpa="git pull; git submodule foreach git pull origin master"
igpush() { git push origin $(git rev-parse --abbrev-ref HEAD) }
igpull() { git pull origin $(git rev-parse --abbrev-ref HEAD) }
alias igp="git pull; git submodule foreach git pull origin master"
alias igt="git tag -l --sort=-v:refname"
alias igfa="git fetch --all -p"
alias ignuke="git clean -df && git reset --hard"
alias igdiff="git diff"
alias igpdevelop="git pull origin develop"
alias igpmaster="git pull origin master"
alias igcdevelop="git checkout develop"
alias igcontrib="git shortlog --summary --numbered"
alias igl="git log --color --decorate --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an (%G?)>%Creset' --abbrev-commit"
alias igh="git log --graph --color --pretty=format:\"%C(yellow)%H%C(green)%d%C(reset)%n%x20%cd%n%x20%cn%x20(%ce)%n%x20%s%n\""
alias igwip="git add . && git commit -m 'wip'"

# Composer
alias ci="composer install"
alias cu="composer update"
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# GPG
gpgencrypt() {
    gpg --encrypt --output $1.gpg --recipient idvbeek@gmail.com --sign $1
    if [ $? -eq 0 ]; then
        echo "File encrypted, deleting now: $1"
        rm $1
    fi
}

# Retrieves a public key from a private key
get-public-key() {
    ssh-keygen -y -f $1
}

# AWS
aws-get-public-key() {
    echo "$1"
    openssl rsa -in "$1" -pubout
}

aws-get-public-key-signature() {
    echo "$1"
    openssl pkcs8 -in "$1" -inform PEM -outform DER -topk8 -nocrypt | openssl sha1 -c
}

# Miscellaneous
fix-and-erase-usb-disk() {
    diskutil eraseDisk free EMPTY $1
}

weather() { curl -4 wttr.in/${1:-amsterdam} }

extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# networking
alias myip='curl ifconfig.io'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs
httpheaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page
httpdebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup}\n connect: %{time_connect}\n pretransfer: %{time_pretransfer}\n starttransfer: %{time_starttransfer}\n total: %{time_total}\n" ; }

ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;myip
    # echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}

# Sample files
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)
