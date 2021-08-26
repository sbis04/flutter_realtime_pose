package com.souvikbiswas.pose_test;

import android.content.Intent;

import androidx.annotation.NonNull;

import com.souvikbiswas.pose_test.java.LivePreviewActivity;
import com.souvikbiswas.pose_test.java.posesetector.PoseDataStorage;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String EVENT_CHANNEL = "platform_channel_events/pose";
    private static final String CHANNEL = "com.souvikbiswas.pose_test/pose";

    // private PoseClassifierProcessor poseClassifierProcessor;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        FlutterEngineCache
                .getInstance()
                .put("pose_engine", flutterEngine);
//        new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), EVENT_CHANNEL)
//                .setStreamHandler(new EventChannel.StreamHandler() {
//                    @Override
//                    public void onListen(Object listener, EventChannel.EventSink eventSink) {
//                        // startListening(listener, eventSink);
//                        // Pose pose = task.getResult();
//                        // poseClassifierProcessor.getPoseResult();
//                    }
//
//                    @Override
//                    public void onCancel(Object listener) {
//                        cancelListening(listener);
//                    }
//                });
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("getPoseName")) {
                                // String poseName = getPoseName();
                                // result.success(poseName);

                                Intent intent = new Intent(this, LivePreviewActivity.class);
                                startActivity(intent);
                            } else if (call.method.equals("getAccuracy")) {
                                String accuracy = PoseDataStorage.getAccuracy();
                                result.success(accuracy);
                            } else {
                                result.notImplemented();
                            }
                        }
                );


    }

    // Listeners
    static final public Map<Object, Runnable> listeners = new HashMap<>();

//    void startListening(Object listener, EventChannel.EventSink emitter) {
//        // Prepare a timer like self calling task
//        final Handler handler = new Handler();
//        listeners.put(listener, new Runnable() {
//            @Override
//            public void run() {
//                if (listeners.containsKey(listener)) {
//                    // Send some value to callback
//                    emitter.success("Hello listener! " + (System.currentTimeMillis() / 1000));
//                    handler.postDelayed(this, 1000);
//                }
//            }
//        });
//        // Run task
//        handler.postDelayed(listeners.get(listener), 1000);
//    }
//

//    void cancelListening(Object listener) {
//        // Remove callback
//        listeners.remove(listener);
//    }

    private String getPoseName() {
        return "mountain";
    }
}
