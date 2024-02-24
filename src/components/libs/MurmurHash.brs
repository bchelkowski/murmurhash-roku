' @import /components/getType.brs from @dazn/kopytko-utils

function MurmurHash() as Object
  prototype = {}

  ' The implementation is based on the following definition:
  ' https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  ' Generates MurmurHash v3
  ' As Brightscript has only 32 or 64 signed values (Integer and LongInteger) this supports only 32-bit generation.
  ' @param {roString|roByteArray} key - String or ByteArray to be hashed
  ' @param {LongInteger} seed& - accepts LongInteger, but it can be also an Integer
  ' @returns {LongInteger}
  prototype.v3 = function (key as Dynamic, seed& as LongInteger) as LongInteger
    keyArray = key
    if (getType(key) = "roString")
      keyArray = CreateObject("roByteArray")
      keyArray.fromAsciiString(key)
    end if
  
    C1& = &hCC9E2D51&
    C2& = &h1B873593&
    MAX& = &hFFFFFFFF&
    ROTATION1 = 15
    ROTATION2 = 13
  
    hash& = seed& AND MAX&
    keyLength = keyArray.count()
    remainder = keyLength mod 4
    arraySizeDivisibleByFour = keyLength - remainder
  
    i = 0
    while i < arraySizeDivisibleByFour
      k& = keyArray[i] AND &hFF
      k& = (k& OR ((keyArray[i + 1] AND &hFF) << 8)) AND &hFFFF&
      k& = (k& OR ((keyArray[i + 2] AND &hFF) << 16)) AND &hFFFFFF&
      k& = (k& OR ((keyArray[i + 3] AND &hFF) << 24)) AND MAX&
  
      k& = (k& * C1&) AND MAX&
      k& = m._rotateLeft(k&, ROTATION1) AND MAX&
      k& = (k& * C2&) AND MAX&
  
      hash& = m._xor(hash&, k&) AND MAX&
      hash& = m._rotateLeft(hash&, ROTATION2) AND MAX&
      hash& = ((hash& * 5) + &hE6546B64&) AND MAX&
  
      i += 4
    end while
  
    remainingBytesInKey& = 0
    if (remainder = 3) then remainingBytesInKey& = (remainingBytesInKey& OR ((keyArray[keyLength - remainder + 2] AND &hFF) << 16)) AND MAX&
    if (remainder >= 2) then remainingBytesInKey& = (remainingBytesInKey& OR ((keyArray[keyLength - remainder + 1] AND &hFF) << 8)) AND MAX&
    if (remainder >= 1) then remainingBytesInKey& = (remainingBytesInKey& OR (keyArray[keyLength - remainder] AND &hFF)) AND MAX&
    remainingBytesInKey& = (remainingBytesInKey& * C1&) AND MAX&
    remainingBytesInKey& = m._rotateLeft(remainingBytesInKey&, ROTATION1) AND MAX&
    remainingBytesInKey& = (remainingBytesInKey& * C2&) AND MAX&
  
    hash& = m._xor(hash&, remainingBytesInKey&) AND MAX&
    hash& = m._xor(hash&, keyLength) AND MAX&
    hash& = m._xor(hash&, hash& >> 16) AND MAX&
    hash& = (hash& * &h85EBCA6B&) AND MAX&
    hash& = m._xor(hash&, hash& >> 13) AND MAX&
    hash& = (hash& * &hC2B2AE35&) AND MAX&
    hash& = m._xor(hash&, hash& >> 16) AND MAX&
  
    return hash&
  end function

  prototype._rotateLeft = function (value& as LongInteger, rotation as Integer) as LongInteger
    return (value& << rotation) OR (value& >> (32 - rotation))
  end function

  prototype._xor = function (a& as LongInteger, b& as LongInteger) as LongInteger
    return (a& OR b&) - (a& AND b&)
  end function

  return prototype
end function
