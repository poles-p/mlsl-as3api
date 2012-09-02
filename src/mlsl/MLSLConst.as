package mlsl {
    import flash.display3D.Context3D;

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

        public function bind(ctx:Context3D):void {

        }

        public function MLSLConst() {

        }

    }

}