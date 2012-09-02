package mlsl {
    import flash.display3D.Context3D;
    import flash.display3D.Program3D;
    import flash.display3D.textures.Texture;
    import flash.display3D.VertexBuffer3D;

    public class MLSLProgram {
        private var vertexProgram:MLSLVertexProgram;
        private var fragmentProgram:MLSLFragmentProgram;
        private var program3d:Program3D;
        private var context3d:Context3D;

        public function MLSLProgram(ctx:Context3D) {
            context3d = ctx;
        }

        public function link(vp:MLSLVertexProgram, fp:MLSLFragmentProgram):void {
            vertexProgram = vp;
            fragmentProgram = fp;
            vertexProgram.setContext3d(context3d);
            fragmentProgram.setContext3d(context3d);
            program3d = context3d.createProgram();
            program3d.upload(vertexProgram.getSource(), fragmentProgram.getSource());
        }

        public function getProgram3d():Program3D {
            return program3d;
        }

        public function getVertexParameter(name:String):MLSLConst {
            return vertexProgram.getParamter(name);
        }

        public function getFragmentParameter(name:String):MLSLConst {
            return fragmentProgram.getParamter(name);
        }

        public function setSamplerTexture(index:int, texture:Texture):void {
            fragmentProgram.setSamplerTexture(index, texture);
        }

        public function setVertexAttribute(semantic:String, vb:VertexBuffer3D, offset:int):void {
            var attr:MLSLAttr = vertexProgram.getAttribute(semantic);
            if (attr) {
                context3d.setVertexBufferAt(attr.index, vb, offset, attr.typeSize);
            }
        }

        public function bind():void {
            vertexProgram.bind();
            fragmentProgram.bind();
            context3d.setProgram(program3d);
        }

    }

}