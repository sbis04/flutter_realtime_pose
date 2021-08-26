package com.souvikbiswas.pose_test.java.posesetector;

public class PoseDataStorage {
    static private String pose;
    static private String accuracy;

    // Getter
    static public String getAccuracy() {
        return accuracy;
    }

    static public String getPose() {
        return pose;
    }

    static public String getData() {
        String result = pose + "#" + accuracy;
        return result;
    }

    // Setter
    static public void setData(String newPose, String newAccuracy) {
        pose = newPose;
        accuracy = newAccuracy;
    }
}
