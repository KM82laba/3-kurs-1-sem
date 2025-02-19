plugins {
    id("com.android.application")
}

android {
    namespace = "com.example.lab15"
    compileSdk = 34



    defaultConfig {
        applicationId = "com.example.lab15"
        minSdk = 34
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}

dependencies {

    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.10.0")
    implementation("androidx.constraintlayout:constraintlayout:2.1.4")
    implementation("junit:junit:4.12")
    implementation ("org.mockito:mockito-core:3.11.2")
    implementation("junit:junit:4.12")
    testImplementation("junit:junit:4.13.2")
    testImplementation ("org.mockito:mockito-core:3.11.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
    compileOnly ("com.android.tools.lint:lint-api:26.3.0")
    compileOnly ("com.android.tools.lint:lint-checks:26.3.0")
}