#!/bin/bash

# Директория, в которой будут искаться архивы
ARCHIVE_DIR="./file"
# Директория, куда будут извлечены файлы
EXTRACT_DIR="./files"
# Куда сохранаяем файлы
ARCHIVE_PATH="Client.zip"

# Удалить все содержимое папки
rm -rf ./$EXTRACT_DIR/*
echo "Удаления старого клиента завершено!"

# Создаем директорию для извлечения, если она не существует
mkdir -p "$EXTRACT_DIR"

# Извлечение ZIP-архивов
find "$ARCHIVE_DIR" -name "*.zip" | while read -r archive; do
    echo "Извлечение $archive..."
    # Получаем относительный путь к архиву, убирая префикс ARCHIVE_DIR
    relative_path="${archive#$ARCHIVE_DIR/}"
    # Создаем соответствующую директорию для извлечения
    mkdir -p "$EXTRACT_DIR/$(dirname "$relative_path")"
    # Извлекаем архив в соответствующую директорию
    unzip -o "$archive" -d "$EXTRACT_DIR/$(dirname "$relative_path")"
done
echo "Извлечение завершено!"

#Удаляем клиент
rm ./%ARCHIVE_PATH
echo "Старая версия клиента удалена!"

# Архивируем
zip -r "$ARCHIVE_PATH" "$EXTRACT_DIR"

echo "Новый клиент собран!"
