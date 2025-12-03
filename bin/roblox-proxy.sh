#!/bin/bash
# Roblox ZAPRET (с сохранением стандартного режима)

ZAPRET_PATH="/opt/zapret"
HOSTLIST="$ZAPRET_PATH/ipset/zapret-hosts-user.txt"
DEFAULT_HOSTS="$ZAPRET_PATH/ipset/zapret-hosts-default.txt"

echo "🎮 Включаем Roblox-режим..."

# Сохрани текущий хостлист как стандартный (если не сохранён)
if [! -f "$DEFAULT_HOSTS" ] && [ -f "$HOSTLIST" ]; then
    sudo cp "$HOSTLIST" "$DEFAULT_HOSTS"
    echo "✅ Стандартный хостлист сохранён: $DEFAULT_HOSTS"
fi

# Создай Roblox хостлист
sudo tee "$HOSTLIST" > /dev/null << 'HOSTS'
roblox.com
www.roblox.com
api.roblox.com
clientsettings.roblox.com
setup.roblox.com
auth.roblox.com
users.roblox.com
groups.roblox.com
thumbnails.roblox.com
avatar.roblox.com
chat.roblox.com
economy.roblox.com
catalog.roblox.com
marketplace.roblox.com
*.rblx.com
*.rblxcdn.com
*.robloxusercontent.com
ws*.roblox.com
wss*.roblox.com
HOSTS

echo "✅ Roblox хостлист создан"

# Перезапусти ZAPRET
sudo systemctl restart zapret

sleep 3
if sudo systemctl is-active --quiet zapret; then
    echo "✅ Roblox-режим активен!"
    echo "🎮 Открой Sober"
else
    echo "❌ Ошибка запуска"
fi
