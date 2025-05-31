# Keep Razorpay classes
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Keep Google Pay related classes
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.**

# Keep Proguard annotation classes
-keep class proguard.annotation.** { *; }
-dontwarn proguard.annotation.**
