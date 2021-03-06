mlsl-as3api
---------------
Goal of this lib is to bring mlsl feature to flash.
Flash Stage3D api lacks of higher level shading languages, while c-based ones aren't cool enough.
Programs are compiled from mlsl (ML-based shading language) source to agal bytecode or assembler with json file describing named paramaters.

MLSL
---------------
MLSL repo, language reference and stuff: https://github.com/poles-p/mlsl

Example
---------------

```ocaml
// Const declarations
const projMatrix  : mat44

// Attributes declarations
attr pos   : vec2
attr texcoord : vec2

// Samplers declarations
sampler diffuse : sampler2D

// vertex shader
let vertex vs =
	{ position = projMatrix * pos
	; coord    = texcoord
	}

// fragment shader
let fragment fs =
	(diffuse $coord.yx).wzxw

let shader swizzle_shader= (vs, fs)
```

How to
---------------

Initialization:

```actionscript
// load vertex program
var vertexProgram:MLSLVertexProgram = new MLSLVertexProgram();
vertexProgram.loadFromJSON(vpJsonString);

// load fragment program
var fragmentProgram:MLSLFragmentProgram = new MLSLFragmentProgram();
fragmentProgram.loadFromJSON(fpJsonString);

// create program and link vertex with fragment
var program:MLSLProgram = new MLSLProgram(context3d);
program.link(vertexProgram, fragmentProgram);
```

Binding constants and textures:
```actionscript
// set paramater value. casting is necessary atm
program.getVertexParameter('projMatrix').setValueFromMatrix3D(screenMatrix);

program.setSamplerTexture('diffuse', texture);

// set-up vertex buffer attributes using a so called semantics, similar to HLSL/Cg.
program.setVertexAttribute('pos', vertBuf, 0);
program.setVertexAttribute('texcoord', vertBuf, 2);

// bind program itself:
program.bind();

// draw whatever you want
```