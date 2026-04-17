
####################
# ALIASES
####################

# MacOS
alias cpwd="pwd | tr -d '\n' | pbcopy && echo 'Current working directory copied to clipboard.'"
alias flushdns="sudo killall -HUP mDNSResponder"
alias dskill="find . -name '*.DS_Store' -type f -delete"
alias dockspacer="defaults write com.apple.dock persistent-apps -array-add '{tile-type=\"spacer-tile\"}' && killall Dock"

# Homebrew
alias brewup="brew update && brew upgrade && brew cleanup"

# PHP
alias pu="herd php ./vendor/bin/phpunit"
alias pest="herd php ./vendor/bin/pest"

alias cr="COMPOSER_MEMORY_LIMIT=-1 herd composer require"
alias ci="COMPOSER_MEMORY_LIMIT=-1 herd composer install"
alias cu="COMPOSER_MEMORY_LIMIT=-1 herd composer update"
alias cgu="COMPOSER_MEMORY_LIMIT=-1 herd composer global update"
alias cda="herd composer dump-autoload"
alias hp="herd php"

# Laravel/Artisan
alias a="herd php artisan"
alias pint="herd php ./vendor/bin/pint"
alias aoc="herd php artisan optimize:clear"
alias avp="herd php artisan vendor:publish"
alias mfs="herd php artisan migrate:fresh --seed"

# NPM
alias nrw="npm run watch"
alias nrd="npm run dev"
alias nrp="npm run prod"
alias nrb="npm run build"
alias nrh="npm run hot"
alias npmclear="rm -rf node_modules && rm package-lock.json && npm cache clear --force"

# Git
alias gnew="git init && gaa && gcmsg"
alias gt="gittower"
alias nah="git reset --hard && git clean -df"

# Traversal
alias db="cd ~/Dropbox"
alias si="cd ~/Sites"
alias co="cd ~/Code"
