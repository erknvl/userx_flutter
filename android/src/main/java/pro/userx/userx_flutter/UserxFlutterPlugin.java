package pro.userx.userx_flutter;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import pro.userx.UserX;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

/**
 * FlutterUserxPlugin
 */
public class UserxFlutterPlugin implements MethodCallHandler, FlutterPlugin {

    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(FlutterPlugin.FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "userx_flutter");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(FlutterPlugin.FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "userx_flutter");
        channel.setMethodCallHandler(new UserxFlutterPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("start")) {
            String key = call.argument("key");
            UserX.init(key);
        } else if (call.method.equals("setUserId")) {
            String userId = call.argument("userId");
            UserX.setUserId(userId);
        } else if (call.method.equals("addEvent")) {
            String name = call.argument("name");
            HashMap<String, String> attributes = call.argument("attributes");
            if (attributes == null) {
                UserX.addEvent(name);
            } else {
                UserX.addEvent(name, attributes);
            }
        } else if (call.method.equals("stopScreenRecording")) {
            UserX.stopScreenRecording();
        } else if (call.method.equals("startScreenRecording")) {
            UserX.startScreenRecording();
        } else if (call.method.equals("setRenderingInBackground")) {
            boolean renderingInBackground = call.argument("renderingInBackground");
            UserX.setRenderingInBackground(renderingInBackground);
        } else if (call.method.equals("addScreenName")) {
            String title = call.argument("title");
            UserX.addScreenName(title);
        } else {
            result.notImplemented();
        }
    }
}
