package mlsl {
    import flash.display3D.Context3DProgramType;
    import flash.display3D.textures.Texture;
	import flash.utils.Dictionary;

    public final class MLSLFragmentProgram extends MLSLProgramBase {
        private var samplers:Vector.<MLSLSampler>;
		private var samplersByName:Dictionary;

        public function MLSLFragmentProgram() {
			super(Context3DProgramType.FRAGMENT);
            samplers = new Vector.<MLSLSampler>();
			samplersByName = new Dictionary();
        }

        override public function loadFromJSON(jsonSource:String):void {
            super.loadFromJSON(jsonSource);

            for (var i:int = 0; i < json.sampler.length; ++i) {
                var sampler:MLSLSampler = new MLSLSampler();
                sampler.name = json.sampler[i].name;
				sampler.index = json.sampler[i].index;
				samplersByName[sampler.name] = sampler;
                samplers.push(sampler);
            }
        }

        public function setSamplerTexture(name:String, texture:Texture):void {
			var sampler:MLSLSampler = samplersByName[name];
			if (sampler) {
				sampler.setTexture(texture);
			}
        }

        override public function bind():void {
            super.bind();

            for (var i:int = 0; i < samplers.length; ++i) {
                context3d.setTextureAt(samplers[i].index, samplers[i].getTexture());
            }
        }
    }
}