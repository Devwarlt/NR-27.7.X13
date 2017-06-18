package kabam.rotmg.emotes {
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import flash.text.TextFieldAutoSize;

public class EmoteGraphicHelper {

    private static const tField:TextField = getTField();
    private var buffer:Vector.<DisplayObject>;

    private static function getTField():TextField {
        var tfield:TextField = new TextField();
        var tformat:TextFormat = new TextFormat();
        tformat.size = 14;
        tformat.bold = false;
        tfield.defaultTextFormat = tformat;
        return tfield;
    }

    public function getChatBubbleText(text:String, bold:Boolean, color:uint):Sprite {
        this.add(text, bold, color);
        return new Drawer(this.buffer,150,17);
    }

    private function getAllWords(text:String):Array {
        return text.split(" ");
    }

    private function add(text:String, bold:Boolean, color:uint):void {
        var sbuilder:StringBuilder = null;
        var string:String = null;
        for each (string in this.getAllWords(text)) {
            if (Emotes.hasEmote(string)) {
                this.buffer.push(Emotes.getEmote(string));
            }
            else {
                sbuilder = new StaticStringBuilder(string);
                this.buffer.push(this.makeNormalText(sbuilder, bold, color));
            }
        }
    }

    private function makeNormalText(SBuilder:StringBuilder, bold:Boolean, color:uint):TextField {
        var tfield:TextField = null;
        tfield = new TextField();
        tfield.autoSize = TextFieldAutoSize.LEFT;
        tfield.embedFonts = true;
        var _local5_:TextFormat = new TextFormat();
        _local5_.font = "Myriad Pr";
        _local5_.size = 14;
        _local5_.bold = bold;
        _local5_.color = color;
        tfield.defaultTextFormat = _local5_;
        tfield.selectable = false;
        tfield.mouseEnabled = false;
        tfield.text = SBuilder.getString();
        if (tfield.textWidth > 150) {
            tfield.multiline = true;
            tfield.wordWrap = true;
            tfield.width = 150;
        }
        return tfield;
    }
}
}

import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.geom.Rectangle;
import kabam.rotmg.emotes.Emote;

class Drawer extends Sprite {

    private var maxWidth:int;
    private var list:Vector.<DisplayObject>;
    private var count:uint;
    private var lineHeight:uint;

    function Drawer(buffer:Vector.<DisplayObject>, maxWidth:int, lineHeight:int) {
        super();
        this.maxWidth = maxWidth;
        this.lineHeight = lineHeight;
        this.list = buffer;
        this.count = buffer.length;
        this._0H_q();
        this.draw();
    }

    private function _0H_q():void {
        var _local1:int = 0;
        var _local2:DisplayObject = null;
        var _local3:Rectangle = null;
        var _local4:int = 0;
        var _local5:int = 0;
        _local1 = 0;
        while (_local5 < this.count) {
            _local2 = this.list[_local5];
            _local3 = _local2.getRect(_local2);
            _local2.x = _local1;
            _local2.y = -_local3.height;
            if (_local1 + _local3.width > this.maxWidth) {
                _local2.x = 0;
                _local1 = 0;
                _local4 = 0;
                while (_local4 < _local5) {
                    this.list[_local4].y = this.list[_local4].y - this.lineHeight;
                    _local4++;
                }
            }
            _local1 = _local1 + (_local2 is Emote?_local3.width + 2:_local3.width);
            _local5++;
        }
    }

    private function draw():void {
        var do_:DisplayObject = null;
        for each (do_ in this.list) {
            addChild(do_);
        }
    }
}
