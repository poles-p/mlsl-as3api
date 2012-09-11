package mlsl {
    import flash.display3D.Context3DProgramType;
    import flash.utils.Dictionary;

    public final class MLSLVertexProgram extends MLSLProgramBase {
        private var attrs:Vector.<MLSLAttr>;
        private var attrsByName:Dictionary;

        public function MLSLVertexProgram() {
			super(Context3DProgramType.VERTEX);
            attrs = new Vector.<MLSLAttr>();
            attrsByName = new Dictionary();
        }

        override public function loadFromJSON(jsonSource:String):void {
            super.loadFromJSON(jsonSource);

            for (var i:int = 0; i < json.attr.length; ++i) {
                var attrInfo:Object = json.attr[i];
                var attribute:MLSLAttr = new MLSLAttr(attrInfo.name, attrInfo.type, parseInt(attrInfo.register));
                attrsByName[attribute.name] = attribute;
                attrs.push(attribute);
            }
        }

        public function getAttribute(name:String):MLSLAttr {
            return attrsByName[name];
        }


    }

}