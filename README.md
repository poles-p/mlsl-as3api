mlsl-as3api
---------------
Goal of this lib is to bring mlsl feature to flash.
Flash Stage3D api lacks of higher level shading languages, while c-based ones just suck.
Programs are compiled from mlsl (ML-based shading language) source to agal bytecode or assembler with json file describing named paramaters.

MLSL project: (link as soon as possible)
---------------

simple mlsl shader:

// Const declarations
const projMatrix  : mat44

// Attributes declarations
attr POSITION  pos   : vec4
attr TEXCOORD0 coord : vec2

// Samplers declarations
sampler tex : sampler2D

// vertex shader
let vertex vs =
	{ position = projMatrix * pos
	; coord    = coord
	}

// fragment shader
let fragment fs =
	(tex $coord.yx).wzxw

let shader swizzle_shader= (vs, fs)