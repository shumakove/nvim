#!/bin/bash

# Скрипт для очистки API ключей из Git истории

echo "🔧 Очистка Git истории от секретов"
echo "===================================="
echo ""

cd /Users/shumakove/.config/nvim

# Проверяем что мы в git репозитории
if [ ! -d .git ]; then
    echo "❌ Ошибка: не найден .git директория"
    exit 1
fi

echo "⚠️  ВНИМАНИЕ:"
echo "   Это удалит файлы из истории Git и перезапишет историю!"
echo "   Убедитесь что у вас нет несохраненных изменений."
echo ""
read -p "Продолжить? (y/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Отменено"
    exit 0
fi

echo ""
echo "🧹 Шаг 1: Удаляем файлы из Git истории..."
echo ""

# Удаляем проблемные файлы из истории
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch INSTALL_API_KEY.md setup_api_key.sh CURSOR_AI_GUIDE.md QUICKSTART_CURSOR.md AI_CHEATSHEET.md LAYOUT_SETTINGS.md OLLAMA_GUIDE.md setup_ollama.sh QUICKSTART_OLLAMA.md FILE_EXPLORER_GUIDE.md FIXED_DEPRECATION.md SWITCH_TO_CLAUDE.md" \
  --prune-empty --tag-name-filter cat -- --all

if [ $? -ne 0 ]; then
    echo "❌ Ошибка при очистке истории"
    exit 1
fi

echo ""
echo "✅ Файлы удалены из истории!"
echo ""

echo "🧹 Шаг 2: Очистка рефлогов и мусора..."
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo ""
echo "✅ История очищена локально!"
echo ""
echo "📤 Шаг 3: Теперь нужно запушить изменения:"
echo ""
echo "   git push origin main --force"
echo ""
echo "⚠️  После этого ОБЯЗАТЕЛЬНО:"
echo "   1. Зайдите на https://console.anthropic.com/settings/keys"
echo "   2. УДАЛИТЕ старый API ключ"
echo "   3. Создайте НОВЫЙ ключ"
echo "   4. Обновите в ~/.zshrc:"
echo "      export ANTHROPIC_API_KEY=\"новый-ключ\""
echo "      source ~/.zshrc"
echo ""

read -p "Запушить изменения сейчас? (y/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📤 Пушим изменения..."
    git push origin main --force
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Успешно запушено!"
        echo ""
        echo "🔑 ВАЖНО: Сейчас обновите API ключ!"
        echo "   1. https://console.anthropic.com/settings/keys"
        echo "   2. Удалите старый ключ"
        echo "   3. Создайте новый"
        echo "   4. Обновите ~/.zshrc"
    else
        echo ""
        echo "❌ Ошибка при push"
        echo "   Попробуйте вручную: git push origin main --force"
    fi
else
    echo ""
    echo "ℹ️  Push пропущен. Запустите позже:"
    echo "   git push origin main --force"
fi

echo ""
echo "✅ Готово!"

