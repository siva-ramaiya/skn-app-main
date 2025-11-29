plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "example.astrovibe.foodapp"
    compileSdk = 36   // ✅ must be at least 35
    ndkVersion = "25.1.8937393"  // Using a stable NDK version
    
    buildFeatures {
        buildConfig = true
    }

    defaultConfig {
        applicationId = "example.astrovibe.foodapp"
        minSdk = flutter.minSdkVersion
        targetSdk = 34   // can update to 35 later if needed
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.9.23")

    // ✅ desugaring new version
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    implementation("androidx.multidex:multidex:2.0.1")
}
