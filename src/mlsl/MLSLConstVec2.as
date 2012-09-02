package mlsl {
    import flash.display3D.Context3D;
    import flash.utils.ByteArray;
    import flash.utils.Endian;

    public class MLSLConstVec2 extends MLSLConst {
        public var value:ByteArray;

        public function MLSLConstVec2() {
            value = new ByteArray();
            value.endian = Endian.LITTLE_ENDIAN;
        }

        public function setValue(x:Number, y:Number):void {
            value.position = 0;
            value.writeFloat(x);
            value.writeFloat(y);
        }

        override public function bind(ctx:Context3D):void {
            ctx.setProgramConstantsFromByteArray(programType, register, 1, value, 0);
        }

    }

}