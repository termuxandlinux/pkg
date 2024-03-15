#!/bin/bash

# Ask for project details
read -p "Enter project name: " project_name
read -p "Enter package name (e.g., com.example.myapp): " package_name
read -p "Enter path to Android SDK root directory: " sdk_root

# Set default values for SDK and project directories
sdk_dir="$sdk_root/cmdline-tools/latest"
project_dir="./$project_name"

# Create project directory
mkdir -p "$project_dir"

# Create src directory and package directory
src_dir="$project_dir/app/src/main/java/$(echo $package_name | tr . /)"
mkdir -p "$src_dir"

# Create res directory
res_dir="$project_dir/app/src/main/res"
mkdir -p "$res_dir"

# Create AndroidManifest.xml
cat << EOF > "$project_dir/app/src/main/AndroidManifest.xml"
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="$package_name">

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/AppTheme">
        <activity android:name=".MainActivity">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
EOF

# Create MainActivity.java
cat << EOF > "$src_dir/MainActivity.java"
package $package_name;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
EOF

# Inform user about the project directory
echo "Project directory created at: $project_dir"
