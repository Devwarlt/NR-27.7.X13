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

    public function getChatBubbleText(_arg1:String, _arg2:Boolean, _arg3:uint):Sprite {
        this.add(_arg1, _arg2, _arg3);
        return new Drawer(this.buffer,150,17);
    }

    private function getAllWords(_arg1:String):Array {
        return _arg1.split(" ");
    }

    private function add(_arg1:String, _arg2:Boolean, _arg3:uint):void {
        var sbuilder:StringBuilder = null;
        var string:String = null;
        for each (string in this.getAllWords(_arg1)) {
            if (Emotes.hasEmote(string)) {
                this.buffer.push(Emotes.getEmote(string));
            }
            else {
                sbuilder = new StaticStringBuilder(string);
                this.buffer.push(this.makeNormalText(sbuilder, _arg2, _arg3));
            }
        }
    }

    private function makeNormalText(_arg1:StringBuilder, _arg2:Boolean, _arg3:uint):TextField {
        var tfield:TextField = null;
        tfield = new TextField();
        tfield.autoSize = TextFieldAutoSize.LEFT;
        tfield.embedFonts = true;
        var _local5_:TextFormat = new TextFormat();
        _local5_.font = "Myriad Pr";
        _local5_.size = 14;
        _local5_.bold = _arg2;
        _local5_.color = _arg3;
        tfield.defaultTextFormat = _local5_;
        tfield.selectable = false;
        tfield.mouseEnabled = false;
        tfield.text = _arg1.getString();
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

    function Drawer(_arg1:Vector.<DisplayObject>, _arg2:int, _arg3:int) {
        super();
        this.maxWidth = _arg2;
        this.lineHeight = _arg3;
        this.list = _arg1;
        this.count = _arg1.length;
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

    private function draw() : void
    {
        var _local1:DisplayObject = null;
        for each(_local1 in this.list)
        {
            addChild(_local1);
        }
    }
}
