package mlsl {
    import flash.display3D.Context3D;
    import flash.geom.Matrix3D;

    public class MLSLConstMat44 extends MLSLConst {
        public var value:Matrix3D;

        public function MLSLConstMat44() {
            value = new Matrix3D();
        }

        public function setValue(m44:Matrix3D):void {
            value.copyFrom(m44);
        }

        override public function bind(ctx:Context3D):void {
            ctx.setProgramConstantsFromMatrix(programType, register, value, true);
        }

    }

}