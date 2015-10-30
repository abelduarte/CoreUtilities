# CoreUtilities

# CUDataReader
CUDataReader allows you to parse out an NSData object while automatically managing the offset
as you read and process the data.

CUDataReader allows you to parse out types such as int, float, char, double, and long. Using the
setEndianness method you can specify the byte order in which CUDataReader should parse the data.

CUDataReader allows you to read a specific length of characters and continue reading from where
you left off similar to a stream.

# NSMutableData+Queue
NSMutableData+Queue has some similar functionality to CUDataReader in the sense that it allows you to
read and continue reading from where you last left off. The only difference is that it automatically
removes the data from the NSMutableData object as it is returned.

# NSData+NSString
NSData+NSString allows you to conveniently convert from an NSData object to an NSString object without having
to manually allocate the string.
