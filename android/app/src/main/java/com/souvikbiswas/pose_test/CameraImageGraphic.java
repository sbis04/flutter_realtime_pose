package com.souvikbiswas.pose_test;

import android.graphics.Bitmap;
import android.graphics.Canvas;

/** Draw camera image to background. */
public class CameraImageGraphic extends GraphicOverlay.Graphic {

  private final Bitmap bitmap;

  public CameraImageGraphic(com.souvikbiswas.pose_test.GraphicOverlay overlay, Bitmap bitmap) {
    super(overlay);
    this.bitmap = bitmap;
  }

  @Override
  public void draw(Canvas canvas) {
    canvas.drawBitmap(bitmap, getTransformationMatrix(), null);
  }
}
