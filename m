From: <Stuart_Hayes@Dell.com>
Subject: RE: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Tue, 5 Apr 2005 16:08:08 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EEAFA@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C53A23.913F4EAA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:51050 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262042AbVDEVIO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Apr 2005 17:08:14 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53A23.913F4EAA
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

> Hi,
>=20
> On Apr 5, 2005 9:12 PM, Stuart_Hayes@dell.com <Stuart_Hayes@dell.com>
> wrote:=20
>>=20
>> The system can panic with a null pointer dereference using ide-scsi
>> if PIO is being done on scatter gather pages that are in high memory,
>> because page_address() returns 0.  We are actually seeing this using
>> a tape drive.  This patch will kmap_atomic() the pages before
>> performing PIO.=20
>>=20
>> I'm copying the text here, but I'm also attaching it as a file,
>> because the text will get garbled with extra line breaks.
>>=20
>> Please let me know if there are any problems with the patch!
>=20
> Looks fine, I have two small requests:
> * please don't disable/enable local IRQs for !HIGHMEM case
>   (see ide_pio_sector() in ide-taskfile.c)
> * declare 'unsigned long flags' at the beginning of the function
>=20
>> (I sent this patch to linux-scsi a few weeks ago, and I was finally
>> told that it is maintained by the IDE folks (Bartlomiej
>> Zolnierkiewicz), not the SCSI folks...)
>=20
> I'm not on linux-scsi, *sigh*, somebody could have simply forwarded
> it to me...=20
>=20
> Thanks!
> Bartlomiej

How is this?  I already had the "flags" declarations at the beginning of
the functions, but I wrapped them and the irq disable/enables in the
HIGHMEM ifdef, like ide_pio_sector() in ide-taskfile.c.

Thanks again,
Stuart


Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>

diff -purN a/drivers/scsi/ide-scsi.c b2/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-03-25 22:28:23.000000000 -0500
+++ b2/drivers/scsi/ide-scsi.c	2005-04-05 15:56:48.000000000 -0400
@@ -143,6 +143,9 @@ static void idescsi_input_buffers (ide_d
 {
 	int count;
 	char *buf;
+#ifdef CONFIG_HIGHMEM
+	unsigned long flags;
+#endif
=20
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *)
pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
@@ -151,8 +154,15 @@ static void idescsi_input_buffers (ide_d
 			return;
 		}
 		count =3D min(pc->sg->length - pc->b_count, bcount);
-		buf =3D page_address(pc->sg->page) + pc->sg->offset;
+#ifdef CONFIG_HIGHMEM
+		local_irq_save(flags);
+#endif
+		buf =3D kmap_atomic(pc->sg->page, KM_USER0) +
pc->sg->offset;
 		drive->hwif->atapi_input_bytes(drive, buf + pc->b_count,
count);
+		kunmap_atomic(buf - pc->sg->offset, KM_USER0);
+#ifdef CONFIG_HIGHMEM
+		local_irq_restore(flags);
+#endif
 		bcount -=3D count; pc->b_count +=3D count;
 		if (pc->b_count =3D=3D pc->sg->length) {
 			pc->sg++;
@@ -165,6 +175,9 @@ static void idescsi_output_buffers (ide_
 {
 	int count;
 	char *buf;
+#ifdef CONFIG_HIGHMEM
+	unsigned long flags;
+#endif
=20
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *)
pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
@@ -173,8 +186,15 @@ static void idescsi_output_buffers (ide_
 			return;
 		}
 		count =3D min(pc->sg->length - pc->b_count, bcount);
-		buf =3D page_address(pc->sg->page) + pc->sg->offset;
+#ifdef CONFIG_HIGHMEM
+		local_irq_save(flags);
+#endif
+		buf =3D kmap_atomic(pc->sg->page, KM_USER0) +
pc->sg->offset;
 		drive->hwif->atapi_output_bytes(drive, buf +
pc->b_count, count);
+		kunmap_atomic(buf - pc->sg->offset, KM_USER0);
+#ifdef CONFIG_HIGHMEM
+		local_irq_restore(flags);
+#endif
 		bcount -=3D count; pc->b_count +=3D count;
 		if (pc->b_count =3D=3D pc->sg->length) {
 			pc->sg++;



------_=_NextPart_001_01C53A23.913F4EAA
Content-Type: application/octet-stream;
	name="idescsi-kmap-b-2.6.11.6.patch"
Content-Transfer-Encoding: base64
Content-Description: idescsi-kmap-b-2.6.11.6.patch
Content-Disposition: attachment;
	filename="idescsi-kmap-b-2.6.11.6.patch"

ZGlmZiAtcHVyTiBhL2RyaXZlcnMvc2NzaS9pZGUtc2NzaS5jIGIyL2RyaXZlcnMvc2NzaS9pZGUt
c2NzaS5jCi0tLSBhL2RyaXZlcnMvc2NzaS9pZGUtc2NzaS5jCTIwMDUtMDMtMjUgMjI6Mjg6MjMu
MDAwMDAwMDAwIC0wNTAwCisrKyBiMi9kcml2ZXJzL3Njc2kvaWRlLXNjc2kuYwkyMDA1LTA0LTA1
IDE1OjU2OjQ4LjAwMDAwMDAwMCAtMDQwMApAQCAtMTQzLDYgKzE0Myw5IEBAIHN0YXRpYyB2b2lk
IGlkZXNjc2lfaW5wdXRfYnVmZmVycyAoaWRlX2QKIHsKIAlpbnQgY291bnQ7CiAJY2hhciAqYnVm
OworI2lmZGVmIENPTkZJR19ISUdITUVNCisJdW5zaWduZWQgbG9uZyBmbGFnczsKKyNlbmRpZgog
CiAJd2hpbGUgKGJjb3VudCkgewogCQlpZiAocGMtPnNnIC0gKHN0cnVjdCBzY2F0dGVybGlzdCAq
KSBwYy0+c2NzaV9jbWQtPnJlcXVlc3RfYnVmZmVyID4gcGMtPnNjc2lfY21kLT51c2Vfc2cpIHsK
QEAgLTE1MSw4ICsxNTQsMTUgQEAgc3RhdGljIHZvaWQgaWRlc2NzaV9pbnB1dF9idWZmZXJzIChp
ZGVfZAogCQkJcmV0dXJuOwogCQl9CiAJCWNvdW50ID0gbWluKHBjLT5zZy0+bGVuZ3RoIC0gcGMt
PmJfY291bnQsIGJjb3VudCk7Ci0JCWJ1ZiA9IHBhZ2VfYWRkcmVzcyhwYy0+c2ctPnBhZ2UpICsg
cGMtPnNnLT5vZmZzZXQ7CisjaWZkZWYgQ09ORklHX0hJR0hNRU0KKwkJbG9jYWxfaXJxX3NhdmUo
ZmxhZ3MpOworI2VuZGlmCisJCWJ1ZiA9IGttYXBfYXRvbWljKHBjLT5zZy0+cGFnZSwgS01fVVNF
UjApICsgcGMtPnNnLT5vZmZzZXQ7CiAJCWRyaXZlLT5od2lmLT5hdGFwaV9pbnB1dF9ieXRlcyhk
cml2ZSwgYnVmICsgcGMtPmJfY291bnQsIGNvdW50KTsKKwkJa3VubWFwX2F0b21pYyhidWYgLSBw
Yy0+c2ctPm9mZnNldCwgS01fVVNFUjApOworI2lmZGVmIENPTkZJR19ISUdITUVNCisJCWxvY2Fs
X2lycV9yZXN0b3JlKGZsYWdzKTsKKyNlbmRpZgogCQliY291bnQgLT0gY291bnQ7IHBjLT5iX2Nv
dW50ICs9IGNvdW50OwogCQlpZiAocGMtPmJfY291bnQgPT0gcGMtPnNnLT5sZW5ndGgpIHsKIAkJ
CXBjLT5zZysrOwpAQCAtMTY1LDYgKzE3NSw5IEBAIHN0YXRpYyB2b2lkIGlkZXNjc2lfb3V0cHV0
X2J1ZmZlcnMgKGlkZV8KIHsKIAlpbnQgY291bnQ7CiAJY2hhciAqYnVmOworI2lmZGVmIENPTkZJ
R19ISUdITUVNCisJdW5zaWduZWQgbG9uZyBmbGFnczsKKyNlbmRpZgogCiAJd2hpbGUgKGJjb3Vu
dCkgewogCQlpZiAocGMtPnNnIC0gKHN0cnVjdCBzY2F0dGVybGlzdCAqKSBwYy0+c2NzaV9jbWQt
PnJlcXVlc3RfYnVmZmVyID4gcGMtPnNjc2lfY21kLT51c2Vfc2cpIHsKQEAgLTE3Myw4ICsxODYs
MTUgQEAgc3RhdGljIHZvaWQgaWRlc2NzaV9vdXRwdXRfYnVmZmVycyAoaWRlXwogCQkJcmV0dXJu
OwogCQl9CiAJCWNvdW50ID0gbWluKHBjLT5zZy0+bGVuZ3RoIC0gcGMtPmJfY291bnQsIGJjb3Vu
dCk7Ci0JCWJ1ZiA9IHBhZ2VfYWRkcmVzcyhwYy0+c2ctPnBhZ2UpICsgcGMtPnNnLT5vZmZzZXQ7
CisjaWZkZWYgQ09ORklHX0hJR0hNRU0KKwkJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOworI2VuZGlm
CisJCWJ1ZiA9IGttYXBfYXRvbWljKHBjLT5zZy0+cGFnZSwgS01fVVNFUjApICsgcGMtPnNnLT5v
ZmZzZXQ7CiAJCWRyaXZlLT5od2lmLT5hdGFwaV9vdXRwdXRfYnl0ZXMoZHJpdmUsIGJ1ZiArIHBj
LT5iX2NvdW50LCBjb3VudCk7CisJCWt1bm1hcF9hdG9taWMoYnVmIC0gcGMtPnNnLT5vZmZzZXQs
IEtNX1VTRVIwKTsKKyNpZmRlZiBDT05GSUdfSElHSE1FTQorCQlsb2NhbF9pcnFfcmVzdG9yZShm
bGFncyk7CisjZW5kaWYKIAkJYmNvdW50IC09IGNvdW50OyBwYy0+Yl9jb3VudCArPSBjb3VudDsK
IAkJaWYgKHBjLT5iX2NvdW50ID09IHBjLT5zZy0+bGVuZ3RoKSB7CiAJCQlwYy0+c2crKzsK

------_=_NextPart_001_01C53A23.913F4EAA--
