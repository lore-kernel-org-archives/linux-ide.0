From: <Stuart_Hayes@Dell.com>
Subject: RE: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Fri, 29 Apr 2005 10:45:13 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EEC07@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C54CD2.6EEFB7B0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:32789 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262802AbVD2PpQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Apr 2005 11:45:16 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C54CD2.6EEFB7B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Bartlomiej Zolnierkiewicz wrote:
> On Apr 5, 2005 11:08 PM, Stuart_Hayes@dell.com
> <Stuart_Hayes@dell.com> wrote:=20
>=20
>> How is this?  I already had the "flags" declarations at the beginning
>> of the functions, but I wrapped them and the irq disable/enables in
>> the
>=20
> I mean at the very beginning but lets leave it as it is.
>=20
>> HIGHMEM ifdef, like ide_pio_sector() in ide-taskfile.c.
>=20
> thanks
>=20
> Bartlomiej

Bart --

With more testing, I've discovered a problem with thin patch--I used the
"KM_USER0" window for kmap_atomic(), but that's apparently not safe to
use in an interrupt handler, because there are places in the kernel
where KM_USER0 is used without masking interrupts (see
include/linux/highmem.h for several examples).  This patch is identical
to the previous one I sent in, except it uses the KM_IRQ0 window, which=20
I verified is not used anywhere without IRQs masked.

This patch is against 2.6.11.7... the latest kernel on kernel.org didn't
yet have the previous patch I submitted.  If it would be more useful, I
can make this patch against an ide-scsi.c that already has my previous
patch applied--I wasn't sure which would be better.

Thanks!
Stuart



------_=_NextPart_001_01C54CD2.6EEFB7B0
Content-Type: application/octet-stream;
	name="ide-scsi.2.6.11.7.try5.patch"
Content-Transfer-Encoding: base64
Content-Description: ide-scsi.2.6.11.7.try5.patch
Content-Disposition: attachment;
	filename="ide-scsi.2.6.11.7.try5.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMTEuNy9kcml2ZXJzL3Njc2kvaWRlLXNjc2kuYyBsaW51eC0y
LjYuMTEuN21vZHMvZHJpdmVycy9zY3NpL2lkZS1zY3NpLmMKLS0tIGxpbnV4LTIuNi4xMS43L2Ry
aXZlcnMvc2NzaS9pZGUtc2NzaS5jCTIwMDUtMDQtMDcgMTQ6NTc6NDYuMDAwMDAwMDAwIC0wNDAw
CisrKyBsaW51eC0yLjYuMTEuN21vZHMvZHJpdmVycy9zY3NpL2lkZS1zY3NpLmMJMjAwNS0wNC0y
OSAxMToxMjoyMi4wMDAwMDAwMDAgLTA0MDAKQEAgLTE0Myw2ICsxNDMsNyBAQCBzdGF0aWMgdm9p
ZCBpZGVzY3NpX2lucHV0X2J1ZmZlcnMgKGlkZV9kCiB7CiAJaW50IGNvdW50OwogCWNoYXIgKmJ1
ZjsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwogCiAJd2hpbGUgKGJjb3VudCkgewogCQlpZiAocGMt
PnNnIC0gKHN0cnVjdCBzY2F0dGVybGlzdCAqKSBwYy0+c2NzaV9jbWQtPnJlcXVlc3RfYnVmZmVy
ID4gcGMtPnNjc2lfY21kLT51c2Vfc2cpIHsKQEAgLTE1MSw4ICsxNTIsMTEgQEAgc3RhdGljIHZv
aWQgaWRlc2NzaV9pbnB1dF9idWZmZXJzIChpZGVfZAogCQkJcmV0dXJuOwogCQl9CiAJCWNvdW50
ID0gbWluKHBjLT5zZy0+bGVuZ3RoIC0gcGMtPmJfY291bnQsIGJjb3VudCk7Ci0JCWJ1ZiA9IHBh
Z2VfYWRkcmVzcyhwYy0+c2ctPnBhZ2UpICsgcGMtPnNnLT5vZmZzZXQ7CisJCWxvY2FsX2lycV9z
YXZlKGZsYWdzKTsKKwkJYnVmID0ga21hcF9hdG9taWMocGMtPnNnLT5wYWdlLCBLTV9JUlEwKSAr
IHBjLT5zZy0+b2Zmc2V0OwogCQlkcml2ZS0+aHdpZi0+YXRhcGlfaW5wdXRfYnl0ZXMoZHJpdmUs
IGJ1ZiArIHBjLT5iX2NvdW50LCBjb3VudCk7CisJCWt1bm1hcF9hdG9taWMoYnVmIC0gcGMtPnNn
LT5vZmZzZXQsIEtNX0lSUTApOworCQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7CiAJCWJjb3Vu
dCAtPSBjb3VudDsgcGMtPmJfY291bnQgKz0gY291bnQ7CiAJCWlmIChwYy0+Yl9jb3VudCA9PSBw
Yy0+c2ctPmxlbmd0aCkgewogCQkJcGMtPnNnKys7CkBAIC0xNjUsNiArMTY5LDcgQEAgc3RhdGlj
IHZvaWQgaWRlc2NzaV9vdXRwdXRfYnVmZmVycyAoaWRlXwogewogCWludCBjb3VudDsKIAljaGFy
ICpidWY7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKIAogCXdoaWxlIChiY291bnQpIHsKIAkJaWYg
KHBjLT5zZyAtIChzdHJ1Y3Qgc2NhdHRlcmxpc3QgKikgcGMtPnNjc2lfY21kLT5yZXF1ZXN0X2J1
ZmZlciA+IHBjLT5zY3NpX2NtZC0+dXNlX3NnKSB7CkBAIC0xNzMsOCArMTc4LDExIEBAIHN0YXRp
YyB2b2lkIGlkZXNjc2lfb3V0cHV0X2J1ZmZlcnMgKGlkZV8KIAkJCXJldHVybjsKIAkJfQogCQlj
b3VudCA9IG1pbihwYy0+c2ctPmxlbmd0aCAtIHBjLT5iX2NvdW50LCBiY291bnQpOwotCQlidWYg
PSBwYWdlX2FkZHJlc3MocGMtPnNnLT5wYWdlKSArIHBjLT5zZy0+b2Zmc2V0OworCQlsb2NhbF9p
cnFfc2F2ZShmbGFncyk7CisJCWJ1ZiA9IGttYXBfYXRvbWljKHBjLT5zZy0+cGFnZSwgS01fSVJR
MCkgKyBwYy0+c2ctPm9mZnNldDsKIAkJZHJpdmUtPmh3aWYtPmF0YXBpX291dHB1dF9ieXRlcyhk
cml2ZSwgYnVmICsgcGMtPmJfY291bnQsIGNvdW50KTsKKwkJa3VubWFwX2F0b21pYyhidWYgLSBw
Yy0+c2ctPm9mZnNldCwgS01fSVJRMCk7CisJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKIAkJ
YmNvdW50IC09IGNvdW50OyBwYy0+Yl9jb3VudCArPSBjb3VudDsKIAkJaWYgKHBjLT5iX2NvdW50
ID09IHBjLT5zZy0+bGVuZ3RoKSB7CiAJCQlwYy0+c2crKzsK

------_=_NextPart_001_01C54CD2.6EEFB7B0--
