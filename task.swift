// Описать несколько структур – любой легковой автомобиль и любой грузовик.
// Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника
// Описать несколько структур – любой легковой автомобиль и любой грузовик. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника
// Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема
// Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия
// Инициализировать несколько экземпляров структур. Применить к ним различные действия. Положить объекты структур в словарь как ключи, а их названия как строки например var dict = [structCar: 'structCar']

struct Car {
    var brand: String
    var year: Int
    var trunkVolume: Double 
    var engineRunning: Bool
    var windowsOpen: Bool
    var filledTrunkVolume: Double 
}

// Определим структуру для грузовика
struct Truck {
    var brand: String
    var year: Int
    var cargoVolume: Double 
    var engineRunning: Bool
    var windowsOpen: Bool
    var loadedCargoVolume: Double 
}

enum CarAction {
    case startEngine
    case stopEngine
    case openWindows
    case closeWindows
    case loadCargo(volume: Double)
    case unloadCargo(volume: Double)
}

extension Car {
    mutating func performAction(_ action: CarAction) {
        switch action {
            case .startEngine:
                engineRunning = true
            case .stopEngine:
                engineRunning = false
            case .openWindows:
                windowsOpen = true
            case .closeWindows:
                windowsOpen = false
            case .loadCargo(let volume):
                filledTrunkVolume += volume
            case .unloadCargo(let volume):
                filledTrunkVolume -= volume
        }
    }
}

extension Truck {
    mutating func performAction(_ action: CarAction) {
        switch action {
            case .startEngine:
                engineRunning = true
            case .stopEngine:
                engineRunning = false
            case .openWindows:
                windowsOpen = true
            case .closeWindows:
                windowsOpen = false
            case .loadCargo(let volume):
                loadedCargoVolume += volume
            case .unloadCargo(let volume):
                loadedCargoVolume -= volume
        }
    }
}

var myCar = Car(brand: "Toyota", year: 2022, trunkVolume: 400, engineRunning: true, windowsOpen: false, filledTrunkVolume: 0)
var myTruck = Truck(brand: "Volkswagen", year: 2010, cargoVolume: 2400, engineRunning: false, windowsOpen: true, loadedCargoVolume: 0)

myCar.performAction(.stopEngine)
myCar.performAction(.openWindows)
myCar.performAction(.loadCargo(volume: 100))

myTruck.performAction(.startEngine)
myTruck.performAction(.loadCargo(volume: 1500))
myTruck.performAction(.unloadCargo(volume: 300))

var carDictionary: [String: Car] = ["myCar": myCar]
var truckDictionary: [String: Truck] = ["myTruck": myTruck]

print("Марка моего автомобиля: \(myCar.brand)")
print("Запущен ли двигатель: \(myCar.engineRunning)")
print("Загруженный объем багажника: \(myCar.filledTrunkVolume) литров")

print("Марка моего грузовика: \(myTruck.brand)")
print("Запущен ли двигатель: \(myTruck.engineRunning)")
print("Загруженный объем кузова: \(myTruck.loadedCargoVolume) кубических метров")

// Набрать код который на скриншоте понять в чем там проблема и решить эту проблему
print("Проблема в связана с циклической зависимостью между объектами Car и Man. Чтобы решить эту проблему, можно использовать слабые ссылки для предотвращения циклической зависимости")
print("Результат")
class Car {
    weak var driver: Man? // Используем слабую ссылку
    deinit {
        print("машина удалена из памяти")
    }
}

class Man {
    weak var myCar: Car? // Используем слабую ссылку
    deinit {
        print("мужчина удален из памяти")
    }
}

var car: Car? = Car()
var man: Man? = Man()

car?.driver = man
man?.myCar = car

car = nil
man = nil

// Задание с мужчиной и паспортом
class Man {
    var pasport: Passport? // Используем опциональную ссылку

    deinit {
        print("мужчина удален из памяти")
    }
}

class Passport {
    let man: Man // Используем константу

    init(man: Man) {
        self.man = man
    }

    deinit {
        print("паспорт удален из памяти")
    }
}

var man: Man? = Man()
var passport: Passport? = Passport(man: man!)
man?.pasport = passport
passport = nil // объект удален
man = nil // удалены оба объекта
