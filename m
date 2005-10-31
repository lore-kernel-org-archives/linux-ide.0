From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: [PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Mon, 31 Oct 2005 14:57:25 -0800
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BF22@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5DE6E.7624A838"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:37946 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S964797AbVJaW5b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 31 Oct 2005 17:57:31 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5DE6E.7624A838
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

IDE taskfile passthru was limited to 128K data transfers
because of its use of a single kmalloc. This patch makes
the passthru use a single __get_free_pages instead so the
codepath remains conceptually the same but the data
transfer limit is raised to 2MB.  This new limit is
needed for firmware updates (download microcode) and
extended commands with larger transfers.

Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>

Its attached since what's below is going to get wrapped.

---

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -511,6 +511,33 @@ int ide_raw_taskfile (ide_drive_t *drive
=20
 EXPORT_SYMBOL(ide_raw_taskfile);
=20
+int ide_xfrsize_to_pageorder (int size)
+{
+	int pageorder, x, num;
+
+	num =3D size / PAGE_SIZE;
+	if( size % PAGE_SIZE )
+		++num;
+
+	/* figure out the smallest pageorder that has at least num pages */
+	pageorder =3D 0;
+	for( x =3D sizeof(num) * 8 - 1; x >=3D 0; --x )
+	{
+		if( (num >> x) & 1 )
+		{
+			if(pageorder)
+			{
+				return pageorder + 1;
+			}
+			else
+			{
+				pageorder =3D x;
+			}
+		}
+	}
+	return pageorder;
+}
+
 int ide_taskfile_ioctl (ide_drive_t *drive, unsigned int cmd, unsigned =
long
arg)
 {
 	ide_task_request_t	*req_task;
@@ -523,6 +550,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	int tasksize		=3D sizeof(struct ide_task_request_s);
 	int taskin		=3D 0;
 	int taskout		=3D 0;
+	int inorder		=3D 0;
+	int outorder    =3D 0;
 	u8 io_32bit		=3D drive->io_32bit;
 	char __user *buf =3D (char __user *)arg;
=20
@@ -541,7 +570,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
=20
 	if (taskout) {
 		int outtotal =3D tasksize;
-		outbuf =3D kmalloc(taskout, GFP_KERNEL);
+		outorder =3D ide_xfrsize_to_pageorder(taskout);
+		outbuf =3D (u8*)__get_free_pages(GFP_KERNEL, outorder);
 		if (outbuf =3D=3D NULL) {
 			err =3D -ENOMEM;
 			goto abort;
@@ -555,7 +585,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
=20
 	if (taskin) {
 		int intotal =3D tasksize + taskout;
-		inbuf =3D kmalloc(taskin, GFP_KERNEL);
+		inorder =3D ide_xfrsize_to_pageorder(taskin);
+		inbuf =3D (u8*)__get_free_pages(GFP_KERNEL, inorder);
 		if (inbuf =3D=3D NULL) {
 			err =3D -ENOMEM;
 			goto abort;
@@ -650,9 +681,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 abort:
 	kfree(req_task);
 	if (outbuf !=3D NULL)
-		kfree(outbuf);
+		free_pages((unsigned long)outbuf, outorder);
 	if (inbuf !=3D NULL)
-		kfree(inbuf);
+		free_pages((unsigned long)inbuf, inorder);
=20
 //	printk("IDE Taskfile ioctl ended. rc =3D %i\n", err);
=20

------_=_NextPart_001_01C5DE6E.7624A838
Content-Type: application/octet-stream;
	name="ide-enable-larger-taskfile-transfers.patch"
Content-Transfer-Encoding: base64
Content-Description: ide-enable-larger-taskfile-transfers.patch
Content-Disposition: attachment;
	filename="ide-enable-larger-taskfile-transfers.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWRlL2lkZS10YXNrZmlsZS5jIGIvZHJpdmVycy9pZGUvaWRl
LXRhc2tmaWxlLmMKLS0tIGEvZHJpdmVycy9pZGUvaWRlLXRhc2tmaWxlLmMKKysrIGIvZHJpdmVy
cy9pZGUvaWRlLXRhc2tmaWxlLmMKQEAgLTUxMSw2ICs1MTEsMzMgQEAgaW50IGlkZV9yYXdfdGFz
a2ZpbGUgKGlkZV9kcml2ZV90ICpkcml2ZQogCiBFWFBPUlRfU1lNQk9MKGlkZV9yYXdfdGFza2Zp
bGUpOwogCitpbnQgaWRlX3hmcnNpemVfdG9fcGFnZW9yZGVyIChpbnQgc2l6ZSkKK3sKKwlpbnQg
cGFnZW9yZGVyLCB4LCBudW07CisKKwludW0gPSBzaXplIC8gUEFHRV9TSVpFOworCWlmKCBzaXpl
ICUgUEFHRV9TSVpFICkKKwkJKytudW07CisKKwkvKiBmaWd1cmUgb3V0IHRoZSBzbWFsbGVzdCBw
YWdlb3JkZXIgdGhhdCBoYXMgYXQgbGVhc3QgbnVtIHBhZ2VzICovCisJcGFnZW9yZGVyID0gMDsK
Kwlmb3IoIHggPSBzaXplb2YobnVtKSAqIDggLSAxOyB4ID49IDA7IC0teCApCisJeworCQlpZigg
KG51bSA+PiB4KSAmIDEgKQorCQl7CisJCQlpZihwYWdlb3JkZXIpCisJCQl7CisJCQkJcmV0dXJu
IHBhZ2VvcmRlciArIDE7CisJCQl9CisJCQllbHNlCisJCQl7CisJCQkJcGFnZW9yZGVyID0geDsK
KwkJCX0KKwkJfQorCX0KKwlyZXR1cm4gcGFnZW9yZGVyOworfQorCiBpbnQgaWRlX3Rhc2tmaWxl
X2lvY3RsIChpZGVfZHJpdmVfdCAqZHJpdmUsIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxv
bmcgYXJnKQogewogCWlkZV90YXNrX3JlcXVlc3RfdAkqcmVxX3Rhc2s7CkBAIC01MjMsNiArNTUw
LDggQEAgaW50IGlkZV90YXNrZmlsZV9pb2N0bCAoaWRlX2RyaXZlX3QgKmRyaQogCWludCB0YXNr
c2l6ZQkJPSBzaXplb2Yoc3RydWN0IGlkZV90YXNrX3JlcXVlc3Rfcyk7CiAJaW50IHRhc2tpbgkJ
PSAwOwogCWludCB0YXNrb3V0CQk9IDA7CisJaW50IGlub3JkZXIJCT0gMDsKKwlpbnQgb3V0b3Jk
ZXIgICAgPSAwOwogCXU4IGlvXzMyYml0CQk9IGRyaXZlLT5pb18zMmJpdDsKIAljaGFyIF9fdXNl
ciAqYnVmID0gKGNoYXIgX191c2VyICopYXJnOwogCkBAIC01NDEsNyArNTcwLDggQEAgaW50IGlk
ZV90YXNrZmlsZV9pb2N0bCAoaWRlX2RyaXZlX3QgKmRyaQogCiAJaWYgKHRhc2tvdXQpIHsKIAkJ
aW50IG91dHRvdGFsID0gdGFza3NpemU7Ci0JCW91dGJ1ZiA9IGttYWxsb2ModGFza291dCwgR0ZQ
X0tFUk5FTCk7CisJCW91dG9yZGVyID0gaWRlX3hmcnNpemVfdG9fcGFnZW9yZGVyKHRhc2tvdXQp
OworCQlvdXRidWYgPSAodTgqKV9fZ2V0X2ZyZWVfcGFnZXMoR0ZQX0tFUk5FTCwgb3V0b3JkZXIp
OwogCQlpZiAob3V0YnVmID09IE5VTEwpIHsKIAkJCWVyciA9IC1FTk9NRU07CiAJCQlnb3RvIGFi
b3J0OwpAQCAtNTU1LDcgKzU4NSw4IEBAIGludCBpZGVfdGFza2ZpbGVfaW9jdGwgKGlkZV9kcml2
ZV90ICpkcmkKIAogCWlmICh0YXNraW4pIHsKIAkJaW50IGludG90YWwgPSB0YXNrc2l6ZSArIHRh
c2tvdXQ7Ci0JCWluYnVmID0ga21hbGxvYyh0YXNraW4sIEdGUF9LRVJORUwpOworCQlpbm9yZGVy
ID0gaWRlX3hmcnNpemVfdG9fcGFnZW9yZGVyKHRhc2tpbik7CisJCWluYnVmID0gKHU4KilfX2dl
dF9mcmVlX3BhZ2VzKEdGUF9LRVJORUwsIGlub3JkZXIpOwogCQlpZiAoaW5idWYgPT0gTlVMTCkg
ewogCQkJZXJyID0gLUVOT01FTTsKIAkJCWdvdG8gYWJvcnQ7CkBAIC02NTAsOSArNjgxLDkgQEAg
aW50IGlkZV90YXNrZmlsZV9pb2N0bCAoaWRlX2RyaXZlX3QgKmRyaQogYWJvcnQ6CiAJa2ZyZWUo
cmVxX3Rhc2spOwogCWlmIChvdXRidWYgIT0gTlVMTCkKLQkJa2ZyZWUob3V0YnVmKTsKKwkJZnJl
ZV9wYWdlcygodW5zaWduZWQgbG9uZylvdXRidWYsIG91dG9yZGVyKTsKIAlpZiAoaW5idWYgIT0g
TlVMTCkKLQkJa2ZyZWUoaW5idWYpOworCQlmcmVlX3BhZ2VzKCh1bnNpZ25lZCBsb25nKWluYnVm
LCBpbm9yZGVyKTsKIAogLy8JcHJpbnRrKCJJREUgVGFza2ZpbGUgaW9jdGwgZW5kZWQuIHJjID0g
JWlcbiIsIGVycik7CiAK

------_=_NextPart_001_01C5DE6E.7624A838--
