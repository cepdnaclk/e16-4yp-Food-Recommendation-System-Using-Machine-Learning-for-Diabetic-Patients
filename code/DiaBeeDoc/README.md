# Dia Bee Doc
Diabeedoc which is an intelligent mobile application. Using Diabeedoc you can find the suitability of a particular food for diabetes in no time. We have deployed our GI based machine-learning models to the Azure cloud. Diabeedoc uses those ML models with the Openfoodfacts database to predict particular food is suitable or not. If it is not suitable Diabeedoc is capable of suggesting better foods using machine learning based substitution system. 

Imagine you are shopping. There are only 4 simple actions. Number one, scan the barcode on the packaged food. Number two, get the prediction for suitability. Now, you might wonder, what will happen if the product is not available? Well, then you have to enter the nutrient values and add the product first. Number 3, you can see the full product details, if you need. Number 4, if the product is not suitable, you can get the list of substitutable foods. Simple as that.

![FYP (Industry) (2)](https://user-images.githubusercontent.com/59219626/215565686-03bf968d-ae82-4dd9-b4f1-83b9a028f745.png)

![FYP (Industry) (1)](https://user-images.githubusercontent.com/59219626/215565765-758eb2ce-cadf-4499-b023-3b41f73b31f3.png)

## How to run the project

In order to run the application, make sure you are in the `packages/app` directory and run these commands :

- `flutter pub get .`
  
- On Android 🤖: `flutter run -t lib/entrypoints/android/main_google_play.dart`

- On iOS 🍎: `flutter run -t lib/entrypoints/ios/main_ios.dart`



## Alert!

We are currently using Flutter 3.0.5 as the new 3.3.0 has some bugs

Running `flutter downgrade 3.0.5` downgrades the version.
