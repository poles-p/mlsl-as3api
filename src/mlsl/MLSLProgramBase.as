package mlsl {
    import flash.display3D.Context3D;
    import flash.display3D.Context3DProgramType;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.Endian;

    public class MLSLProgramBase {
        protected var consts:Vector.<MLSLConst>;
        private var constsByName:Dictionary;
        private var source:ByteArray;
        protected var json:Object;
        protected var context3d:Context3D;

        private var numericalConsts:Vector.<MLSLConst>;

        public function MLSLProgramBase() {
            consts = new Vector.<MLSLConst>();
            constsByName = new Dictionary();
        }

        public function loadFromJSON(jsonSource:String):void {
            json = JSON.parse(jsonSource);

            for (var i:int = 0; i < json['const'].params.length; ++i) {
                var param:Object = json['const'].params[i];
                var constParam:MLSLConst = new MLSLConst.constClassByType[param.type];
                constParam.name = param.name;
                constParam.type = param.type;
                constParam.register = parseInt(param.register);
                constParam.fieldOffset = parseInt(param.name);
                consts.push(constParam);
                constsByName[constParam.name] = constParam;
            }
        }

        public function setContext3d(ctx:Context3D):void {
            context3d = ctx;
        }

        public function setSource(bytecode:ByteArray):void {
            source = new ByteArray();
            source.endian = Endian.LITTLE_ENDIAN;
            source.writeBytes(bytecode);
        }

        public function setAssembler(asm:String):void {
        }

        public function getSource():ByteArray {
            return source;
        }

        public function getParamter(name:String):MLSLConst {
            return constsByName[name];
        }

        public function bind():void {
            for (var i:int = 0; i < consts.length; ++i) {
                consts[i].bind(context3d);
            }
        }

    }
}