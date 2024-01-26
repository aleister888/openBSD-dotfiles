#!/bin/sh
option0="240p 24fps"
option1="480p 24fps"
option2="720p 24fps"
option3="1080p 24fps"
option4="240p 30fps"
option5="480p 30fps"
option6="720p 30fps"
option7="1080p 30fps"
option8="240p 60fps"
option9="480p 60fps"
option10="720p 60fps"
option11="1080p 60fps"
options="$option0\n$option1\n$option2\n$option3\n$option4\n$option5
$option6\n$option7\n$option8\n$option9\n$option10\n$option11"
chosen="$(echo "$options" | dmenu -l 13 -p "Resolution:")"
# this overrides any previos mpv configuration
case $chosen in
$option0) echo "ytdl-format=bestvideo[height<=240][fps<=?24][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option1) echo "ytdl-format=bestvideo[height<=480][fps<=?24][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option2) echo "ytdl-format=bestvideo[height<=720][fps<=?24][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option3) echo "ytdl-format=bestvideo[height<=1080][fps<=?24][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option4) echo "ytdl-format=bestvideo[height<=240][fps<=?30][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option5) echo "ytdl-format=bestvideo[height<=480][fps<=?30][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option6) echo "ytdl-format=bestvideo[height<=720][fps<=?30][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option7) echo "ytdl-format=bestvideo[height<=1080][fps<=?30][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option8) echo "ytdl-format=bestvideo[height<=240][fps<=?60][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option9) echo "ytdl-format=bestvideo[height<=480][fps<=?60][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option10) echo "ytdl-format=bestvideo[height<=720][fps<=?60][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
$option11) echo "ytdl-format=bestvideo[height<=1080][fps<=?60][vcodec!=?vp9]+bestaudio/best" > $HOME/.config/mpv/mpv.conf && mpv $(xclip -sel clip -o) >/dev/null 2>&1;;
esac
