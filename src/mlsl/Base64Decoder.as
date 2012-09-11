/*
Copyright (C) 2012, Piotr Polesiuk

Permission is hereby granted, free of charge, to any person obtaining a copy 
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights 
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
*/

package mlsl
{
	import flash.utils.ByteArray;

	public class Base64Decoder 	{
		public static function decode(base64String:String) : ByteArray {
			var decoder : Base64Decoder = new Base64Decoder(base64String);
			return decoder.decodeToByteArray();
		}

		private var base64String : String;
		private var position : int;

		public function Base64Decoder(base64String:String) {
			this.base64String = base64String;
		}

		public function decodeToByteArray() : ByteArray {
			position = 0;

			var result : ByteArray = new ByteArray();
			var c1 : int;
			var c2 : int;
			var c3 : int;
			var c4 : int;

			while (true) {
				if ((c1 = nextValue()) == -1)
					return result;
				if ((c2 = nextValue()) == -1)
					return result;
				result.writeByte((c1 << 2) | (c2 >> 4));
				if ((c3 = nextValue()) == -1)
					return result;
				result.writeByte(((c2 & 0x0F) << 4) | (c3 >> 2));
				if ((c4 = nextValue()) == -1)
					return result;
				result.writeByte(((c3 & 0x03) << 6) | c4);
			}

			return result;
		}

		private function nextValue() : int {
			while (true) {
				if (position >= base64String.length)
					return -1;
				var c:int = base64String[position++];
				if (c == 61)
					return -1;
				else if (char_map[c] != -1)
					return char_map[c];
			}
			return -1;
		}
		
		private const char_map:Vector.<int> = new <int>
			[ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
			, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
			, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63
			, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1
			, -1,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14
			, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1
			, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40
			, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1
			];
	}
}
