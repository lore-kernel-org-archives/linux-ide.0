From: <Stuart_Hayes@Dell.com>
Subject: RE: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Mon, 2 May 2005 15:03:58 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EEC1B@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C54F52.13DC7180"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:12036 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261745AbVEBUEB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 May 2005 16:04:01 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: axboe@suse.de, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C54F52.13DC7180
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Bartlomiej Zolnierkiewicz wrote:
> Hi,
>=20
> On 5/2/05, Stuart_Hayes@dell.com <Stuart_Hayes@dell.com> wrote:
>> Jens Axboe wrote:
>>> On Fri, Apr 29 2005, Stuart_Hayes@Dell.com wrote:
>>>>> With more testing, I've discovered a problem with thin patch--I
>>>>> used the "KM_USER0" window for kmap_atomic(), but that's
>>>>> apparently not safe to use in an interrupt handler, because there
>>>>> are places in the kernel where KM_USER0 is used without masking
>>>>> interrupts (see include/linux/highmem.h for several examples).
>>>>> This patch is identical to the previous one I sent in, except it
>>>>> uses the KM_IRQ0 window, which I verified is not used anywhere
>>>>> without IRQs masked.=20
>>>>>=20
>>>>> This patch is against 2.6.11.7... the latest kernel on kernel.org
>>>>> didn't yet have the previous patch I submitted.  If it would be
>>>>> more useful, I can make this patch against an ide-scsi.c that
>>>>> already has my previous patch applied--I wasn't sure which would
>>>>> be better.=20
>>>=20
>>> (you should inline the patch so one can comment on it...)
>>>=20
>>> The IO code typically uses the BIO defines for this.
>>>=20
>>> diff -purN linux-2.6.11.7/drivers/scsi/ide-scsi.c
>>> linux-2.6.11.7mods/drivers/scsi/ide-scsi.c ---
>>> linux-2.6.11.7/drivers/scsi/ide-scsi.c        2005-04-07
>>> 14:57:46.000000000 -0400 +++
>>>       linux-2.6.11.7mods/drivers/scsi/ide-scsi.c  2005-04-29
>>>       11:46:55.000000000 -0400 @@ -143,6 +143,9 @@ static void
>>> idescsi_input_buffers (ide_d  { int count; char *buf; +#ifdef
>>> CONFIG_HIGHMEM +     unsigned long flags; +#endif
>>>=20
>>>       while (bcount) {
>>>               if (pc->sg - (struct scatterlist *)
>>>                       pc->scsi_cmd->request_buffer >
>>>               pc->scsi_cmd->use_sg) { @@ -151,8 +154,15 @@ static
>>>               void idescsi_input_buffers (ide_d return; } count =3D
>>> min(pc->sg->length - pc->b_count, bcount); -             buf =3D
>>> page_address(pc->sg->page) + pc->sg->offset; +#ifdef CONFIG_HIGHMEM
>>> +             local_irq_save(flags); #endif=20
>>>=20
>>> This is just aweful, don't add tons of ifdefs. If you must
>>> differentiate, just do something ala:
>>>=20
>>>         if (PageHighMem(page)) {
>>>                 save interrupts
>>>                 buf =3D kmap
>>>         } else
>>>                 buf =3D page_address(xxx).
>>>=20
>>> and so on. But why are you still doing it this way? Did we not agree
>>> that adding a host template no-high-mem defines was way better??
>>=20
>> The ifdefs were at Bart's request.
>=20
> Yep, ifdefs are my fault.
>=20
> Thanks for PageHighMem() hint Jens, we should use it also for
> ide-taskfile.c.=20
>=20
>> The reason I went back to the kmap_atomic() fix instead of adding a
>> no-high-mem flag in the host is that I couldn't get James to accept
>> that
>=20
> What is no-high-mem flag?
>=20
>> patch, while this one is ide-scsi only, and Bart did accept it.  And,
>> to be honest, I wasn't really sure why the kmap_atomic() fix was
>> inferior.=20
>>=20
>> But I'd certainly defer to your (or Bart's) judgment on those
>> things-- you guys have a lot more experience than me with the
>> kernel.  I am hesitant to change the "ifdef"s to "if"s at this
>> point, since Bart already accepted it (previously) with the ifdefs,
>> but I'd be more than happy to change it if he agrees.
>=20
> I agree ;-)
>=20
> Cheers,
> Bartlomiej
> -

How does this look?  I've tested it successfully.  (The attached
file should be the same as the code below, except for wrapping...)


diff -purN linux-2.6.11.7/drivers/scsi/ide-scsi.c
linux-2.6.11.7mods/drivers/scsi/ide-scsi.c
--- linux-2.6.11.7/drivers/scsi/ide-scsi.c	2005-04-07
14:57:46.000000000 -0400
+++ linux-2.6.11.7mods/drivers/scsi/ide-scsi.c	2005-05-02
15:48:40.000000000 -0400
@@ -151,8 +151,17 @@ static void idescsi_input_buffers (ide_d
 			return;
 		}
 		count =3D min(pc->sg->length - pc->b_count, bcount);
-		buf =3D page_address(pc->sg->page) + pc->sg->offset;
-		drive->hwif->atapi_input_bytes(drive, buf + pc->b_count,
count);
+		if (PageHighMem(pc->sg->page)) {
+			unsigned long flags;
+			local_irq_save(flags);
+			buf =3D kmap_atomic(pc->sg->page, KM_IRQ0) +
pc->sg->offset;
+			drive->hwif->atapi_input_bytes(drive, buf +
pc->b_count, count);
+			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
+			local_irq_restore(flags);
+		} else {
+			buf =3D page_address(pc->sg->page) +
pc->sg->offset;
+			drive->hwif->atapi_input_bytes(drive, buf +
pc->b_count, count);
+		}
 		bcount -=3D count; pc->b_count +=3D count;
 		if (pc->b_count =3D=3D pc->sg->length) {
 			pc->sg++;
@@ -173,8 +182,17 @@ static void idescsi_output_buffers (ide_
 			return;
 		}
 		count =3D min(pc->sg->length - pc->b_count, bcount);
-		buf =3D page_address(pc->sg->page) + pc->sg->offset;
-		drive->hwif->atapi_output_bytes(drive, buf +
pc->b_count, count);
+		if (PageHighMem(pc->sg->page)) {
+			unsigned long flags;
+			local_irq_save(flags);
+			buf =3D kmap_atomic(pc->sg->page, KM_IRQ0) +
pc->sg->offset;
+			drive->hwif->atapi_output_bytes(drive, buf +
pc->b_count, count);
+			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
+			local_irq_restore(flags);
+		} else {
+			buf =3D page_address(pc->sg->page) +
pc->sg->offset;
+			drive->hwif->atapi_output_bytes(drive, buf +
pc->b_count, count);
+		}
 		bcount -=3D count; pc->b_count +=3D count;
 		if (pc->b_count =3D=3D pc->sg->length) {
 			pc->sg++;


------_=_NextPart_001_01C54F52.13DC7180
Content-Type: application/octet-stream;
	name="ide-scsi.2.6.11.7.try6.patch"
Content-Transfer-Encoding: base64
Content-Description: ide-scsi.2.6.11.7.try6.patch
Content-Disposition: attachment;
	filename="ide-scsi.2.6.11.7.try6.patch"

ZGlmZiAtcHVyTiBsaW51eC0yLjYuMTEuNy9kcml2ZXJzL3Njc2kvaWRlLXNjc2kuYyBsaW51eC0y
LjYuMTEuN21vZHMvZHJpdmVycy9zY3NpL2lkZS1zY3NpLmMKLS0tIGxpbnV4LTIuNi4xMS43L2Ry
aXZlcnMvc2NzaS9pZGUtc2NzaS5jCTIwMDUtMDQtMDcgMTQ6NTc6NDYuMDAwMDAwMDAwIC0wNDAw
CisrKyBsaW51eC0yLjYuMTEuN21vZHMvZHJpdmVycy9zY3NpL2lkZS1zY3NpLmMJMjAwNS0wNS0w
MiAxNTo0ODo0MC4wMDAwMDAwMDAgLTA0MDAKQEAgLTE1MSw4ICsxNTEsMTcgQEAgc3RhdGljIHZv
aWQgaWRlc2NzaV9pbnB1dF9idWZmZXJzIChpZGVfZAogCQkJcmV0dXJuOwogCQl9CiAJCWNvdW50
ID0gbWluKHBjLT5zZy0+bGVuZ3RoIC0gcGMtPmJfY291bnQsIGJjb3VudCk7Ci0JCWJ1ZiA9IHBh
Z2VfYWRkcmVzcyhwYy0+c2ctPnBhZ2UpICsgcGMtPnNnLT5vZmZzZXQ7Ci0JCWRyaXZlLT5od2lm
LT5hdGFwaV9pbnB1dF9ieXRlcyhkcml2ZSwgYnVmICsgcGMtPmJfY291bnQsIGNvdW50KTsKKwkJ
aWYgKFBhZ2VIaWdoTWVtKHBjLT5zZy0+cGFnZSkpIHsKKwkJCXVuc2lnbmVkIGxvbmcgZmxhZ3M7
CisJCQlsb2NhbF9pcnFfc2F2ZShmbGFncyk7CisJCQlidWYgPSBrbWFwX2F0b21pYyhwYy0+c2ct
PnBhZ2UsIEtNX0lSUTApICsgcGMtPnNnLT5vZmZzZXQ7CisJCQlkcml2ZS0+aHdpZi0+YXRhcGlf
aW5wdXRfYnl0ZXMoZHJpdmUsIGJ1ZiArIHBjLT5iX2NvdW50LCBjb3VudCk7CisJCQlrdW5tYXBf
YXRvbWljKGJ1ZiAtIHBjLT5zZy0+b2Zmc2V0LCBLTV9JUlEwKTsKKwkJCWxvY2FsX2lycV9yZXN0
b3JlKGZsYWdzKTsKKwkJfSBlbHNlIHsKKwkJCWJ1ZiA9IHBhZ2VfYWRkcmVzcyhwYy0+c2ctPnBh
Z2UpICsgcGMtPnNnLT5vZmZzZXQ7CisJCQlkcml2ZS0+aHdpZi0+YXRhcGlfaW5wdXRfYnl0ZXMo
ZHJpdmUsIGJ1ZiArIHBjLT5iX2NvdW50LCBjb3VudCk7CisJCX0KIAkJYmNvdW50IC09IGNvdW50
OyBwYy0+Yl9jb3VudCArPSBjb3VudDsKIAkJaWYgKHBjLT5iX2NvdW50ID09IHBjLT5zZy0+bGVu
Z3RoKSB7CiAJCQlwYy0+c2crKzsKQEAgLTE3Myw4ICsxODIsMTcgQEAgc3RhdGljIHZvaWQgaWRl
c2NzaV9vdXRwdXRfYnVmZmVycyAoaWRlXwogCQkJcmV0dXJuOwogCQl9CiAJCWNvdW50ID0gbWlu
KHBjLT5zZy0+bGVuZ3RoIC0gcGMtPmJfY291bnQsIGJjb3VudCk7Ci0JCWJ1ZiA9IHBhZ2VfYWRk
cmVzcyhwYy0+c2ctPnBhZ2UpICsgcGMtPnNnLT5vZmZzZXQ7Ci0JCWRyaXZlLT5od2lmLT5hdGFw
aV9vdXRwdXRfYnl0ZXMoZHJpdmUsIGJ1ZiArIHBjLT5iX2NvdW50LCBjb3VudCk7CisJCWlmIChQ
YWdlSGlnaE1lbShwYy0+c2ctPnBhZ2UpKSB7CisJCQl1bnNpZ25lZCBsb25nIGZsYWdzOworCQkJ
bG9jYWxfaXJxX3NhdmUoZmxhZ3MpOworCQkJYnVmID0ga21hcF9hdG9taWMocGMtPnNnLT5wYWdl
LCBLTV9JUlEwKSArIHBjLT5zZy0+b2Zmc2V0OworCQkJZHJpdmUtPmh3aWYtPmF0YXBpX291dHB1
dF9ieXRlcyhkcml2ZSwgYnVmICsgcGMtPmJfY291bnQsIGNvdW50KTsKKwkJCWt1bm1hcF9hdG9t
aWMoYnVmIC0gcGMtPnNnLT5vZmZzZXQsIEtNX0lSUTApOworCQkJbG9jYWxfaXJxX3Jlc3RvcmUo
ZmxhZ3MpOworCQl9IGVsc2UgeworCQkJYnVmID0gcGFnZV9hZGRyZXNzKHBjLT5zZy0+cGFnZSkg
KyBwYy0+c2ctPm9mZnNldDsKKwkJCWRyaXZlLT5od2lmLT5hdGFwaV9vdXRwdXRfYnl0ZXMoZHJp
dmUsIGJ1ZiArIHBjLT5iX2NvdW50LCBjb3VudCk7CisJCX0KIAkJYmNvdW50IC09IGNvdW50OyBw
Yy0+Yl9jb3VudCArPSBjb3VudDsKIAkJaWYgKHBjLT5iX2NvdW50ID09IHBjLT5zZy0+bGVuZ3Ro
KSB7CiAJCQlwYy0+c2crKzsK

------_=_NextPart_001_01C54F52.13DC7180--
