#!/bin/bash
# Отключение Roblox-режима

ZAPRET_PATH="/opt/zapret"
HOSTLIST="$ZAPRET_PATH/ipset/zapret-hosts-user.txt"
DEFAULT_HOSTS="$ZAPRET_PATH/ipset/zapret-hosts-default.txt"

echo "🛑 Отключаем Roblox-режим..."

# Останови ZAPRET
sudo systemctl stop zapret

# Восстанови стандартный хостлист (если есть)
if [ -f "$DEFAULT_HOSTS" ]; then
    sudo cp "$DEFAULT_HOSTS" "$HOSTLIST"
    echo "✅ Восстановлен стандартный хостлист"
else
    echo "⚠️ Стандартный хостлист не найден, очищаем"
    sudo rm -f "$HOSTLIST"
fi

# Запусти ZAPRET
sudo systemctl start zapret

sleep 3
if sudo systemctl is-active --quiet zapret; then
    echo "✅ Стандартный режим активен!"
else
    echo "❌ ZAPRET не запустился"
    echo "🔍 Логи: sudo journalctl -u zapret -n 10"
    echo "🔧 Попробуй: sudo systemctl restart zapret"
fi
