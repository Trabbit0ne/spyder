#!/bin/bash

# Clear the screen
clear

# Variables
username=""
choice=""

# Set color code shortcuts
red="\e[1;31m"    # Red text code
green="\e[32m"    # Green text code
yellow="\e[33m"   # Yellow text code
blue="\e[34m"     # Blue text code
purple="\e[35m"   # Purple text code
cyan="\e[36m"     # Cyan txt code
bgred="\e[41m"    # Red background color code
bggreen="\e[42m"  # Green background color code
bgyellow="\e[43m" # Yellow background color code
bgblue="\e[44m"   # Blue background color code
bgpurple="\e[45m" # Purple background color code
bgcyan="\e[46m"   # Cyan background color code
clean="\e[0m"     # Cleared color (empty)

# Functions
check_platform() {
  local platform=$1
  local url

  case $platform in
    "twitter")
      result=$(python3 checkers/xcheck.py "$username")
      if [ "$result" == "True" ]; then
        echo -e "[\e[32m+\e[0m] Username '\e[32m$username\e[0m' ~> \e[32m$platform\e[0m [\e[32m√\e[0m]"
      else
        echo -e "[\e[31m-\e[0m] Username '\e[31m$username\e[0m' ~> \e[31m$platform\e[0m [\e[31mx\e[0m]"
      fi
      return
      ;;
    "instagram")
      result=$(python3 checkers/instacheck.py "$username")
      if [ "$result" == "True" ]; then
        echo -e "[\e[32m+\e[0m] Username '\e[32m$username\e[0m' ~> \e[32m$platform\e[0m [\e[32m√\e[0m]"
      else
        echo -e "[\e[31m-\e[0m] Username '\e[31m$username\e[0m' ~> \e[31m$platform\e[0m [\e[31mx\e[0m]"
      fi
      return
      ;;
    "facebook") url="https://m.facebook.com/$username";;
    "github") url="https://github.com/$username";;
    "linkedin") url="https://www.linkedin.com/in/$username";;
    "tiktok") url="https://www.tiktok.com/@$username";;
    "snapchat") url="https://www.snapchat.com/add/$username";;
    "reddit") url="https://www.reddit.com/user/$username/";;
    "youtube") url="https://www.youtube.com/@$username";;
    *)
      echo "[-] Unknown platform: $platform"
      return;;
  esac

  response=$(curl -s -o /dev/null -L -w "%{http_code}" "$url")

  if [ "$response" -eq 200 ]; then
    echo -e "[\e[32m+\e[0m] Username '\e[32m$username\e[0m' ~> \e[32m$platform\e[0m [\e[32m√\e[0m]"
  elif [ "$response" -eq 404 ] || [ "$response" -eq 301 ]; then
    echo -e "[\e[31m-\e[0m] Username '\e[31m$username\e[0m' ~> \e[31m$platform\e[0m [\e[31mx\e[0m] $response"
  else
    echo -e "[\e[35m!\e[0m] Unable to determine validity on \e[35m$platform\e[0m [\e[35m!\e[0m]"
  fi
}

check_nsfw_platform() {
  local platform_nsfw=$1
  local url

  case $platform_nsfw in
    "pornhub") url="https://www.pornhub.com/users/$username";;
    "xnxx") url="https://www.xnxx.com/$username";;
    "xvideos") url="https://www.xvideos.com/$username";;
    *)
      echo "[-] Unknown platform: $platform_nsfw"
      return;;
  esac

  response=$(curl -s -o /dev/null -w "%{http_code}" "$url")

  if [ "$response" -eq 200 ]; then
    echo -e "[\e[32m+\e[0m] Username '\e[32m$username\e[0m' ~> \e[32m$platform_nsfw\e[0m [\e[32m√\e[0m]"
  elif [ "$response" -eq 404 ]; then
    echo -e "[\e[31m-\e[0m] Username '\e[31m$username\e[0m' ~> \e[31m$platform_nsfw\e[0m [\e[31mx\e[0m]"
  else
    echo -e "[\e[35m!\e[0m] Unable to determine validity on \e[35m$platform_nsfw\e[0m ~> $response [\e[35m!\e[0m]"
  fi
}

# Get Options/Arguments Used
while getopts ":u:s:" opt; do
  case $opt in
    u)
      username=$OPTARG
      ;;
    s)
      choice=$OPTARG
      ;;
    *)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Banner
echo
echo -e "${blue}                                  =**=              :***.                                 "
echo "                                =@@@-                .#@@*.                               "
echo "                              =%@@+                    :#@@+.                             "
echo "               -            =@@@*.                       =@@@*.           ..              "
echo "              .@:          %@@%-                          .*@@@:          #=              "
echo "               %%         :@@@         -*%@@+ @@%#=:        *@@*         =@.              "
echo "               -@*        +@@*      -#@@@@@@+ @@@@@@%+      -@@%        :@#               "
echo "                %@-       #@@-     :#@@@@@@@+ @@@@@@@%+      @@@:      .@@:              "
echo "                =@@.     .@@@.   .#*=:::=*%@+ @%#+-::-+#+    #@@+      #@#                "
echo "                 @@#     =@@%    %@@@@@@#+: . . =*%@@@@@@:   =@@@     =@@-                "
echo -e "                 =@@=    %@@+    +@@@@@@%-\e[31m.== *-.${blue}*@@@@@@#:   :@@@:   .@@%                 "
echo -e "                  %@@:   %@@*   :=.-#@*::\e[31m*@@+ @@%=${blue}.=%@+.-+   :@@@-   %@@-                 "
echo -e "                  =@@@=  .%@@*   @@*  .\e[31m#@@@@- #@@@@=${blue}  -%@+  -@@@=  .#@@%                  "
echo -e "                   =@@@#. .%@@#. =+.-*:.\e[31m+%=.. ::*%-.=+${blue}.-*  +@@@-  +@@@*.                  "
echo -e "                    .#@@@+  %@@%. .%@@@#  \e[31m=%+ @#: ${blue}-@@@@+  +@@@- -%@@@-                    "
echo -e "                      -@@@%: #@@@  .*%=.\e[31m=@@@+ @@@#${blue}::*%- :*@@@- *@@@+                      "
echo -e "        .:=+=-::.       **::+:+@@@@*. \e[31m:%@@@@+ @@@@@*${blue}  -%@@@#-+-.=#:       .:-=+=-.        "
echo -e "           .-+%@@%#+-.    .-+*+:-*@@@*:.\e[31m+@@@+ @@@#-${blue}.=%@@%=:=*+=:     :=*%@@@*=:           "
echo -e "               .=*@@@@@#+--::..    -*%@%=.\e[31m=%+ @*:${blue}.*@@#=.   ...::-=*%@@@@#+:               "
echo "                   .=*%@@@@@@@@@@@@%+-::--  . . .-:::=*@@@@@@@@@@@@@#+:                   "
echo "                       .=++***##%%@@@@@@#- .: - .+%@@@@@@%%##**++=:                       "
echo -e "                           ..:-=+*#%%#=\e[.-*%@+ @@#=::+%%#*+=--:.                           "
echo -e "                     +*#%%@@@@@@@@@*.\e[38;5;92m-#@@@@@+ @@@@@%+${blue} -#@@@@@@@@@%#*+:                    "
echo -e "                    +@@@%%#**+==-: \e[38;5;92m:#@@@#@@@+ @@@@%@@@+${blue} .--=++*##%@@@%                    "
echo -e "                   .@@@-         \e[38;5;92m:#@@@+.+@@@+ @@@#.-%@@@+${blue}          @@@=                   "
echo -e "                   #@@#        \e[38;5;92m*@@@*. *=.-*= #=.*- =%@@%=${blue}          =@@@.                  "
echo -e "                  -@@@:      \e[38;5;92m.*@@@*:  =@@@%+. -*@@@@.  =%@@%${blue}        #@@#                  "
echo -e "                  %@@+       \e[38;5;92m@@@%:    -*@@@@+ @@@@%+.    +@@@=${blue}      .@@@-                 "
echo -e "                 *@@%        \e[38;5;92m#@@+    .+=.-*@+ @#+::+-    .@@@:${blue}       +@@@.                "
echo -e "                 *@@%.       \e[38;5;92m+@@#     .%@#= . ..+@@+     -@@@${blue}        *@@@:                "
echo -e "                  +@@%.      \e[38;5;92m-@@@      .@%:     +@+      +@@*${blue}       +@@#.                 "
echo -e "                   -@@%      \e[38;5;92m.@@@:      .        :       %@@=${blue}      =@@*                   "
echo -e "                    :@@*      \e[38;5;92m%@@=                       @@@.${blue}     -@@+${blue}                    "
echo -e "                     .%@=     \e[38;5;92m+@@#                      :@@%${blue}     .@@-                     "
echo -e "                       *@-    \e[38;5;92m-@@@.                     *@@*${blue}     %%:                      "
echo -e "                        +@:    \e[38;5;92m*@@@.                   +@@%:${blue}    #%.                       "
echo -e "                         -%     \e[38;5;92m.*@@:                 *@%-${blue}     **                         "
echo -e "                          .+      \e[38;5;92m.+%.               *#-${blue}      --                          "
echo -e "                            .       \e[38;5;92m.=.             =:${blue}        .                           "
echo -e "                                                                                          "
echo
echo -e "                                   ${yellow}DEVELOPPED BY ${green}TRABBIT${clean}                                 "

echo
echo -e "${yellow}[+]${clean} ${green}Author: ${clean} ${blue}@Trabbit0ne ${clean}"
echo -e "${yellow}[+]${clean} ${green}Github: ${clean} ${blue}github.com/Trabbit0ne ${clean}"
echo

if [ -z "$username" ] || [ -z "$choice" ]; then
  echo "Usage: $0 -u <username> -s <social|nsfw>"
  exit 1
fi

if [ "$choice" == "social" ]; then
  echo -e "[${cyan}~${clean}] Searching social media platforms for username: ${purple}$username${clean}"
  platforms=("twitter" "instagram" "facebook" "github" "linkedin" "tiktok" "snapchat" "reddit" "youtube")
  for platform in "${platforms[@]}"; do
    check_platform "$platform"
  done
elif [ "$choice" == "nsfw" ]; then
  echo -e "[${cyan}~${clean}] Searching NSFW platforms for username: ${purple}$username${clean}"
  nsfw_platforms=("pornhub" "xnxx" "xvideos")
  for platform_nsfw in "${nsfw_platforms[@]}"; do
    check_nsfw_platform "$platform_nsfw"
  done
else
  echo "Invalid choice: $choice. Use 'social' or 'nsfw'."
  exit 1
fi
