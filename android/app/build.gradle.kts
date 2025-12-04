plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.skn.foodapp"
    compileSdk = 36   // Updated to match plugin requirements
    ndkVersion = "27.0.12077973"  // Updated to match plugin requirements
    
    buildFeatures {
        buildConfig = true
    }

    defaultConfig {
        applicationId = "com.skn.foodapp"
        minSdk = flutter.minSdkVersion
        targetSdk = 34   // Keeping targetSdk at 34 for stability, can update later if needed
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
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.8.22")

    // ✅ desugaring new version
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    implementation("androidx.multidex:multidex:2.0.1")
}
