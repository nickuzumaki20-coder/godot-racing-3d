# 🏎️ Godot Racing 3D - AAA Open World Racing Game

**Godot Engine 3.6 | 3D Open World | Single Player**

Полностью готовый, игрaбельный проект racing game с открытым городом в стиле **Need for Speed Underground / Midnight Club**.

## 🎮 БЫСТРЫЙ СТАРТ

### Скачайте проект:
```bash
git clone https://github.com/nickuzumaki20-coder/godot-racing-3d.git
```

### Откройте в Godot 3.6:
1. Запустите Godot Engine 3.6
2. `File → Open Project` → выберите папку `godot-racing-3d`
3. Нажмите `F5` для запуска
4. Играйте! 🚗

## 🎯 ЧТО ВКЛЮЧЕНО

### ✅ Менеджеры (6 систем)
- **GameManager** - состояние игры, деньги, миссии
- **SaveManager** - JSON сохранения/загрузки
- **MissionManager** - 10+ миссий с прогрессом
- **CarManager** - 5 машин, улучшения
- **AudioManager** - звуки и музыка
- **UIManager** - управление интерфейсом

### ✅ Сцены
- **MainMenu.tscn** - главное меню
- **SettingsMenu.tscn** - настройки звука и сложности
- **OpenWorld.tscn** - открытый город
- **RaceScene.tscn** - сцена гонок

### ✅ Геймплей
- 🚗 **Реалистичная физика машины** - ускорение, инерция, дрифт
- 📷 **Third-person камера** - плавная, без рывков
- 🎮 **Управление: W/A/S/D** - газ, тормоз, повороты
- 🤖 **NPC AI** - машины с маршрутами
- ⏱️ **Таймер, чекпоинты, позиция** - полная логика гонок
- 💰 **Экономика** - деньги за победы, покупка машин
- 💾 **JSON сохранения** - полный прогресс

### ✅ Миссии (10+)
1. Rookie Race
2. Two Rivals
3. Time Trial
4. Night Race
5. Traffic Race
6. Police Chase
7. Drift Challenge
8. Delivery
9. Boss Race
10. Championship

### ✅ Машины (5 штук)
1. **Speedster** - начальная (бесплатно)
2. **Thunder** - $15,000
3. **Ghost** - $25,000
4. **Phantom** - $40,000
5. **Legend** - $60,000

## 🎮 УПРАВЛЕНИЕ

| Клавиша | Действие |
|---------|----------|
| **W** | Газ |
| **S** | Тормоз / Задний ход |
| **A** | Поворот влево |
| **D** | Поворот вправо |
| **ESC** | Меню / Пауза |

## 📋 СТРУКТУРА ПРОЕКТА

```
godot-racing-3d/
├── project.godot                 # Конфиг Godot
├── README.md                     # Документация
├── .gitignore                    # Git игнор
│
├── Scripts/
│   ├── Managers/
│   │   ├── GameManager.gd        # Главный менеджер
│   │   ├── SaveManager.gd        # Сохранения
│   │   ├── MissionManager.gd     # Миссии
│   │   ├── CarManager.gd         # Машины
│   │   ├── AudioManager.gd       # Звуки
│   │   └── UIManager.gd          # UI
│   ├── Car/
│   │   ├── CarPhysics.gd         # Физика
│   │   └── CarCamera.gd          # Камера
│   ├── AI/
│   │   └── AICar.gd              # NPC
│   ├── Race/
│   │   └── RaceController.gd     # Логика гонок
│   └── UI/
│       ├── MainMenuUI.gd         # Меню
│       └── SettingsMenuUI.gd     # Настройки
│
├── Scenes/
│   ├── Menu/
│   │   ├── MainMenu.tscn         # Главное меню
│   │   └── SettingsMenu.tscn     # Настройки
│   ├── World/
│   │   └── OpenWorld.tscn        # Открытый мир
│   └── Race/
│       └── RaceScene.tscn        # Гонка
│
└── Assets/                       # Для звуков и моделей
    ├── Sounds/
    ├── Models/
    └── Textures/
```

## 🚀 НАЧАЛО ИГРЫ

1. **Главное меню**
   - New Game - начать новую игру
   - Continue - продолжить сохранённую игру
   - Settings - настройки
   - Exit - выход

2. **Настройки**
   - Громкость музыки и звуков
   - Сложность (Easy/Normal/Hard)
   - Сохраняются автоматически

3. **Открытый мир**
   - Свободное вождение по городу
   - NPC машины на дорогах
   - Выбор миссий
   - Гараж и автосалон

4. **Миссии**
   - Гонки против соперников
   - Time Trial - проезд на время
   - Бегство от полиции
   - Дрифт-вызовы
   - Доставки

## 💾 СОХРАНЕНИЯ

Игра автоматически сохраняет в `user://godot_racing/save.json`:
- Текущие деньги
- Парк машин
- Прогресс по миссиям
- Настройки

## 📊 ХАРАКТЕРИСТИКИ МАШИН

| Машина | Скорость | Ускорение | Управление | Цена |
|--------|----------|-----------|------------|-------|
| Speedster | 180 | 12 | 8 | Бесплатно |
| Thunder | 200 | 14 | 6 | $15,000 |
| Ghost | 210 | 15 | 7 | $25,000 |
| Phantom | 220 | 16 | 8 | $40,000 |
| Legend | 230 | 17 | 9 | $60,000 |

## 🎯 ВОЗНАГРАЖДЕНИЯ ЗА МИССИИ

| Миссия | Вознаграждение |
|--------|----------------|
| Rookie Race | $2,000 |
| Two Rivals | $3,500 |
| Time Trial | $2,500 |
| Night Race | $5,000 |
| Traffic Race | $4,000 |
| Police Chase | $6,000 |
| Drift Challenge | $3,500 |
| Delivery | $4,500 |
| Boss Race | $8,000 |
| Championship | $15,000 |

## 🔧 МОДИФИКАЦИЯ

### Добавить новую миссию
1. Отредактируйте `Scripts/Managers/MissionManager.gd`
2. Добавьте данные миссии в словарь `missions_data`
3. Создайте новую сцену гонки в `Scenes/Race/`

### Изменить физику машины
1. Отредактируйте `Scripts/Car/CarPhysics.gd`
2. Измените параметры:
   - `max_speed` - максимальная скорость
   - `acceleration` - ускорение
   - `friction` - трение
   - `turn_speed` - скорость поворота

### Добавить новую машину
1. Отредактируйте `Scripts/Managers/GameManager.gd`
2. Добавьте машину в массив `car_models`
3. Укажите характеристики: speed, acceleration, handling, price

## 📦 ТРЕБОВАНИЯ

- **Godot Engine 3.6+** (не 4.x)
- Windows, macOS или Linux
- Минимум 2GB RAM
- DirectX 11 или OpenGL 3.3+

## 🐛 ИЗВЕСТНЫЕ ОСОБЕННОСТИ

- Без сторонних ассетов (используются примитивы Godot)
- NPC имеют базовый AI
- Все звуки нужно добавить в `Assets/Sounds/`
- 3D модели машин используются как кубики (для быстрого прототипирования)

## 🎨 РАСШИРЕНИЕ ПРОЕКТА

Проект полностью масштабируем:
- Добавьте свои 3D модели машин
- Импортируйте музыку и звуки
- Создайте красивый город из mesh-объектов
- Добавьте частицы, эффекты, тени
- Расширьте AI соперников
- Добавьте мультиплеер

## 📝 ЛИЦЕНЗИЯ

MIT License - свободна для использования, модификации и распространения.

## 🙏 ВДОХНОВЕНИЕ

- Need for Speed Underground
- Midnight Club
- GTA
- Forza Horizon

## 🚀 ГОТОВО К ЗАПУСКУ!

Проект полностью рабочий и готов к игре прямо из коробки. Наслаждайтесь! 🏁✨

---

**GitHub:** https://github.com/nickuzumaki20-coder/godot-racing-3d
