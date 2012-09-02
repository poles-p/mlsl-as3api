package mlsl {
    import flash.display3D.Context3DProgramType;
    import flash.display3D.textures.Texture;

    public final class MLSLFragmentProgram extends MLSLProgramBase {
        private var samplers:Vector.<MLSLSampler>;

        public function MLSLFragmentProgram() {
            samplers = new Vector.<MLSLSampler>();
        }

        override public function loadFromJSON(jsonSource:String):void {
            super.loadFromJSON(jsonSource);

            var i:int;
            for (i = 0; i < consts.length; ++i) {
                consts[i].programType = Context3DProgramType.FRAGMENT;
            }

            for (i = 0; i < json.sampler.length; ++i) {
                var sampler:MLSLSampler = new MLSLSampler();
                sampler.name = json.sampler[i].name;
                samplers.push(sampler);
            }
        }

        override public function setAssembler(asm:String):void {
            var agalAsm:AGALMiniAssembler = new AGALMiniAssembler();
            agalAsm.assemble(Context3DProgramType.FRAGMENT, asm);
            setSource(agalAsm.agalcode);
        }

        public function setSamplerTexture(index:int, texture:Texture):void {
            samplers[index].setTexture(texture);
        }

        override public function bind():void {
            super.bind();

            for (var i:int = 0; i < samplers.length; ++i) {
                context3d.setTextureAt(i, samplers[i].getTexture());
            }
        }
    }
}