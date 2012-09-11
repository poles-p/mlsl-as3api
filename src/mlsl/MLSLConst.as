package mlsl {
    import flash.display3D.Context3D;
    import flash.geom.Matrix3D;

    public class MLSLConst {
        public static var constClassByType:Object;

        public var name:String;
        public var type:String;
        public var register:int;
        public var fieldOffset:int;
        public var programType:String;

        public static function init():void {
            constClassByType = {
                'vec2': MLSLConstVec2,
                'vec4': MLSLConstVec4,
                'mat44': MLSLConstMat44
            };
        }

        public function setValueFromMatrix3D(m44:Matrix3D):void {
        }

        public function setValueFromVec2(x:Number, y:Number):void {
        }

        public function setValueFromVec4(x:Number, y:Number, z:Number, w:Number):void {
        }

        public function bind(ctx:Context3D):void {
        }

        public function MLSLConst() {
        }

        public static function newConstMat44():MLSLConst {
            return new MLSLConstMat44();
        }

        public static function newConstVec2():MLSLConst {
            return new MLSLConstVec2();
        }

        public static function newConstVec4():MLSLConst {
            return new MLSLConstVec4();
        }
    }
}

import flash.display3D.Context3D;
import flash.geom.Matrix3D;
import flash.utils.ByteArray;
import flash.utils.Endian;
import mlsl.MLSLConst;

class MLSLConstMat44 extends MLSLConst {
    public var value:Matrix3D;

    public function MLSLConstMat44() {
        value = new Matrix3D();
    }

    override public function setValueFromMatrix3D(m44:Matrix3D):void {
        value.copyFrom(m44);
    }

    override public function bind(ctx:Context3D):void {
        ctx.setProgramConstantsFromMatrix(programType, register, value, true);
    }

}

class MLSLConstVec2 extends MLSLConst {
    public var value:ByteArray;

    public function MLSLConstVec2() {
        value = new ByteArray();
        value.endian = Endian.LITTLE_ENDIAN;
    }

    override public function setValueFromVec2(x:Number, y:Number):void {
        value.position = 0;
        value.writeFloat(x);
        value.writeFloat(y);
    }

    override public function bind(ctx:Context3D):void {
        ctx.setProgramConstantsFromByteArray(programType, register, 1, value, 0);
    }

}

class MLSLConstVec4 extends MLSLConst {
    public var value:ByteArray;

    public function MLSLConstVec4() {
        value = new ByteArray();
        value.endian = Endian.LITTLE_ENDIAN;
    }

    override public function setValueFromVec4(x:Number, y:Number, z:Number, w:Number):void {
        value.position = 0;
        value.writeFloat(x);
        value.writeFloat(y);
        value.writeFloat(z);
        value.writeFloat(w);
    }

    override public function bind(ctx:Context3D):void {
        ctx.setProgramConstantsFromByteArray(programType, register, 1, value, 0);
    }

}
