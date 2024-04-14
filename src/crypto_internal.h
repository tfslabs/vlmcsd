#ifndef __crypto_internal_h
#define __crypto_internal_h

#if !defined(_CRYPTO_OPENSSL) && !defined(_CRYPTO_POLARSSL) && !defined(_CRYPTO_WINDOWS)

#ifndef CONFIG
#define CONFIG "config.h"
#endif // CONFIG
#include CONFIG

#include "crypto.h"

typedef struct {
	DWORD  State[8];
	BYTE   Buffer[64];
	unsigned int  Len;
} Sha256Ctx;

typedef struct {
	Sha256Ctx  ShaCtx;
	BYTE  OPad[64];
} Sha256HmacCtx;

void Sha256(BYTE *data, size_t len, BYTE *hash);
int_fast8_t Sha256Hmac(BYTE* key, BYTE* restrict data, DWORD len, BYTE* restrict hmac);

#endif

#endif