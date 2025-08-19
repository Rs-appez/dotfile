#!/bin/sh
touch "${HOME}/.config/hypr/configs/${HOSTNAME}-idle.conf"
ln -s "${HOME}/.config/hypr/configs/${HOSTNAME}-idle.conf" "${HOME}/.config/hypr/configs/customs/idle.conf" &> /dev/null

touch "${HOME}/.config/hypr/configs/${HOSTNAME}-monitor.conf"
ln -s "${HOME}/.config/hypr/configs/${HOSTNAME}-monitor.conf" "${HOME}/.config/hypr/configs/customs/monitor.conf" &> /dev/null

touch "${HOME}/.config/hypr/configs/${HOSTNAME}-autostart.conf"
ln -s "${HOME}/.config/hypr/configs/${HOSTNAME}-autostart.conf" "${HOME}/.config/hypr/configs/customs/autostart.conf" &> /dev/null

touch "${HOME}/.config/hypr/configs/${HOSTNAME}-workspace.conf"
ln -s "${HOME}/.config/hypr/configs/${HOSTNAME}-workspace.conf" "${HOME}/.config/hypr/configs/customs/workspace.conf" &> /dev/null

touch "${HOME}/.config/hypr/configs/${HOSTNAME}-windowrule.conf"
ln -s "${HOME}/.config/hypr/configs/${HOSTNAME}-windowrule.conf" "${HOME}/.config/hypr/configs/customs/windowrule.conf" &> /dev/null

touch "${HOME}/.config/hypr/configs/${HOSTNAME}-binding.conf"
ln -s "${HOME}/.config/hypr/configs/${HOSTNAME}-binding.conf" "${HOME}/.config/hypr/configs/customs/binding.conf" &> /dev/null

touch "${HOME}/.config/hypr/configs/${HOSTNAME}-switch_workspace.conf"
ln -s "${HOME}/.config/hypr/configs/${HOSTNAME}-switch_workspace.conf" "${HOME}/.config/hypr/configs/customs/switch_workspace.conf" &> /dev/null

touch "${HOME}/.config/hypr/configs/${HOSTNAME}-plugin.conf"
ln -s "${HOME}/.config/hypr/configs/${HOSTNAME}-plugin.conf" "${HOME}/.config/hypr/configs/customs/plugin.conf" &> /dev/null
