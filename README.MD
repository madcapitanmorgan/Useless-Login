Tutorial para usar FaceID / TouchID en Swift
============================================

## Pasos a seguir:
1.- Actualizar Info.Plist para agregar la key NSFaceIDUsageDescription  
2.- Crear una constante objeto de tipo LAContext e inicializarla  
3.- Asignar una variable de tipo NSError?  
4.- Comprobar que el dispositivo corra iOS 8.0+ con el comando #available(iOS 8.0, \*)  
5.- Comprobar que el dispositivo tenga disponibles los biométricos, esto con la función *.canEvaluatePolicy(deviceOwnerAuthentication, error: &authError)* siendo authError la variable previamente definida  
