package mlsl {
    import flash.display3D.Context3DVertexBufferFormat;

    public class MLSLAttr {
        public static const stage3dBufferTypeName:Object = {
            'vec2': Context3DVertexBufferFormat.FLOAT_2,
            'vec3': Context3DVertexBufferFormat.FLOAT_3,
            'vec4': Context3DVertexBufferFormat.FLOAT_4
        };

        public var name:String;
        public var typeHint:String;
        public var typeSize:String;
        public var register:int;

        public function MLSLAttr(name:String, type:String, register:int) {
            this.name = name;
            typeHint = type;
            typeSize = stage3dBufferTypeName[type];
            this.register = register;
        }
    }

}