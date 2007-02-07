From: "Dailey, Nate" <Nate.Dailey@stratus.com>
Subject: [PATCH 2.6.20] sata_vsc: use default cache line size if non-zero
Date: Wed, 7 Feb 2007 09:29:28 -0500
Message-ID: <92952AEF1F064042B6EF2522E0EEF43703EE31CC@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C74AC4.5FDA2621"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub5.stratus.com ([134.111.1.18]:43257 "EHLO
	mailhub5.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161339AbXBGO3b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Feb 2007 09:29:31 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeremy Higdon <jeremy@sgi.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74AC4.5FDA2621
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attached patch modifies drivers/ata/sata_vsc.c to only set the cache
line size to 0x80 if the default value is zero. Apparently zero isn't
allowed due to a bug in the chip, but I've found performance is much
better with the (non-zero) default instead of 0x80.

Signed-off-by: Nate Dailey <nate.dailey@stratus.com>

------_=_NextPart_001_01C74AC4.5FDA2621
Content-Type: application/octet-stream;
	name="sata_vsc_CLS.patch"
Content-Transfer-Encoding: base64
Content-Description: sata_vsc_CLS.patch
Content-Disposition: attachment;
	filename="sata_vsc_CLS.patch"

LS0tIG9sZC9kcml2ZXJzL2F0YS9zYXRhX3ZzYy5jCTIwMDctMDItMDQgMTM6NDQ6NTQuMDAwMDAw
MDAwIC0wNTAwCisrKyBuZXcvZHJpdmVycy9hdGEvc2F0YV92c2MuYwkyMDA3LTAyLTA3IDA5OjEz
OjE3LjAwMDAwMDAwMCAtMDUwMApAQCAtMzQ1LDYgKzM0NSw3IEBAIHN0YXRpYyBpbnQgX19kZXZp
bml0IHZzY19zYXRhX2luaXRfb25lICgKIAlpbnQgcGNpX2Rldl9idXN5ID0gMDsKIAl2b2lkIF9f
aW9tZW0gKm1taW9fYmFzZTsKIAlpbnQgcmM7CisJdTggY2xzOwogCiAJaWYgKCFwcmludGVkX3Zl
cnNpb24rKykKIAkJZGV2X3ByaW50ayhLRVJOX0RFQlVHLCAmcGRldi0+ZGV2LCAidmVyc2lvbiAi
IERSVl9WRVJTSU9OICJcbiIpOwpAQCAtMzk0LDkgKzM5NSwxMyBAQCBzdGF0aWMgaW50IF9fZGV2
aW5pdCB2c2Nfc2F0YV9pbml0X29uZSAoCiAJYmFzZSA9ICh1bnNpZ25lZCBsb25nKSBtbWlvX2Jh
c2U7CiAKIAkvKgotCSAqIER1ZSB0byBhIGJ1ZyBpbiB0aGUgY2hpcCwgdGhlIGRlZmF1bHQgY2Fj
aGUgbGluZSBzaXplIGNhbid0IGJlIHVzZWQKKwkgKiBEdWUgdG8gYSBidWcgaW4gdGhlIGNoaXAs
IHRoZSBkZWZhdWx0IGNhY2hlIGxpbmUgc2l6ZSBjYW4ndCBiZQorCSAqIHVzZWQgKHVubGVzcyB0
aGUgZGVmYXVsdCBpcyBub24temVybykuCiAJICovCi0JcGNpX3dyaXRlX2NvbmZpZ19ieXRlKHBk
ZXYsIFBDSV9DQUNIRV9MSU5FX1NJWkUsIDB4ODApOworCXBjaV9yZWFkX2NvbmZpZ19ieXRlKHBk
ZXYsIFBDSV9DQUNIRV9MSU5FX1NJWkUsICZjbHMpOworCWlmIChjbHMgPT0gMHgwMCkgeworCQlw
Y2lfd3JpdGVfY29uZmlnX2J5dGUocGRldiwgUENJX0NBQ0hFX0xJTkVfU0laRSwgMHg4MCk7CisJ
fQogCiAJcHJvYmVfZW50LT5zaHQgPSAmdnNjX3NhdGFfc2h0OwogCXByb2JlX2VudC0+cG9ydF9m
bGFncyA9IEFUQV9GTEFHX1NBVEEgfCBBVEFfRkxBR19OT19MRUdBQ1kgfAo=

------_=_NextPart_001_01C74AC4.5FDA2621--
