# Cryptography: Techniques for Protecting Information

## 1. Aim

To understand and implement different cryptographic techniques used to protect information, including encryption, decryption, hashing, digital signatures, symmetric cryptography, and asymmetric cryptography.

## 2. Introduction

Cryptography is the science of protecting information by transforming it into a form that unauthorized people cannot easily understand. It is an important part of cybersecurity and data privacy because it helps protect information during storage and transmission.

Cryptographic techniques are commonly used in online banking, digital payments, secure communication, websites, email systems, databases, and software applications.

The major techniques studied in this project are encryption, decryption, hashing, digital signatures, symmetric cryptography, and asymmetric cryptography.

## 3. Objectives

The main objectives are:

1. To understand the basic concept of cryptography.
2. To understand encryption and decryption.
3. To understand hashing and its applications.
4. To understand digital signatures.
5. To differentiate between symmetric and asymmetric cryptography.
6. To implement basic cryptographic operations using Python.
7. To understand how cryptography contributes to data privacy and security.

## 4. What is Cryptography?

Cryptography is a technique for protecting information by converting readable information, called **plaintext**, into an unreadable form called **ciphertext**.

The general process is:

**Plaintext → Encryption → Ciphertext**

To recover the original information:

**Ciphertext → Decryption → Plaintext**

Example:

**Plaintext:**
`Hello World`

**Encrypted Data:**
`[Unreadable encrypted data]`

**Decrypted Data:**
`Hello World`

Cryptography provides important security properties such as confidentiality, integrity, authentication, and non-repudiation, depending on the cryptographic mechanism used.

## 5. Encryption

Encryption converts plaintext into ciphertext using an encryption algorithm and a key.

### Example

Suppose the original message is:

`My Password`

After encryption, the result becomes an unreadable ciphertext.

Only someone with the appropriate key can decrypt the ciphertext and recover the original message.

### Uses of Encryption

Encryption is used in:

* Secure websites
* Online banking
* Messaging applications
* Cloud storage
* Database protection
* File protection

## 6. Decryption

Decryption is the reverse process of encryption.

It converts ciphertext back into the original plaintext using the appropriate key.

**Ciphertext → Decryption → Plaintext**

For example:

`Encrypted data → Decryption → My Password`

## 7. Hashing

Hashing converts input data into a fixed-length value called a **hash** or **digest**.

Unlike encryption, a cryptographic hash is designed to be one-way. There is normally no decryption operation that recovers the original input from the hash.

For example:

```text
Input:
Hello World

SHA-256:
A591A6D40BF420404A011733CFB7B190D62C65BF0BCDA32B57B277D9AD9F146E
```

Even a small change in the input produces a substantially different hash.

### Uses of Hashing

Hashing is commonly used for:

1. Password verification
2. File integrity checking
3. Digital signatures
4. Data integrity verification
5. Detecting unauthorized modification

## 8. Digital Signatures

A digital signature is a cryptographic mechanism used to provide authenticity and integrity for digital information.

In a simplified model:

**Message → Hash → Digital Signature**

The sender signs the hash using a private key.

The receiver can use the corresponding public key to verify the signature.

Digital signatures can help demonstrate:

* Who signed the information
* Whether the signed information was modified
* That the signature corresponds to the holder of the private key

## 9. Symmetric Cryptography

In symmetric cryptography, the same secret key is used for encryption and decryption.

```text
             Secret Key
                 ↓
Plaintext → Encryption → Ciphertext
                 ↓
             Decryption
                 ↓
              Plaintext
```

### Examples

* AES
* ChaCha20

### Advantages

* Fast
* Suitable for large amounts of data
* Efficient for file and storage encryption

### Limitation

The communicating parties need a secure way to establish or share the secret key.

## 10. Asymmetric Cryptography

Asymmetric cryptography uses a pair of mathematically related keys:

1. Public key
2. Private key

The public key can be shared, while the private key should be kept secret.

For encryption:

```text
Plaintext
    ↓
Encrypt using Public Key
    ↓
Ciphertext
    ↓
Decrypt using Private Key
    ↓
Plaintext
```

For digital signatures, the private key is used for signing and the corresponding public key is used for verification.

### Examples

* RSA
* Elliptic Curve Cryptography (ECC)

### Advantages

* Helps solve the key distribution problem
* Supports digital signatures
* Public keys can be distributed openly

### Limitation

It is generally more computationally expensive than symmetric encryption.

## 11. Symmetric vs Asymmetric Cryptography

| Feature            | Symmetric                          | Asymmetric                         |
| ------------------ | ---------------------------------- | ---------------------------------- |
| Keys               | One shared secret key              | Public and private key pair        |
| Speed              | Generally faster                   | Generally slower                   |
| Large data         | Suitable                           | Less suitable for bulk data        |
| Key distribution   | More difficult                     | Easier for public-key distribution |
| Digital signatures | Not normally used for this purpose | Commonly used                      |
| Examples           | AES, ChaCha20                      | RSA, ECC                           |

## 12. Python Implementation

The following program demonstrates:

1. Symmetric encryption and decryption
2. SHA-256 hashing
3. RSA key generation
4. RSA encryption and decryption
5. RSA digital signing and signature verification

### Required Library

Install the `cryptography` library using:

```bash
pip install cryptography
```

### Python Program

```python
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives import serialization
import hashlib

# ---------------------------------------
# 1. SYMMETRIC ENCRYPTION AND DECRYPTION
# ---------------------------------------

message = b"Data Privacy and Cryptography"

# Generate secret key
symmetric_key = Fernet.generate_key()

# Create Fernet cipher
cipher = Fernet(symmetric_key)

# Encrypt
encrypted_message = cipher.encrypt(message)

# Decrypt
decrypted_message = cipher.decrypt(encrypted_message)

print("----- Symmetric Encryption -----")
print("Original Message :", message.decode())
print("Encrypted Message:", encrypted_message.decode())
print("Decrypted Message:", decrypted_message.decode())


# ---------------------------------------
# 2. HASHING USING SHA-256
# ---------------------------------------

hash_value = hashlib.sha256(message).hexdigest()

print("\n----- SHA-256 Hashing -----")
print("Original Message:", message.decode())
print("SHA-256 Hash     :", hash_value)


# ---------------------------------------
# 3. RSA KEY GENERATION
# ---------------------------------------

private_key = rsa.generate_private_key(
    public_exponent=65537,
    key_size=2048
)

public_key = private_key.public_key()


# ---------------------------------------
# 4. RSA ENCRYPTION AND DECRYPTION
# ---------------------------------------

rsa_encrypted = public_key.encrypt(
    message,
    padding.OAEP(
        mgf=padding.MGF1(algorithm=hashes.SHA256()),
        algorithm=hashes.SHA256(),
        label=None
    )
)

rsa_decrypted = private_key.decrypt(
    rsa_encrypted,
    padding.OAEP(
        mgf=padding.MGF1(algorithm=hashes.SHA256()),
        algorithm=hashes.SHA256(),
        label=None
    )
)

print("\n----- Asymmetric Encryption (RSA) -----")
print("Original Message :", message.decode())
print("Encrypted Message:", rsa_encrypted.hex())
print("Decrypted Message:", rsa_decrypted.decode())


# ---------------------------------------
# 5. DIGITAL SIGNATURE
# ---------------------------------------

signature = private_key.sign(
    message,
    padding.PSS(
        mgf=padding.MGF1(hashes.SHA256()),
        salt_length=padding.PSS.MAX_LENGTH
    ),
    hashes.SHA256()
)

print("\n----- Digital Signature -----")
print("Digital Signature:", signature.hex())

try:
    public_key.verify(
        signature,
        message,
        padding.PSS(
            mgf=padding.MGF1(hashes.SHA256()),
            salt_length=padding.PSS.MAX_LENGTH
        ),
        hashes.SHA256()
    )

    print("Signature Verification: SUCCESS")

except Exception:
    print("Signature Verification: FAILED")
```

## 13. Explanation of the Program

### Step 1: Generate a Symmetric Key

```python
symmetric_key = Fernet.generate_key()
```

This generates a secret key used by the symmetric encryption algorithm.

### Step 2: Encrypt the Message

```python
encrypted_message = cipher.encrypt(message)
```

The original message is converted into ciphertext.

### Step 3: Decrypt the Message

```python
decrypted_message = cipher.decrypt(encrypted_message)
```

The ciphertext is converted back into the original message using the secret key.

### Step 4: Generate SHA-256 Hash

```python
hash_value = hashlib.sha256(message).hexdigest()
```

This creates a SHA-256 digest of the message.

### Step 5: Generate RSA Keys

```python
private_key = rsa.generate_private_key(...)
public_key = private_key.public_key()
```

The program creates an RSA private key and its corresponding public key.

### Step 6: RSA Encryption

The public key encrypts the message:

```python
rsa_encrypted = public_key.encrypt(...)
```

The private key then decrypts it.

### Step 7: Create Digital Signature

The private key signs the message:

```python
signature = private_key.sign(...)
```

The corresponding public key verifies the signature.

## 14. Sample Output

The encrypted values and RSA signature will be different each time because secure cryptographic algorithms use random values.

A typical output will look like:

```text
----- Symmetric Encryption -----
Original Message : Data Privacy and Cryptography
Encrypted Message: gAAAAAB...
Decrypted Message: Data Privacy and Cryptography

----- SHA-256 Hashing -----
Original Message: Data Privacy and Cryptography
SHA-256 Hash     : 8c...different hash value...

----- Asymmetric Encryption (RSA) -----
Original Message : Data Privacy and Cryptography
Encrypted Message: 3a7f...encrypted hexadecimal data...
Decrypted Message: Data Privacy and Cryptography

----- Digital Signature -----
Digital Signature: 9f2a...signature data...
Signature Verification: SUCCESS
```

## 15. Security Analysis

The techniques demonstrated in this project provide different security functions.

| Technique               | Main Purpose                         |
| ----------------------- | ------------------------------------ |
| Encryption              | Confidentiality                      |
| Decryption              | Recovery of encrypted information    |
| Hashing                 | Integrity and verification           |
| Digital Signature       | Authentication and integrity         |
| Symmetric Cryptography  | Efficient data encryption            |
| Asymmetric Cryptography | Public-key encryption and signatures |

No single technique provides every security property by itself. Real-world systems commonly combine multiple cryptographic mechanisms.

For example, secure communication protocols can use asymmetric cryptography for authentication or key establishment and symmetric cryptography for efficient encryption of the actual data.

## 16. Applications of Cryptography

Cryptography is used in many real-world applications:

1. Online banking
2. Digital payments
3. HTTPS websites
4. Secure messaging
5. Password protection
6. Digital certificates
7. Cloud storage
8. Electronic documents
9. Software security
10. Digital signatures
11. Virtual private networks
12. Database security

## 17. Advantages of Cryptography

1. Protects confidential information.
2. Helps prevent unauthorized access.
3. Helps detect data modification.
4. Supports authentication.
5. Enables secure communication.
6. Supports digital signatures.
7. Protects information during transmission and storage.

## 18. Limitations

1. Strong cryptography depends on proper key management.
2. Losing encryption keys can result in loss of access to encrypted information.
3. Poor password or key management can weaken security.
4. Incorrect implementation can introduce vulnerabilities.
5. Asymmetric cryptography can require more computational resources than symmetric encryption.

## 19. Result

The cryptographic techniques were studied and implemented successfully using Python. Symmetric encryption and decryption were demonstrated using a secret key, SHA-256 was used to generate a cryptographic hash, RSA was used to demonstrate asymmetric encryption and decryption, and a digital signature was created and successfully verified.

## 20. Conclusion

Cryptography is an essential technology for protecting digital information. Encryption provides confidentiality, hashing helps verify data integrity, and digital signatures provide mechanisms for authentication and integrity verification.

Symmetric cryptography is efficient for protecting large amounts of data, while asymmetric cryptography provides public-key mechanisms and supports digital signatures. By combining these techniques appropriately, modern computer systems can provide strong protection for sensitive information.

The Python implementation demonstrates the basic operation of these techniques and shows how cryptography contributes to data privacy and cybersecurity.
