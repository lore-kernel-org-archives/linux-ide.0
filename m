From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Tue, 1 Nov 2005 11:06:09 -0800
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BF2C@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5DF17.51AC9496"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:46857 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S1751118AbVKATGO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 14:06:14 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5DF17.51AC9496
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is for review the cleaned up version of the patch
that allows ide taskfile transfers to be larger than 128K.

I've validated on my x86 that its possible to do 4MB
read sectors extended and write sectors extended, smaller
transfers with smart read log and smart write log, and
some non-data commands.

It's attached as well, since what's below is going to get
line wrapped.

Thanks,
Tim Thelin

Changes:
Increases the taskfile data transfer limit from 128K to a
theoretical 2-4MB (arch dependant) by using __get_free_pages
instead of kmalloc.  Note that larger requests have a lower
success rate because of needing to find a larger amount of
free consecutive memory.

Signed-off-by: Timothy Thelin <tthelin@wdc.com>

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -511,6 +511,27 @@ int ide_raw_taskfile (ide_drive_t *drive
=20
 EXPORT_SYMBOL(ide_raw_taskfile);
=20
+static int ide_xfrsize_to_pageorder(int size)
+{
+	int pageorder, x, num;
+
+	num =3D size / PAGE_SIZE;
+	if (size % PAGE_SIZE)
+		++num;
+
+	pageorder =3D 0;
+	for (x =3D sizeof(num) * 8 - 1; x >=3D 0; --x) {
+		if ((num >> x) & 1) {
+			if (pageorder) {
+				++pageorder;
+				break;
+			} else
+				pageorder =3D x;
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
@@ -523,6 +544,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
 	int tasksize		=3D sizeof(struct ide_task_request_s);
 	int taskin		=3D 0;
 	int taskout		=3D 0;
+	int inorder		=3D 0;
+	int outorder    	=3D 0;
 	u8 io_32bit		=3D drive->io_32bit;
 	char __user *buf =3D (char __user *)arg;
=20
@@ -541,7 +564,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
=20
 	if (taskout) {
 		int outtotal =3D tasksize;
-		outbuf =3D kmalloc(taskout, GFP_KERNEL);
+		outorder =3D ide_xfrsize_to_pageorder(taskout);
+		outbuf =3D (u8*)__get_free_pages(GFP_KERNEL, outorder);
 		if (outbuf =3D=3D NULL) {
 			err =3D -ENOMEM;
 			goto abort;
@@ -555,7 +579,8 @@ int ide_taskfile_ioctl (ide_drive_t *dri
=20
 	if (taskin) {
 		int intotal =3D tasksize + taskout;
-		inbuf =3D kmalloc(taskin, GFP_KERNEL);
+		inorder =3D ide_xfrsize_to_pageorder(taskin);
+		inbuf =3D (u8*)__get_free_pages(GFP_KERNEL, inorder);
 		if (inbuf =3D=3D NULL) {
 			err =3D -ENOMEM;
 			goto abort;
@@ -650,9 +675,9 @@ int ide_taskfile_ioctl (ide_drive_t *dri
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

------_=_NextPart_001_01C5DF17.51AC9496
Content-Type: application/octet-stream;
	name="ide-enable-larger-taskfile-transfers.patch"
Content-Transfer-Encoding: base64
Content-Description: ide-enable-larger-taskfile-transfers.patch
Content-Disposition: attachment;
	filename="ide-enable-larger-taskfile-transfers.patch"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWRlL2lkZS10YXNrZmlsZS5jIGIvZHJpdmVycy9pZGUvaWRl
LXRhc2tmaWxlLmMKLS0tIGEvZHJpdmVycy9pZGUvaWRlLXRhc2tmaWxlLmMKKysrIGIvZHJpdmVy
cy9pZGUvaWRlLXRhc2tmaWxlLmMKQEAgLTUxMSw2ICs1MTEsMjcgQEAgaW50IGlkZV9yYXdfdGFz
a2ZpbGUgKGlkZV9kcml2ZV90ICpkcml2ZQogCiBFWFBPUlRfU1lNQk9MKGlkZV9yYXdfdGFza2Zp
bGUpOwogCitzdGF0aWMgaW50IGlkZV94ZnJzaXplX3RvX3BhZ2VvcmRlcihpbnQgc2l6ZSkKK3sK
KwlpbnQgcGFnZW9yZGVyLCB4LCBudW07CisKKwludW0gPSBzaXplIC8gUEFHRV9TSVpFOworCWlm
IChzaXplICUgUEFHRV9TSVpFKQorCQkrK251bTsKKworCXBhZ2VvcmRlciA9IDA7CisJZm9yICh4
ID0gc2l6ZW9mKG51bSkgKiA4IC0gMTsgeCA+PSAwOyAtLXgpIHsKKwkJaWYgKChudW0gPj4geCkg
JiAxKSB7CisJCQlpZiAocGFnZW9yZGVyKSB7CisJCQkJKytwYWdlb3JkZXI7CisJCQkJYnJlYWs7
CisJCQl9IGVsc2UKKwkJCQlwYWdlb3JkZXIgPSB4OworCQl9CisJfQorCXJldHVybiBwYWdlb3Jk
ZXI7Cit9CisKIGludCBpZGVfdGFza2ZpbGVfaW9jdGwgKGlkZV9kcml2ZV90ICpkcml2ZSwgdW5z
aWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmcpCiB7CiAJaWRlX3Rhc2tfcmVxdWVzdF90
CSpyZXFfdGFzazsKQEAgLTUyMyw2ICs1NDQsOCBAQCBpbnQgaWRlX3Rhc2tmaWxlX2lvY3RsIChp
ZGVfZHJpdmVfdCAqZHJpCiAJaW50IHRhc2tzaXplCQk9IHNpemVvZihzdHJ1Y3QgaWRlX3Rhc2tf
cmVxdWVzdF9zKTsKIAlpbnQgdGFza2luCQk9IDA7CiAJaW50IHRhc2tvdXQJCT0gMDsKKwlpbnQg
aW5vcmRlcgkJPSAwOworCWludCBvdXRvcmRlciAgICAJPSAwOwogCXU4IGlvXzMyYml0CQk9IGRy
aXZlLT5pb18zMmJpdDsKIAljaGFyIF9fdXNlciAqYnVmID0gKGNoYXIgX191c2VyICopYXJnOwog
CkBAIC01NDEsNyArNTY0LDggQEAgaW50IGlkZV90YXNrZmlsZV9pb2N0bCAoaWRlX2RyaXZlX3Qg
KmRyaQogCiAJaWYgKHRhc2tvdXQpIHsKIAkJaW50IG91dHRvdGFsID0gdGFza3NpemU7Ci0JCW91
dGJ1ZiA9IGttYWxsb2ModGFza291dCwgR0ZQX0tFUk5FTCk7CisJCW91dG9yZGVyID0gaWRlX3hm
cnNpemVfdG9fcGFnZW9yZGVyKHRhc2tvdXQpOworCQlvdXRidWYgPSAodTgqKV9fZ2V0X2ZyZWVf
cGFnZXMoR0ZQX0tFUk5FTCwgb3V0b3JkZXIpOwogCQlpZiAob3V0YnVmID09IE5VTEwpIHsKIAkJ
CWVyciA9IC1FTk9NRU07CiAJCQlnb3RvIGFib3J0OwpAQCAtNTU1LDcgKzU3OSw4IEBAIGludCBp
ZGVfdGFza2ZpbGVfaW9jdGwgKGlkZV9kcml2ZV90ICpkcmkKIAogCWlmICh0YXNraW4pIHsKIAkJ
aW50IGludG90YWwgPSB0YXNrc2l6ZSArIHRhc2tvdXQ7Ci0JCWluYnVmID0ga21hbGxvYyh0YXNr
aW4sIEdGUF9LRVJORUwpOworCQlpbm9yZGVyID0gaWRlX3hmcnNpemVfdG9fcGFnZW9yZGVyKHRh
c2tpbik7CisJCWluYnVmID0gKHU4KilfX2dldF9mcmVlX3BhZ2VzKEdGUF9LRVJORUwsIGlub3Jk
ZXIpOwogCQlpZiAoaW5idWYgPT0gTlVMTCkgewogCQkJZXJyID0gLUVOT01FTTsKIAkJCWdvdG8g
YWJvcnQ7CkBAIC02NTAsOSArNjc1LDkgQEAgaW50IGlkZV90YXNrZmlsZV9pb2N0bCAoaWRlX2Ry
aXZlX3QgKmRyaQogYWJvcnQ6CiAJa2ZyZWUocmVxX3Rhc2spOwogCWlmIChvdXRidWYgIT0gTlVM
TCkKLQkJa2ZyZWUob3V0YnVmKTsKKwkJZnJlZV9wYWdlcygodW5zaWduZWQgbG9uZylvdXRidWYs
IG91dG9yZGVyKTsKIAlpZiAoaW5idWYgIT0gTlVMTCkKLQkJa2ZyZWUoaW5idWYpOworCQlmcmVl
X3BhZ2VzKCh1bnNpZ25lZCBsb25nKWluYnVmLCBpbm9yZGVyKTsKIAogLy8JcHJpbnRrKCJJREUg
VGFza2ZpbGUgaW9jdGwgZW5kZWQuIHJjID0gJWlcbiIsIGVycik7CiAK

------_=_NextPart_001_01C5DF17.51AC9496--
