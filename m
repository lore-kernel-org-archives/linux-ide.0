From: <Stuart_Hayes@Dell.com>
Subject: [PATCH 2.6.11.6] ide-scsi: kmap scatter/gather before doing PIO
Date: Tue, 5 Apr 2005 14:12:19 -0500
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EEAF7@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C53A13.631007C2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:61456 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261918AbVDETMy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Apr 2005 15:12:54 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53A13.631007C2
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable


The system can panic with a null pointer dereference using ide-scsi if
PIO is being done on scatter gather pages that are in high memory,
because page_address() returns 0.  We are actually seeing this using a
tape drive.  This patch will kmap_atomic() the pages before performing
PIO.

I'm copying the text here, but I'm also attaching it as a file, because
the text will get garbled with extra line breaks.

Please let me know if there are any problems with the patch!

(I sent this patch to linux-scsi a few weeks ago, and I was finally told
that it is maintained by the IDE folks (Bartlomiej Zolnierkiewicz), not
the SCSI folks...)

Thanks!
Stuart


Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>

diff -purN a/drivers/scsi/ide-scsi.c b2/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c	2005-03-25 22:28:23.000000000 -0500
+++ b2/drivers/scsi/ide-scsi.c	2005-04-05 13:50:27.000000000 -0400
@@ -143,6 +143,7 @@ static void idescsi_input_buffers (ide_d
 {
 	int count;
 	char *buf;
+	unsigned long flags;
=20
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *)
pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
@@ -151,8 +152,11 @@ static void idescsi_input_buffers (ide_d
 			return;
 		}
 		count =3D min(pc->sg->length - pc->b_count, bcount);
-		buf =3D page_address(pc->sg->page) + pc->sg->offset;
+		local_irq_save(flags);
+		buf =3D kmap_atomic(pc->sg->page, KM_USER0) +
pc->sg->offset;
 		drive->hwif->atapi_input_bytes(drive, buf + pc->b_count,
count);
+		kunmap_atomic(buf - pc->sg->offset, KM_USER0);
+		local_irq_restore(flags);
 		bcount -=3D count; pc->b_count +=3D count;
 		if (pc->b_count =3D=3D pc->sg->length) {
 			pc->sg++;
@@ -165,6 +169,7 @@ static void idescsi_output_buffers (ide_
 {
 	int count;
 	char *buf;
+	unsigned long flags;
=20
 	while (bcount) {
 		if (pc->sg - (struct scatterlist *)
pc->scsi_cmd->request_buffer > pc->scsi_cmd->use_sg) {
@@ -173,8 +178,11 @@ static void idescsi_output_buffers (ide_
 			return;
 		}
 		count =3D min(pc->sg->length - pc->b_count, bcount);
-		buf =3D page_address(pc->sg->page) + pc->sg->offset;
+		local_irq_save(flags);
+		buf =3D kmap_atomic(pc->sg->page, KM_USER0) +
pc->sg->offset;
 		drive->hwif->atapi_output_bytes(drive, buf +
pc->b_count, count);
+		kunmap_atomic(buf - pc->sg->offset, KM_USER0);
+		local_irq_restore(flags);
 		bcount -=3D count; pc->b_count +=3D count;
 		if (pc->b_count =3D=3D pc->sg->length) {
 			pc->sg++;





------_=_NextPart_001_01C53A13.631007C2
Content-Type: application/octet-stream;
	name="idescsi-kmap-2.6.11.6.patch"
Content-Transfer-Encoding: base64
Content-Description: idescsi-kmap-2.6.11.6.patch
Content-Disposition: attachment;
	filename="idescsi-kmap-2.6.11.6.patch"

ZGlmZiAtcHVyTiBhL2RyaXZlcnMvc2NzaS9pZGUtc2NzaS5jIGIyL2RyaXZlcnMvc2NzaS9pZGUt
c2NzaS5jCi0tLSBhL2RyaXZlcnMvc2NzaS9pZGUtc2NzaS5jCTIwMDUtMDMtMjUgMjI6Mjg6MjMu
MDAwMDAwMDAwIC0wNTAwCisrKyBiMi9kcml2ZXJzL3Njc2kvaWRlLXNjc2kuYwkyMDA1LTA0LTA1
IDEzOjUwOjI3LjAwMDAwMDAwMCAtMDQwMApAQCAtMTQzLDYgKzE0Myw3IEBAIHN0YXRpYyB2b2lk
IGlkZXNjc2lfaW5wdXRfYnVmZmVycyAoaWRlX2QKIHsKIAlpbnQgY291bnQ7CiAJY2hhciAqYnVm
OworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKIAl3aGlsZSAoYmNvdW50KSB7CiAJCWlmIChwYy0+
c2cgLSAoc3RydWN0IHNjYXR0ZXJsaXN0ICopIHBjLT5zY3NpX2NtZC0+cmVxdWVzdF9idWZmZXIg
PiBwYy0+c2NzaV9jbWQtPnVzZV9zZykgewpAQCAtMTUxLDggKzE1MiwxMSBAQCBzdGF0aWMgdm9p
ZCBpZGVzY3NpX2lucHV0X2J1ZmZlcnMgKGlkZV9kCiAJCQlyZXR1cm47CiAJCX0KIAkJY291bnQg
PSBtaW4ocGMtPnNnLT5sZW5ndGggLSBwYy0+Yl9jb3VudCwgYmNvdW50KTsKLQkJYnVmID0gcGFn
ZV9hZGRyZXNzKHBjLT5zZy0+cGFnZSkgKyBwYy0+c2ctPm9mZnNldDsKKwkJbG9jYWxfaXJxX3Nh
dmUoZmxhZ3MpOworCQlidWYgPSBrbWFwX2F0b21pYyhwYy0+c2ctPnBhZ2UsIEtNX1VTRVIwKSAr
IHBjLT5zZy0+b2Zmc2V0OwogCQlkcml2ZS0+aHdpZi0+YXRhcGlfaW5wdXRfYnl0ZXMoZHJpdmUs
IGJ1ZiArIHBjLT5iX2NvdW50LCBjb3VudCk7CisJCWt1bm1hcF9hdG9taWMoYnVmIC0gcGMtPnNn
LT5vZmZzZXQsIEtNX1VTRVIwKTsKKwkJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwogCQliY291
bnQgLT0gY291bnQ7IHBjLT5iX2NvdW50ICs9IGNvdW50OwogCQlpZiAocGMtPmJfY291bnQgPT0g
cGMtPnNnLT5sZW5ndGgpIHsKIAkJCXBjLT5zZysrOwpAQCAtMTY1LDYgKzE2OSw3IEBAIHN0YXRp
YyB2b2lkIGlkZXNjc2lfb3V0cHV0X2J1ZmZlcnMgKGlkZV8KIHsKIAlpbnQgY291bnQ7CiAJY2hh
ciAqYnVmOworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKIAl3aGlsZSAoYmNvdW50KSB7CiAJCWlm
IChwYy0+c2cgLSAoc3RydWN0IHNjYXR0ZXJsaXN0ICopIHBjLT5zY3NpX2NtZC0+cmVxdWVzdF9i
dWZmZXIgPiBwYy0+c2NzaV9jbWQtPnVzZV9zZykgewpAQCAtMTczLDggKzE3OCwxMSBAQCBzdGF0
aWMgdm9pZCBpZGVzY3NpX291dHB1dF9idWZmZXJzIChpZGVfCiAJCQlyZXR1cm47CiAJCX0KIAkJ
Y291bnQgPSBtaW4ocGMtPnNnLT5sZW5ndGggLSBwYy0+Yl9jb3VudCwgYmNvdW50KTsKLQkJYnVm
ID0gcGFnZV9hZGRyZXNzKHBjLT5zZy0+cGFnZSkgKyBwYy0+c2ctPm9mZnNldDsKKwkJbG9jYWxf
aXJxX3NhdmUoZmxhZ3MpOworCQlidWYgPSBrbWFwX2F0b21pYyhwYy0+c2ctPnBhZ2UsIEtNX1VT
RVIwKSArIHBjLT5zZy0+b2Zmc2V0OwogCQlkcml2ZS0+aHdpZi0+YXRhcGlfb3V0cHV0X2J5dGVz
KGRyaXZlLCBidWYgKyBwYy0+Yl9jb3VudCwgY291bnQpOworCQlrdW5tYXBfYXRvbWljKGJ1ZiAt
IHBjLT5zZy0+b2Zmc2V0LCBLTV9VU0VSMCk7CisJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsK
IAkJYmNvdW50IC09IGNvdW50OyBwYy0+Yl9jb3VudCArPSBjb3VudDsKIAkJaWYgKHBjLT5iX2Nv
dW50ID09IHBjLT5zZy0+bGVuZ3RoKSB7CiAJCQlwYy0+c2crKzsK

------_=_NextPart_001_01C53A13.631007C2--
