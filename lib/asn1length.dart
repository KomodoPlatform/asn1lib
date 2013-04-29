
part of asn1lib;

/**
 * Class to encode /decode ASN1 length bytes.
 * Also used to return the pair (length, valueStartPosition)
 */

class ASN1Length {

  int _length;
  /// the decoded length
  int get length => _length;

  int _valueStartPosition;
  /// The decoded value start position. This is the offset in the
  /// BER encoded array where the value bytes start
  int get valueStartPosition => _valueStartPosition;


  ASN1Length(this._length,this._valueStartPosition);


  /**
   * Encode a BER length - into 1 to 5 bytes as appropriate
   * Values less than <= 127 are encoded in a single byte
   * If the value is larger than 127, the first byte
   * contains 0x80 + the number of following bytes used to represent the length
   * The length is encoded by the *fewest* number of bytes possible - treated
   * as an unsigned binary value.
   *
   * This is a static method that has no side effect on an object. The
   * returned bytes can be copied into an encoded represenation of an object.
   */

  static Uint8List encodeLength(int length) {
   Uint8List e;
    if( length <= 127 ) {
      e = new Uint8List(1);
      e[0] = length;
    }
    else {
      var x = new Uint32List(1);
      x[0] = length;
      var y = new Uint8List.view(x.buffer);
      // skip null bytes
      int num = 3;
      while( y[num]  == 0)
        --num;
      e = new Uint8List(num+2);
      e[0] = 0x80 + num+1;
      for(int i=1; i < e.length; ++i)
        e[i] = y[num--];
    }
    return e;
  }


  /**
   * Decode the length from the encoded bytes representing this object.
   * This method has no side effect on an object
   * Returns the ASN1Length  (length,valueStartPosition).
   * The first byte is the tag
   * THe length starts at the second byte.
   *
   */
  static ASN1Length decodeLength(Uint8List encodedBytes) {
    int valueStartPosition = 2; //default
    int length = (encodedBytes[1] & 0x7F);
    if (length != encodedBytes[1])
    {
      int numLengthBytes = length;

      length = 0;
      for (int i=0; i < numLengthBytes; i++)
      {
        length <<= 8;
        length |= (encodedBytes[valueStartPosition++] & 0xFF);
      }
    }
  /*
   *
   *  we cant do this check here!! the parser might not pass the entire object - because it does not
   *  yet know the length
      if ((encodedBytes.length - valueStartPosition) != length)
    {
      throw new ASN1Exception("Length Encoding Error");
    }
    */
    return new ASN1Length(length,valueStartPosition);
  }



}
