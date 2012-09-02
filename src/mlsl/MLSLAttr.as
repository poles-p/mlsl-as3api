package mlsl {
    import flash.display3D.Context3DVertexBufferFormat;

    public class MLSLAttr {
        public static const POSITION:String = 'POSITION';
        public static const TEXCOORD0:String = 'TEXCOORD0';

        public static const stage3dBufferTypeName:Object = {
            'vec2': Context3DVertexBufferFormat.FLOAT_2,
            'vec3': Context3DVertexBufferFormat.FLOAT_3,
            'vec4': Context3DVertexBufferFormat.FLOAT_4
        };

        public static const indexBySemantic:Object = {
            POSITION: 0,
            TEXCOORD0: 4
        };

        public var semantic:String;
        public var typeHint:String;
        public var typeSize:String;
        public var index:int;

        public function MLSLAttr(semantic:String, type:String) {
            this.semantic = semantic;
            typeHint = type;
            typeSize = stage3dBufferTypeName[type];
            index = indexBySemantic[semantic];
        }
    }

}