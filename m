From: <Stuart_Hayes@Dell.com>
Subject: RE: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Fri, 29 Apr 2005 10:53:09 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EEC08@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C54CD3.8A9EF240"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:24383 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262119AbVD2PxN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Apr 2005 11:53:13 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C54CD3.8A9EF240
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hayes, Stuart wrote:
> Bartlomiej Zolnierkiewicz wrote:
>> On Apr 5, 2005 11:08 PM, Stuart_Hayes@dell.com
>> <Stuart_Hayes@dell.com> wrote:=20
>>=20
>>> How is this?  I already had the "flags" declarations at the
>>> beginning of the functions, but I wrapped them and the irq
>>> disable/enables in the
>>=20
>> I mean at the very beginning but lets leave it as it is.
>>=20
>>> HIGHMEM ifdef, like ide_pio_sector() in ide-taskfile.c.
>>=20
>> thanks
>>=20
>> Bartlomiej
>=20
> Bart --
>=20
> With more testing, I've discovered a problem with thin patch--I used
> the "KM_USER0" window for kmap_atomic(), but that's apparently not
> safe to use in an interrupt handler, because there are places in the
> kernel where KM_USER0 is used without masking interrupts (see
> include/linux/highmem.h for several examples).  This patch is
> identical to the previous one I sent in, except it uses the KM_IRQ0
> window, which I verified is not used anywhere without IRQs masked.  =20
>=20
> This patch is against 2.6.11.7... the latest kernel on kernel.org
> didn't yet have the previous patch I submitted.  If it would be more
> useful, I can make this patch against an ide-scsi.c that already has
> my previous patch applied--I wasn't sure which would be better.  =20
>=20
> Thanks!
> Stuart

My apologies--I just sent the wrong patch.  Here's the correct patch.

Stuart


------_=_NextPart_001_01C54CD3.8A9EF240
Content-Type: application/octet-stream;
	name="idescsi-kmap-c-2.6.11.7.patch"
Content-Transfer-Encoding: base64
Content-Description: idescsi-kmap-c-2.6.11.7.patch
Content-Disposition: attachment;
	filename="idescsi-kmap-c-2.6.11.7.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMTEuNy9kcml2ZXJzL3Njc2kvaWRlLXNjc2kuYyBsaW51eC0y
LjYuMTEuN21vZHMvZHJpdmVycy9zY3NpL2lkZS1zY3NpLmMKLS0tIGxpbnV4LTIuNi4xMS43L2Ry
aXZlcnMvc2NzaS9pZGUtc2NzaS5jCTIwMDUtMDQtMDcgMTQ6NTc6NDYuMDAwMDAwMDAwIC0wNDAw
CisrKyBsaW51eC0yLjYuMTEuN21vZHMvZHJpdmVycy9zY3NpL2lkZS1zY3NpLmMJMjAwNS0wNC0y
OSAxMTo0Njo1NS4wMDAwMDAwMDAgLTA0MDAKQEAgLTE0Myw2ICsxNDMsOSBAQCBzdGF0aWMgdm9p
ZCBpZGVzY3NpX2lucHV0X2J1ZmZlcnMgKGlkZV9kCiB7CiAJaW50IGNvdW50OwogCWNoYXIgKmJ1
ZjsKKyNpZmRlZiBDT05GSUdfSElHSE1FTQorCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CisjZW5kaWYK
IAogCXdoaWxlIChiY291bnQpIHsKIAkJaWYgKHBjLT5zZyAtIChzdHJ1Y3Qgc2NhdHRlcmxpc3Qg
KikgcGMtPnNjc2lfY21kLT5yZXF1ZXN0X2J1ZmZlciA+IHBjLT5zY3NpX2NtZC0+dXNlX3NnKSB7
CkBAIC0xNTEsOCArMTU0LDE1IEBAIHN0YXRpYyB2b2lkIGlkZXNjc2lfaW5wdXRfYnVmZmVycyAo
aWRlX2QKIAkJCXJldHVybjsKIAkJfQogCQljb3VudCA9IG1pbihwYy0+c2ctPmxlbmd0aCAtIHBj
LT5iX2NvdW50LCBiY291bnQpOwotCQlidWYgPSBwYWdlX2FkZHJlc3MocGMtPnNnLT5wYWdlKSAr
IHBjLT5zZy0+b2Zmc2V0OworI2lmZGVmIENPTkZJR19ISUdITUVNCisJCWxvY2FsX2lycV9zYXZl
KGZsYWdzKTsKKyNlbmRpZgorCQlidWYgPSBrbWFwX2F0b21pYyhwYy0+c2ctPnBhZ2UsIEtNX0lS
UTApICsgcGMtPnNnLT5vZmZzZXQ7CiAJCWRyaXZlLT5od2lmLT5hdGFwaV9pbnB1dF9ieXRlcyhk
cml2ZSwgYnVmICsgcGMtPmJfY291bnQsIGNvdW50KTsKKwkJa3VubWFwX2F0b21pYyhidWYgLSBw
Yy0+c2ctPm9mZnNldCwgS01fSVJRMCk7CisjaWZkZWYgQ09ORklHX0hJR0hNRU0KKwkJbG9jYWxf
aXJxX3Jlc3RvcmUoZmxhZ3MpOworI2VuZGlmCiAJCWJjb3VudCAtPSBjb3VudDsgcGMtPmJfY291
bnQgKz0gY291bnQ7CiAJCWlmIChwYy0+Yl9jb3VudCA9PSBwYy0+c2ctPmxlbmd0aCkgewogCQkJ
cGMtPnNnKys7CkBAIC0xNjUsNiArMTc1LDkgQEAgc3RhdGljIHZvaWQgaWRlc2NzaV9vdXRwdXRf
YnVmZmVycyAoaWRlXwogewogCWludCBjb3VudDsKIAljaGFyICpidWY7CisjaWZkZWYgQ09ORklH
X0hJR0hNRU0KKwl1bnNpZ25lZCBsb25nIGZsYWdzOworI2VuZGlmCiAKIAl3aGlsZSAoYmNvdW50
KSB7CiAJCWlmIChwYy0+c2cgLSAoc3RydWN0IHNjYXR0ZXJsaXN0ICopIHBjLT5zY3NpX2NtZC0+
cmVxdWVzdF9idWZmZXIgPiBwYy0+c2NzaV9jbWQtPnVzZV9zZykgewpAQCAtMTczLDggKzE4Niwx
NSBAQCBzdGF0aWMgdm9pZCBpZGVzY3NpX291dHB1dF9idWZmZXJzIChpZGVfCiAJCQlyZXR1cm47
CiAJCX0KIAkJY291bnQgPSBtaW4ocGMtPnNnLT5sZW5ndGggLSBwYy0+Yl9jb3VudCwgYmNvdW50
KTsKLQkJYnVmID0gcGFnZV9hZGRyZXNzKHBjLT5zZy0+cGFnZSkgKyBwYy0+c2ctPm9mZnNldDsK
KyNpZmRlZiBDT05GSUdfSElHSE1FTQorCQlsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisjZW5kaWYK
KwkJYnVmID0ga21hcF9hdG9taWMocGMtPnNnLT5wYWdlLCBLTV9JUlEwKSArIHBjLT5zZy0+b2Zm
c2V0OwogCQlkcml2ZS0+aHdpZi0+YXRhcGlfb3V0cHV0X2J5dGVzKGRyaXZlLCBidWYgKyBwYy0+
Yl9jb3VudCwgY291bnQpOworCQlrdW5tYXBfYXRvbWljKGJ1ZiAtIHBjLT5zZy0+b2Zmc2V0LCBL
TV9JUlEwKTsKKyNpZmRlZiBDT05GSUdfSElHSE1FTQorCQlsb2NhbF9pcnFfcmVzdG9yZShmbGFn
cyk7CisjZW5kaWYKIAkJYmNvdW50IC09IGNvdW50OyBwYy0+Yl9jb3VudCArPSBjb3VudDsKIAkJ
aWYgKHBjLT5iX2NvdW50ID09IHBjLT5zZy0+bGVuZ3RoKSB7CiAJCQlwYy0+c2crKzsK

------_=_NextPart_001_01C54CD3.8A9EF240--
