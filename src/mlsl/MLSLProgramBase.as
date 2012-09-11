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
		protected var programType:String;
		
		private const SOURCE_TYPE_ASSEMBLER:String = 'assembler';
		private const SOURCE_TYPE_BYTECODE:String = 'bytecode';

        private var numericalConsts:Vector.<MLSLConst>;

        public function MLSLProgramBase(programType:String) {
            consts = new Vector.<MLSLConst>();
			numericalConsts = new Vector.<MLSLConst>();
            constsByName = new Dictionary();
			this.programType = programType;
        }

        public function loadFromJSON(jsonSource:String):void {
            json = JSON.parse(jsonSource);
			
			if (json.source.type == SOURCE_TYPE_ASSEMBLER)
				setAssembler(json.source.value);
			else if (json.source.type == SOURCE_TYPE_BYTECODE)
				setSource(Base64Decoder.decode(json.source.value));
			
			var i:int;
				
			for (i = 0; i < json.constParams.length; ++i) {
                var param:Object = json.constParams[i];
                var constParam:MLSLConst = new MLSLConst.constClassByType[param.type];
                constParam.name = param.name;
                constParam.type = param.type;
                constParam.register = parseInt(param.register);
                constParam.fieldOffset = parseInt(param.fieldOffset);
				constParam.programType = programType;
                consts.push(constParam);
                constsByName[constParam.name] = constParam;
            }
			
			for (i = 0; i < json.constValues.length; ++i) {
				var value:Object = json.constValues[i];
				var constValue:MLSLConst = MLSLConst.newConstVec4();
				constValue.type = MLSLType.VEC4;
				constValue.register = value.register;
				constValue.setValueFromVec4(value.value[0], value.value[1], value.value[2], value.value[3]);
				constValue.programType = programType;
				numericalConsts.push(constValue);
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
			var agalAsm:AGALMiniAssembler = new AGALMiniAssembler();
            agalAsm.assemble(programType, asm);
            setSource(agalAsm.agalcode);
        }

        public function getSource():ByteArray {
            return source;
        }

        public function getParamter(name:String):MLSLConst {
            return constsByName[name];
        }

        public function bind():void {
			var i:int;
            for (i = 0; i < consts.length; ++i) {
                consts[i].bind(context3d);
            }
			
			for (i = 0; i < numericalConsts.length; ++i) {
				numericalConsts[i].bind(context3d);
			}
        }

    }
}