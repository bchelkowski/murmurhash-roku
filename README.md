# murmurhash-roku

BrightScript implementation of MurmurHash

The implementation is based on the following definition:
https://en.wikipedia.org/wiki/MurmurHash#Algorithm

## Installation

### with kopytko-packager

When using [kopytko-packager](https://github.com/getndazn/kopytko-packager) you can simly define this package as a dependecy.

`npm i murmurhash-roku`

### without kopytko-packager

Copy `MurmurHash.brs` file from this repository to your project.

**Remember that it uses also the `getType` function from the `kopytko-utils`, [so copy it along with it](https://github.com/getndazn/kopytko-utils/blob/master/src/components/getType.brs), or create a similar one.**

## Usage

```brightscript
' @import /components/libs/MurmurHash.brs from murmurhash-roku

function get123Hash() as LongInteger
  return MurmurHash().v3("123", 1)
end function
```

## Documentation

Currently, there is only one hash method - v3.
It generates MurmurHash v3.
As Brightscript has only 32 or 64 signed values (Integer and LongInteger) this supports only 32-bit generation.

`MurmurHash().v3(key, seed)`

params:

- key - String or ByteArray to be hashed
- seed - accepts LongInteger, but it can be also an Integer

returns: (**LongInteger**) hashed value **LongInteger** value hash
