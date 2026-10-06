package com.apravint.omarchylauncher;

import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebSettings;
import android.webkit.JavascriptInterface;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.drawable.Drawable;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.util.Base64;
import android.view.Window;
import android.view.WindowManager;
import android.net.Uri;
import java.io.ByteArrayOutputStream;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

public class MainActivity extends Activity {

    private WebView webView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Hardware acceleration & edge-to-edge immersive system bars
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        getWindow().setFlags(
            WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED,
            WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED
        );
        getWindow().setFlags(
            WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS
        );

        webView = new WebView(this);
        setContentView(webView);

        WebSettings settings = webView.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setAllowFileAccess(true);
        settings.setDatabaseEnabled(true);
        settings.setRenderPriority(WebSettings.RenderPriority.HIGH);

        webView.addJavascriptInterface(new WebAppInterface(), "AndroidLauncher");
        webView.setWebViewClient(new WebViewClient());
        webView.loadUrl("file:///android_asset/web/index.html");
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if (webView != null) {
            webView.evaluateJavascript("if(window.onHomePressed) window.onHomePressed();", null);
        }
    }

    @Override
    public void onBackPressed() {
        if (webView != null) {
            webView.evaluateJavascript("if(window.onBackPressed) window.onBackPressed();", null);
        }
    }

    public class WebAppInterface {

        @JavascriptInterface
        public String getInstalledApps() {
            JSONArray appList = new JSONArray();
            try {
                PackageManager pm = getPackageManager();
                Intent mainIntent = new Intent(Intent.ACTION_MAIN, null);
                mainIntent.addCategory(Intent.CATEGORY_LAUNCHER);

                List<ResolveInfo> pkgAppsList = pm.queryIntentActivities(mainIntent, 0);
                for (ResolveInfo ri : pkgAppsList) {
                    if (ri.activityInfo != null) {
                        String label = ri.loadLabel(pm).toString();
                        String packageName = ri.activityInfo.packageName;

                        JSONObject appObj = new JSONObject();
                        appObj.put("name", label);
                        appObj.put("packageName", packageName);
                        appObj.put("icon", getAppIconBase64(pm, ri));
                        appList.put(appObj);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return appList.toString();
        }

        @JavascriptInterface
        public boolean launchApp(String packageName) {
            try {
                PackageManager pm = getPackageManager();
                Intent launchIntent = pm.getLaunchIntentForPackage(packageName);
                if (launchIntent != null) {
                    startActivity(launchIntent);
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        @JavascriptInterface
        public void uninstallApp(String packageName) {
            try {
                Intent intent = new Intent(Intent.ACTION_DELETE);
                intent.setData(Uri.parse("package:" + packageName));
                startActivity(intent);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @JavascriptInterface
        public void setAsDefaultHome() {
            try {
                Intent intent = new Intent(android.provider.Settings.ACTION_HOME_SETTINGS);
                startActivity(intent);
            } catch (Exception e) {
                try {
                    Intent intent = new Intent(android.provider.Settings.ACTION_SETTINGS);
                    startActivity(intent);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }

        @JavascriptInterface
        public void openSettings() {
            try {
                Intent intent = new Intent(android.provider.Settings.ACTION_SETTINGS);
                startActivity(intent);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @JavascriptInterface
        public void openAppDetails(String packageName) {
            try {
                Intent intent = new Intent(android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
                intent.setData(Uri.parse("package:" + packageName));
                startActivity(intent);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @JavascriptInterface
        public void openWallpaperPicker() {
            try {
                Intent intent = new Intent(Intent.ACTION_SET_WALLPAPER);
                startActivity(Intent.createChooser(intent, "Select Wallpaper"));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @JavascriptInterface
        public void performHaptics() {
            try {
                if (webView != null) {
                    webView.post(new Runnable() {
                        @Override
                        public void run() {
                            webView.performHapticFeedback(android.view.HapticFeedbackConstants.KEYBOARD_TAP);
                        }
                    });
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @JavascriptInterface
        public String getDeviceInfo() {
            try {
                JSONObject info = new JSONObject();
                info.put("model", android.os.Build.MODEL);
                info.put("manufacturer", android.os.Build.MANUFACTURER);
                info.put("androidVersion", android.os.Build.VERSION.RELEASE);
                info.put("sdkInt", android.os.Build.VERSION.SDK_INT);
                return info.toString();
            } catch (Exception e) {
                return "{}";
            }
        }

        private String getAppIconBase64(PackageManager pm, ResolveInfo ri) {
            try {
                Drawable icon = ri.loadIcon(pm);
                int size = 128; // High DPI 128x128 crisp app icon standard

                Bitmap bitmap = Bitmap.createBitmap(size, size, Bitmap.Config.ARGB_8888);
                Canvas canvas = new Canvas(bitmap);
                icon.setBounds(0, 0, canvas.getWidth(), canvas.getHeight());
                icon.draw(canvas);

                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                bitmap.compress(Bitmap.CompressFormat.PNG, 85, outputStream);
                byte[] byteArray = outputStream.toByteArray();
                return "data:image/png;base64," + Base64.encodeToString(byteArray, Base64.NO_WRAP);
            } catch (Exception e) {
                return "";
            }
        }
    }
}
