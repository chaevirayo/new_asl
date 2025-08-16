plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Add Firebase plugin
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.new_asl"
    compileSdk = 35 // Updated to resolve dependency and compatibility issues.

    defaultConfig {
        applicationId = "com.example.new_asl"
        minSdk = 21 // Ensure compatibility with the NDK and avoid errors.
        targetSdk = 35 // Updated to match the compileSdk version.
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Add Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:32.7.2"))
    
    // Add Firebase Analytics (optional but recommended)
    implementation("com.google.firebase:firebase-analytics")
}