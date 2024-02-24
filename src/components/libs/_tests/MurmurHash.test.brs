' @import /components/KopytkoTestSuite.brs from @dazn/kopytko-unit-testing-framework

function TestSuite__MurmurHash() as Object
  ts = KopytkoTestSuite()
  ts.name = "MurmurHash"

  testEach([
    { value: "", seed: 1, expected: 1364076727& },
    { value: " ", seed: 1, expected: 1326412082& },
    { value: "Hello", seed: 1, expected: 1249628312& },
    { value: "World", seed: 1, expected: 2164473359& },
    { value: "aaaaaa", seed: 1, expected: 1023937615& },
    { value: "aa", seed: 1, expected: 1856470207& },
    { value: "a", seed: 1, expected: 1485495528& },
    { value: "123.foo", seed: 1, expected: 135334774& },
    { value: "123", seed: 1, expected: 301691705& },
    { value: "Hel", seed: 1, expected: 313003214& },
    { value: "akojnasdknlaksd", seed: 1, expected: 2690210248& },
    { value: "buuiujnbwiouencaceaeae", seed: 1, expected: 3265375730& },
    { value: "Hello World", seed: 123, expected: 3716828190& },
    { value: "Hello World", seed: 12312312312, expected: 3985241107& },
  ], "v3 - should generate ${expected} hash from value=${value} and seed=${seed}", function (_ts as Object, params as Object) as String
    ' When
    result = MurmurHash().v3(params.value, params.seed)

    ' Then
    return expect(result).toBe(params.expected)
  end function)

  test("v3 - should generate the same hash from string and byte array that reflect the same string values", function(_ts as Object) as String
    ' When
    stringValue = "abc"
    byteArrayValue = CreateObject("roByteArray")
    byteArrayValue.fromAsciiString(stringValue)
    stringHash = MurmurHash().v3(stringValue, 1)
    byteArrayHash = MurmurHash().v3(byteArrayValue, 1)

    'Then
    return expect(byteArrayHash).toBe(stringHash)
  end function)

  return ts
end function
