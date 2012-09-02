package mlsl {
    import flash.display3D.Context3DProgramType;
    import flash.utils.Dictionary;

    public final class MLSLVertexProgram extends MLSLProgramBase {
        private var attrs:Vector.<MLSLAttr>;
        private var usedAttrsBySemantic:Dictionary;

        public function MLSLVertexProgram() {
            attrs = new Vector.<MLSLAttr>();
            usedAttrsBySemantic = new Dictionary();
        }

        override public function loadFromJSON(jsonSource:String):void {
            super.loadFromJSON(jsonSource);

            var i:int;
            for (i = 0; i < consts.length; ++i) {
                consts[i].programType = Context3DProgramType.VERTEX;
            }

            for (i = 0; i < json.attr.length; ++i) {
                var attrInfo:Object = json.attr[i];
                var attribute:MLSLAttr = new MLSLAttr(attrInfo.semantic, attrInfo.type);
                usedAttrsBySemantic[attribute.semantic] = attribute;
                attrs.push(attribute);
            }
        }

        override public function setAssembler(asm:String):void {
            var agalAsm:AGALMiniAssembler = new AGALMiniAssembler();
            agalAsm.assemble(Context3DProgramType.VERTEX, asm);
            setSource(agalAsm.agalcode);
        }

        public function getAttribute(semantic:String):MLSLAttr {
            return usedAttrsBySemantic[semantic];
        }


    }

}