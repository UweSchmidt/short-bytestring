{-# LANGUAGE DeriveDataTypeable         #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

-- simulating ShortByteString from bytestring-0.10.4.*
-- used for strictnes tests with ghc-heap-view,
-- which runs only with ghc-7.6 and bytestring-0.10.0.2

module Data.ByteString.Short
where

import           Control.DeepSeq
import           Data.Binary
import qualified Data.ByteString as BS
import           Data.Typeable
-- import           Data.Word       (Word8)

-- ----------------------------------------

newtype ShortByteString
    = SBS {unSBS :: BS.ByteString}
      deriving (Binary, NFData, Eq, Ord, Read, Show, Typeable)

toShort :: BS.ByteString -> ShortByteString
toShort x = SBS $!! BS.copy x

fromShort :: ShortByteString -> BS.ByteString
fromShort = unSBS

pack :: [Word8] -> ShortByteString
pack = SBS . BS.pack

unpack :: ShortByteString -> [Word8]
unpack = BS.unpack . unSBS

empty :: ShortByteString
empty = SBS BS.empty

null :: ShortByteString -> Bool
null = BS.null . unSBS

length :: ShortByteString -> Int
length = BS.length . unSBS

index :: ShortByteString -> Int -> Word8
index s i = BS.index (unSBS s) i

-- ----------------------------------------
