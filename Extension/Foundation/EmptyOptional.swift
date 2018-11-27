//
//  EmptyOptional.swift
//  VoiceMai
//
//  Created by RockerHX on 2018/11/27.
//  Copyright © 2018 RockerHX. All rights reserved.
//


import Foundation


extension Optional {

    /// 可选值为空的时候返回 true
    var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }

    /// 可选值非空返回 true
    var isSome: Bool {
        return !isNone
    }

}


extension Optional {

    /**
     返回可选值或默认值
     - 参数: 如果可选值为空，将返回会默认值
     ```
     let optional: Int? = nil
     print(optional.or(10)) // 打印 10
     ```
     */
    func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }

}


extension Optional {

    /**
     返回可选值或 `else` 表达式返回的值
     例如. optional.or(else: print("Arrr"))

     默认闭包和默认值非常的相似，但它允许从闭包中返回默认值。
     ```
     let optional: Int? = nil
     optional.or(else: secretValue * 32)
     ```

     由于使用了`@autoclosure`参数, 我们实际上使用的是默认闭包。使用默认值将会自动转换为返回值的闭包。然而，我倾向于将两个实现单独分开，因为它可以让用户用更加复杂的逻辑编写闭包。
     ```
     let cachedUserCount: Int? = nil
     ...
     return cachedUserCount.or(else: {
     let db = database()
     db.prefetch()
     guard db.failures.isEmpty else { return 0 }
     return db.amountOfUsers
     })
     ```

     当你对一个为空的可选值赋值的时候，使用`or`就是一个不错的选择。
     ```
     if databaseController == nil {
     databaseController = DatabaseController(config: config)
     }
     ```
     上面的代码可以写的更加优雅:
     ```
     databaseController = databaseController.or(DatabaseController(config: config))
     ```
     */
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }

    /**
     返回可选值或者 `else` 闭包返回的值，例如：
     ```
     optional.or(else: {
     ... do a lot of stuff
     })
     ```
     */
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }

}


extension Optional {

    /**
     当可选值不为空时，返回可选值
     如果为空，抛出异常

     这也是一个非常有用的补充，因为它将 Swift 中可选值与错误处理连接起来。根据项目中的代码，方法或函数通过返回一个为空的可选值（例如访问字典中不存在的键）时，抛出错误来表述这一无效的行为。将两者连接起来能够使代码更加清晰：
     ```
     func buildCar() throws -> Car {
     let tires = try machine1.createTires()
     let windows = try machine2.createWindows()
     guard let motor = externalMachine.deliverMotor() else {
     throw MachineError.motor
     }
     let trunk = try machine3.createTrunk()
     if let car = manufacturer.buildCar(tires, windows,  motor, trunk) {
     return car
     } else {
     throw MachineError.manufacturer
     }
     }
     ```

     在这个例子中，我们通过调用内部及外部代码共同构建汽车对象，外部代码（external_machine 和 manufacturer）选择使用可选值而不是错误处理。这使得代码变得很复杂，我们可使用 or(throw:) 使函数可读性更高。
     ```
     func build_car() throws -> Car {
     let tires = try machine1.createTires()
     let windows = try machine2.createWindows()
     let motor = try externalMachine.deliverMotor().or(throw: MachineError.motor)
     let trunk = try machine3.createTrunk()
     return try manufacturer.buildCar(tires, windows,  motor, trunk).or(throw: MachineError.manufacturer)
     }
     ```
     */
    func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }

}


extension Optional where Wrapped == Error {

    /**
     当可选值不为空时，执行 `else`

     上面抛出异常部分的代码变更加有用。
     ```
     func should(_ do: () throws -> Void) -> Error? {
     do {
     try `do`()
     return nil
     } catch let error {
     return error
     }
     }
     ```

     这个自由函数（可选的，可将它当做一个可选项的类方法）使用 do {} catch {} 块并返回一个错误。当且仅当 do 代码块捕捉到异常。以下面 Swift 代码为例：
     ```
     do {
     try throwingFunction()
     } catch let error {
     print(error)
     }
     ```

     这是 Swift 中错误处理的基本原则之一，但它不够简单明了。使用上面的提供的函数，你可以使代码变得足够简单。
     ```
     should { try throwingFunction) }.or(print($0))
     ```
     */
    func or(_ else: (Error) -> Void) {
        guard let error = self else { return }
        `else`(error)
    }

}

