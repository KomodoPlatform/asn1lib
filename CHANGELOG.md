# Changelog

## 0.5.5

Merged #27

Updates to ASN1ObjectIdentifier to:

* allow creation from dotted number lists
* allow creation from dotted number strings
* allow names to be registered, for shorthands
* allow bulk name registration
* commonly used names (obviously, what this is could be expanded)

## 0.5.4

Fixed #26

## 0.5.1 

Add AS1Integer.fromInt factory method
 
## 0.5.0 

* Convert use of BigInteger to dart SDK BigInt

## 0.4.3 

* Updates for dart 2


## 0.4.2

* Added `contentBytes()` getter
* Removed Int64List dependency and use bignum's BigInteger instead
 