package {
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display3D.Context3D;
    import flash.display3D.Context3DTextureFormat;
    import flash.display3D.IndexBuffer3D;
    import flash.display3D.textures.Texture;
    import flash.display3D.VertexBuffer3D;
    import flash.events.Event;
    import flash.geom.Matrix3D;
    import flash.geom.Vector3D;
    import flash.utils.ByteArray;
    import mlsl.MLSLAttr;
    import mlsl.MLSLConst;
    import mlsl.MLSLConstMat44;
    import mlsl.MLSLFragmentProgram;
    import mlsl.MLSLProgram;
    import mlsl.MLSLVertexProgram;
    import mx.core.ByteArrayAsset;

    /**
     * ...
     * @author mosowski
     */
    public class Main extends Sprite {
        [Embed(source="../asset/sampler_test_fp.json",mimeType="application/octet-stream")]
        public var fpJsonClass:Class;
        [Embed(source="../asset/sampler_test_vp.json",mimeType="application/octet-stream")]
        public var vpJsonClass:Class;
        [Embed(source = "../asset/tex.jpg")]
        public var texClass:Class;

        public var context3d:Context3D;
        public var screenMtx:Matrix3D;
        public var vertBuf:VertexBuffer3D;
        public var indBuf:IndexBuffer3D;
        public var texture:Texture;
        public var prog:MLSLProgram;


        public function Main():void {
            if (stage)
                init();
            else
                addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event = null):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContext3dCreate);
            stage.stage3Ds[0].requestContext3D();
        }

        private function onContext3dCreate(e:Event):void {
            context3d = stage.stage3Ds[0].context3D;
            context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);

            screenMtx = new Matrix3D();
            screenMtx.appendScale(2 / stage.stageWidth, -2 / stage.stageHeight, 1);
            screenMtx.appendTranslation( -1, 1, 0);

            var vsJson:String = (new vpJsonClass() as ByteArrayAsset).toString();
            var fsJson:String = (new fpJsonClass() as ByteArrayAsset).toString();

            MLSLConst.init();

            prog = new MLSLProgram(context3d);
            var vertexProgram:MLSLVertexProgram = new MLSLVertexProgram();
            vertexProgram.loadFromJSON(vsJson);
            var fragmentProgram:MLSLFragmentProgram = new MLSLFragmentProgram();
            fragmentProgram.loadFromJSON(fsJson);
            
            prog.link(vertexProgram, fragmentProgram);

            vertBuf = context3d.createVertexBuffer(4, 4 );
            vertBuf.uploadFromVector(new <Number>[
            0, 0,   0, 0,
            512, 0,  1, 0,
            512, 512, 1, 1,
            0, 512,  0, 1
            ], 0, 4);

            indBuf = context3d.createIndexBuffer(6);
            indBuf.uploadFromVector(new <uint>[0, 1, 2, 2, 3, 0], 0, 6);

            var texBitmap:Bitmap = new texClass();
            texture = context3d.createTexture(texBitmap.width, texBitmap.height, Context3DTextureFormat.BGRA, false);
            texture.uploadFromBitmapData(texBitmap.bitmapData);

            stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(e:Event):void {
            context3d.clear();

            (prog.getVertexParameter('projMatrix') as MLSLConstMat44).setValue(screenMtx);

            prog.setSamplerTexture("tex", texture);
            prog.setVertexAttribute("pos", vertBuf, 0);
            prog.setVertexAttribute("coord", vertBuf, 2);

            prog.bind();

            context3d.drawTriangles(indBuf);

            context3d.present();

        }

    }

}