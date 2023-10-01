#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Module Name>"
    exit 1
fi

MODULE_NAME=$1

# Переходим в директорию, где лежит Rambafile и шаблоны Generamba
cd "../Addons/Genaramba" || exit

# Запускаем генерацию модуля с помощью Generamba
generamba gen "$MODULE_NAME" swifty_viper --module_path "../../PokemonAppSources/PokemonApp/UILayer/Modules"
