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

    public function Emote(_arg1:String, _arg2:BitmapData, _arg3:Number, _arg4:Boolean) {
        super();
        this.emoteName = _arg1;
        this.bitmapData = _arg2;
        this.scale = _arg3;
        this.hq = _arg4;
        var BM:BitmapData = _arg2;
        var matrix:Matrix = new Matrix();
        matrix.scale(_arg3, _arg3);
        var Image:BitmapData = new BitmapData(Math.floor(BM.width * _arg3), Math.floor(BM.height * _arg3), true, 0);
        Image.draw(BM, matrix, null, null, null, _arg4);
        var shape:Shape = new Shape();
        shape.graphics.beginBitmapFill(BM, matrix, false, true);
        shape.graphics.lineStyle(0,0,0);
        shape.graphics.drawRect(0,0,Image.width,Image.height);
        shape.graphics.endFill();
        Image.draw(shape);
        var Image_:Bitmap = new Bitmap(Image);
        Image_.filters = !!_arg4?[]:[new GlowFilter(0,1,6,6,4)];
        Image_.y = -2;
        addChild(Image_);
    }

    public function clone():Emote {
        return new Emote(this.emoteName, this.bitmapData, this.scale, this.hq);
    }
}
}
