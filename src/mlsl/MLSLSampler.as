package mlsl {
    import flash.display3D.textures.Texture;

    /**
     * ...
     * @author mosowski
     */
    public class MLSLSampler {
        public var name:String;
        public var index:int;
        private var texture:Texture;

        public function MLSLSampler() {

        }

        public function setTexture(tex:Texture):void {
            texture = tex;
        }

        public function getTexture():Texture {
            return texture;
        }

    }

}