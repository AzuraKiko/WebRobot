from Cryptodome.Random import get_random_bytes
from Cryptodome.Cipher import AES
import base64
from hashlib import md5
from typing import Union, ByteString

BLOCK_SIZE = 16

def pad(data: ByteString) -> bytes:
    """
    Pad the data to be a multiple of BLOCK_SIZE using PKCS7 padding.
    
    Args:
        data: The data to pad
        
    Returns:
        Padded data as bytes
    """
    padding_length = BLOCK_SIZE - (len(data) % BLOCK_SIZE)
    return data + bytes([padding_length] * padding_length)

def unpad(data: ByteString) -> bytes:
    """
    Remove PKCS7 padding from the data.
    
    Args:
        data: The padded data
        
    Returns:
        Unpadded data as bytes
    """
    padding_length = data[-1] if isinstance(data[-1], int) else int(data[-1])

    return data[:-padding_length]

def bytes_to_key(data: ByteString, salt: ByteString, output: int = 48) -> bytes:
    """
    Derive a key from the given data and salt using MD5.
    
    Args:
        data: The input data
        salt: The salt (must be 8 bytes)
        output: The desired output length in bytes
        
    Returns:
        The derived key
    """
    if len(salt) != 8:
        raise ValueError(f"Salt must be 8 bytes, got {len(salt)}")
        
    data = data + salt
    key = md5(data).digest()
    final_key = bytearray(key)
    
    while len(final_key) < output:
        key = md5(key + data).digest()
        final_key.extend(key)
        
    return bytes(final_key[:output])

def encrypt(message: Union[str, ByteString], passphrase: Union[str, ByteString]) -> str:
    """
    Encrypt a message using AES-CBC with a passphrase.
    
    Args:
        message: The message to encrypt
        passphrase: The passphrase to use for encryption
        
    Returns:
        Base64 encoded encrypted message
    """
    if isinstance(message, str):
        message = message.encode()
    if isinstance(passphrase, str):
        passphrase = passphrase.encode()
        
    salt = get_random_bytes(8)
    key_iv = bytes_to_key(passphrase, salt, 32 + 16)
    key, iv = key_iv[:32], key_iv[32:]
    
    cipher = AES.new(key, AES.MODE_CBC, iv)
    encrypted = cipher.encrypt(pad(message))
    
    return base64.b64encode(b"Salted__" + salt + encrypted).decode('utf-8')
