Tutorial para usar FaceID / TouchID en Swift
============================================

Este tutorial más detalladamente explicado se puede ver en [Youtube](https://www.youtube.com/watch?v=VDxbFcbYUvQ&feature=youtu.be)

## Pasos a seguir:
1. Actualizar Info.Plist para agregar la key NSFaceIDUsageDescription  
2. Crear una constante objeto de tipo LAContext e inicializarla  
3. Asignar una variable de tipo NSError?  
4. Comprobar que el dispositivo corra iOS 8.0+ con el comando #available(iOS 8.0, \*)  
5. Comprobar que el dispositivo tenga disponibles los biométricos, esto con la función `.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError)` del objeto LAContext, siendo `authError` la variable previamente definida, en la cuál se almacenarán los errores en caso de suceder  
6. Si corre una versión compatible de iOS y tiene biométricos disponibles, ejecutar la siguiente función del mismo objeto:  
```swift
.evaluatePolicy(.devdeviceOwnerAuthenticationWithBiometrics, localizedReason: "**String to show to user**")
{
    success, evaluateError in
    DispatchQueue.main.async
    {
        if success
        {
            print("Authentication successfull")
        }
        else
        {
            print(evaluateError!)
        }
    }
}
```
En la que solicita la autorización mediante los biométricos y vuelve verdadero el valor de 'success' en caso de que haya sido autorizada
