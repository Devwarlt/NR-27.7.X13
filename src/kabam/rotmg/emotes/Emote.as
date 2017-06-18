package kabam.rotmg.emotes {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.GlowFilter;
import flash.geom.Matrix;

public class Emote extends Sprite {

    private var emoteName:String;
    private var bitmapData:BitmapData;
    private var scale:Number;
    private var hq:Boolean;

    public function Emote(emoteName:String, bitmapData:BitmapData, scale:Number, hq:Boolean) {
        super();
        this.emoteName = emoteName;
        this.bitmapData = bitmapData;
        this.scale = scale;
        this.hq = hq;
        var BM:BitmapData = bitmapData;
        var matrix:Matrix = new Matrix();
        matrix.scale(scale, scale);
        var Image:BitmapData = new BitmapData(Math.floor(BM.width * scale), Math.floor(BM.height * scale), true, 0);
        Image.draw(BM, matrix, null, null, null, hq);
        var shape:Shape = new Shape();
        shape.graphics.beginBitmapFill(BM, matrix, false, true);
        shape.graphics.lineStyle(0,0,0);
        shape.graphics.drawRect(0,0,Image.width,Image.height);
        shape.graphics.endFill();
        Image.draw(shape);
        var Image_:Bitmap = new Bitmap(Image);
        Image_.filters = !!hq?[]:[new GlowFilter(0,1,6,6,4)];
        Image_.y = -2;
        addChild(Image_);
    }

    public function clone():Emote {
        return new Emote(this.emoteName, this.bitmapData, this.scale, this.hq);
    }
}
}
