#!/bin/bash

# Clear the screen
clear

# Variables
username=""
target=""

# Set color code shortcuts
red="\e[31m"    # Red text code
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
    "x" | "twitter") url="https://x.com/$username";;
    "instagram") url="https://www.instagram.com/$username";;
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

  response=$(curl -s -L -o /dev/null -w "%{http_code}" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36" "$url")

  if [ "$response" -eq 200 ]; then
    echo -e "[\e[32m+\e[0m] Username '\e[32m$username\e[0m' ~> \e[32m$platform\e[0m [\e[32m√\e[0m]"
  elif [ "$response" -eq 404 ]; then
    echo -e "[${red}-\e[0m] Username '${red}$username\e[0m' ~> ${red}$platform\e[0m [${red}x\e[0m]"
  elif [ "$response" -eq 301 ] || [ "$response" -eq 302 ]; then
    echo -e "[\e[33m?\e[0m] Redirected for \e[33m$username\e[0m on \e[33m$platform\e[0m [\e[33m!\e[0m]"
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

  response=$(curl -s -L -o /dev/null -w "%{http_code}" -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36" "$url")

  if [ "$response" -eq 200 ]; then
    echo -e "[\e[32m+\e[0m] Username '\e[32m$username\e[0m' ~> \e[32m$platform_nsfw\e[0m [\e[32m√\e[0m]"
  elif [ "$response" -eq 404 ]; then
    echo -e "[${red}-\e[0m] Username '${red}$username\e[0m' ~> ${red}$platform_nsfw\e[0m [${red}x\e[0m]"
  else
    echo -e "[\e[35m!\e[0m] Unable to determine validity on \e[35m$platform_nsfw\e[0m [\e[35m!\e[0m]"
  fi
}

# Get Options/Arguments Used
if [[ -z "$target" ]]; then
    target="ALL"
fi
while getopts ":u:t:" opt; do
  case $opt in
    u)
      username=$OPTARG
      ;;
    t)
      target=$OPTARG
      ;;
    *)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Banner
echo -e "\e[34m                                  =**=              :***.                                 "
echo "                                =@@@-                .#@@*.                               "
echo "                              =%@@+                    :#@@+.                             "
echo "               -            =@@@*.                       =@@@*.           ..              "
echo "              .@:          %@@%-                          .*@@@:          #=              "
echo "               %%         :@@@         -*%@@+ @@%#=:        *@@*         =@.              "
echo "               -@*        +@@*      -#@@@@@@+ @@@@@@%+      -@@%        :@#               "
echo "                %@-       #@@-     :#@@@@@@@+ @@@@@@@%+      @@@:      .@@:              "
echo "                =@@.     .@@@.   .#*=:::=*%@+ @%#+-::-+#+    #@@+      #@#                "
echo "                 @@#     =@@%    %@@@@@@#+: . . =*%@@@@@@:   =@@@     =@@-                "
echo -e "                 =@@=    %@@+    +@@@@@@%-${red}.== *-.\e[34m*@@@@@@#:   :@@@:   .@@%                 "
echo -e "                  %@@:   %@@*   :=.-#@*::${red}*@@+ @@%=\e[34m.=%@+.-+   :@@@-   %@@-                 "
echo -e "                  =@@@=  .%@@*   @@*  .${red}#@@@@- #@@@@=\e[34m  -%@+  -@@@=  .#@@%                  "
echo -e "                   =@@@#. .%@@#. =+.-*:.${red}+%=.. ::*%-.=+\e[34m.-*  +@@@-  +@@@*.                  "
echo -e "                    .#@@@+  %@@%. .%@@@#  ${red}=%+ @#: \e[34m-@@@@+  +@@@- -%@@@-                    "
echo -e "                      -@@@%: #@@@  .*%=.${red}=@@@+ @@@#\e[34m::*%- :*@@@- *@@@+                      "
echo -e "        .:=+=-::.       **::+:+@@@@*. ${red}:%@@@@+ @@@@@*\e[34m  -%@@@#-+-.=#:       .:-=+=-.        "
echo -e "           .-+%@@%#+-.    .-+*+:-*@@@*:.${red}+@@@+ @@@#-\e[34m.=%@@%=:=*+=:     :=*%@@@*=:           "
echo -e "               .=*@@@@@#+--::..    -*%@%=.${red}=%+ @*:\e[34m.*@@#=.   ...::-=*%@@@@#+:               "
echo "                   .=*%@@@@@@@@@@@@%+-::--  . . .-:::=*@@@@@@@@@@@@@#+:                   "
echo "                       .=++***##%%@@@@@@#- .: - .+%@@@@@@%%##**++=:                       "
echo -e "                           ..:-=+*#%%#=\e[.-*%@+ @@#=::+%%#*+=--:.                           "
echo -e "                     +*#%%@@@@@@@@@*.\e[38;5;92m-#@@@@@+ @@@@@%+\e[34m -#@@@@@@@@@%#*+:                    "
echo -e "                    +@@@%%#**+==-: \e[38;5;92m:#@@@#@@@+ @@@@%@@@+\e[34m .--=++*##%@@@%                    "
echo -e "                   .@@@-         \e[38;5;92m:#@@@+.+@@@+ @@@#.-%@@@+\e[34m          @@@=                   "
echo -e "                   #@@#        \e[38;5;92m*@@@*. *=.-*= #=.*- =%@@%=\e[34m          =@@@.                  "
echo -e "                  -@@@:      \e[38;5;92m.*@@@*:  =@@@%+. -*@@@@.  =%@@%\e[34m        #@@#                  "
echo -e "                  %@@+       \e[38;5;92m@@@%:    -*@@@@+ @@@@%+.    +@@@=\e[34m      .@@@-                 "
echo -e "                 *@@%        \e[38;5;92m#@@+    .+=.-*@+ @#+::+-    .@@@:\e[34m       +@@@.                "
echo -e "                 *@@%.       \e[38;5;92m+@@#     .%@#= . ..+@@+     -@@@\e[34m        *@@@:                "
echo -e "                  +@@%.      \e[38;5;92m-@@@      .@%:     +@+      +@@*\e[34m       +@@#.                 "
echo -e "                   -@@%      \e[38;5;92m.@@@:      .        :       %@@=\e[34m      =@@*                   "
echo -e "                    :@@*      \e[38;5;92m%@@=                       @@@.\e[34m     -@@+\e[34m                    "
echo -e "                     .%@=     \e[38;5;92m+@@#                      :@@%\e[34m     .@@-                     "
echo -e "                       *@-    \e[38;5;92m-@@@.                     *@@*\e[34m     %%:                      "
echo -e "                        +@:    \e[38;5;92m*@@@.                   +@@%:\e[34m    #%.                       "
echo -e "                         -%     \e[38;5;92m.*@@:                 *@%-\e[34m     **                         "
echo -e "                          .+      \e[38;5;92m.+%.               *#-\e[34m      --                          "
echo -e "                            .       \e[38;5;92m.=.             =:\e[34m        .                           "
echo -e "                                                                                          "
echo
echo -e "                                   \e[33mDEVELOPPED BY \e[32mTRABBIT\e[0m                                 "
echo
echo -e "{+}======================================================={+}"
echo -e "    Username: ${yellow}$username${clean}"
echo -e "    Target(s): ${yellow}$target${clean}"
echo -e "{+}======================================================={+}"
echo

# Ensure username and target are provided
if [ -z "$username" ] || [ -z "$target" ]; then
  echo -e "${red}[-] Username and service target are required. Please provide both.\e[0m"
  exit 1
fi

# Check the chosen services
case $target in
  "all" | "ALL")
    platforms=("twitter" "instagram" "facebook" "github" "linkedin" "tiktok" "snapchat" "reddit" "youtube")
    for platform in "${platforms[@]}"; do
      check_platform "$platform"
    done
    ;;
  "x" | "twitter" | "instagram" | "facebook" | "github" | "linkedin" | "tiktok" | "snapchat" | "reddit" | "youtube")
    check_platform "$target"
    ;;
  "nsfw")
    nsfw_platforms=("pornhub" "xnxx" "xvideos")
    for platform_nsfw in "${nsfw_platforms[@]}"; do
      check_nsfw_platform "$platform_nsfw"
    done
    ;;
  *)
    echo -e "${red}[-] Invalid service target. Use 'all', a specific platform name, or 'nsfw'.\e[0m"
    exit 1
    ;;
esac
