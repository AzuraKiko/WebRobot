import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Base64;

public class AESCipher {
    private static final int BLOCK_SIZE = 16;

    // Pad data to a multiple of BLOCK_SIZE (PKCS7)
    public static byte[] pad(byte[] data) {
        int paddingLength = BLOCK_SIZE - (data.length % BLOCK_SIZE);
        byte[] padded = Arrays.copyOf(data, data.length + paddingLength);
        for (int i = data.length; i < padded.length; i++) {
            padded[i] = (byte) paddingLength;
        }
        return padded;
    }

    // Unpad PKCS7
    public static byte[] unpad(byte[] data) {
        int paddingLength = data[data.length - 1] & 0xff;
        return Arrays.copyOf(data, data.length - paddingLength);
    }

    // OpenSSL-compatible key derivation ("bytes_to_key") using MD5
    public static byte[] bytesToKey(byte[] pass, byte[] salt, int length) throws Exception {
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        byte[] data = new byte[pass.length + salt.length];
        System.arraycopy(pass, 0, data, 0, pass.length);
        System.arraycopy(salt, 0, data, pass.length, salt.length);
        byte[] key = md5.digest(data);
        byte[] finalKey = Arrays.copyOf(key, key.length);
        while (finalKey.length < length) {
            byte[] next = new byte[key.length + data.length];
            System.arraycopy(key, 0, next, 0, key.length);
            System.arraycopy(data, 0, next, key.length, data.length);
            key = md5.digest(next);
            byte[] tmp = new byte[finalKey.length + key.length];
            System.arraycopy(finalKey, 0, tmp, 0, finalKey.length);
            System.arraycopy(key, 0, tmp, finalKey.length, key.length);
            finalKey = tmp;
        }
        return Arrays.copyOf(finalKey, length);
    }

    public static String encrypt(String message, String passphrase) throws Exception {
        byte[] messageBytes = message.getBytes(StandardCharsets.UTF_8);
        byte[] passBytes = passphrase.getBytes(StandardCharsets.UTF_8);
        // Random salt (8 bytes)
        byte[] salt = new byte[8];
        new SecureRandom().nextBytes(salt);
        // Key and IV derivation: 32 + 16 = 48 bytes
        byte[] keyIv = bytesToKey(passBytes, salt, 32 + 16);
        byte[] key = Arrays.copyOfRange(keyIv, 0, 32); // 256 bits
        byte[] iv = Arrays.copyOfRange(keyIv, 32, 48); // 128 bits
        Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
        byte[] padded = pad(messageBytes);
        cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(key, "AES"), new IvParameterSpec(iv));
        byte[] encrypted = cipher.doFinal(padded);
        // 'Salted__' + salt + encrypted (OpenSSL compat)
        byte[] out = new byte[8 + 8 + encrypted.length];
        System.arraycopy("Salted__".getBytes(StandardCharsets.US_ASCII), 0, out, 0, 8);
        System.arraycopy(salt, 0, out, 8, 8);
        System.arraycopy(encrypted, 0, out, 16, encrypted.length);
        return Base64.getEncoder().encodeToString(out);
    }

    // For demonstration: main()
    public static void main(String[] args) throws Exception {
        String message = "Hello, Java!";
        String passphrase = "MyTestPass";
        String encrypted = encrypt(message, passphrase);
        System.out.println("Encrypted: " + encrypted);
    }
}