From: <Stuart_Hayes@Dell.com>
Subject: RE: ide-cd question
Date: Fri, 4 Mar 2005 16:37:12 -0600
Message-ID: <7A8F92187EF7A249BF847F1BF4903C04010EE978@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5210A.B5061A58"
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:18950 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S263148AbVCDWh1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2005 17:37:27 -0500
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: axboe@suse.de
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, stuarthayes@austin.rr.com

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5210A.B5061A58
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


>=20
> There's still a problem here, you are not initializing nsectors for
> non-pc requests. And your comments wrap :)=20
>=20
>         int nsectors =3D rq->hard_nr_sectors;
>=20
>         if (blk_pc_request(rq))
>                 nsectors =3D (rq->data_len + 511) >> 9;
>         if (!nsectors)
>                 nsectors =3D 1;
>=20
>         ...
>=20
> Can you resend with that fixed up and with a Signed-off-by header?

Here it is.  Thanks for all the help.  I'm attaching as a file, too,
just in case it gets garbled again.
Stuart


Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>

--- linux-2.6.11/drivers/ide/ide-io.c.orig	2005-03-04
16:11:14.000000000 -0500
+++ linux-2.6.11/drivers/ide/ide-io.c	2005-03-04 16:19:19.000000000
-0500
@@ -516,7 +516,19 @@ static ide_startstop_t ide_atapi_error(i
 		hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
=20
 	if (rq->errors >=3D ERROR_MAX) {
-		drive->driver->end_request(drive, 0, 0);
+		/*=20
+		 * make sure request is fully ended--otherwise the=20
+		 * command will be retried without rq->errors getting
+		 * reset to zero, which could cause us to get stuck
+		 * in a loop with infinite retries without any more
+		 * reset attempts
+		 */
+		int nsectors =3D rq->hard_nr_sectors;
+		if (blk_pc_request(rq))
+			nsectors =3D (rq->data_len + 511) >> 9;
+		if (!nsectors)
+			nsectors =3D 1;
+		drive->driver->end_request(drive, 0, nsectors);
 	} else {
 		if ((rq->errors & ERROR_RESET) =3D=3D ERROR_RESET) {
 			++rq->errors;

------_=_NextPart_001_01C5210A.B5061A58
Content-Type: application/octet-stream;
	name="atapi_max_errors_d_2.6.11.patch"
Content-Transfer-Encoding: base64
Content-Description: atapi_max_errors_d_2.6.11.patch
Content-Disposition: attachment;
	filename="atapi_max_errors_d_2.6.11.patch"

LS0tIGxpbnV4LTIuNi4xMS9kcml2ZXJzL2lkZS9pZGUtaW8uYy5vcmlnCTIwMDUtMDMtMDQgMTY6
MTE6MTQuMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYuMTEvZHJpdmVycy9pZGUvaWRlLWlv
LmMJMjAwNS0wMy0wNCAxNjoxOToxOS4wMDAwMDAwMDAgLTA1MDAKQEAgLTUxNiw3ICs1MTYsMTkg
QEAgc3RhdGljIGlkZV9zdGFydHN0b3BfdCBpZGVfYXRhcGlfZXJyb3IoaQogCQlod2lmLT5PVVRC
KFdJTl9JRExFSU1NRURJQVRFLCBJREVfQ09NTUFORF9SRUcpOwogCiAJaWYgKHJxLT5lcnJvcnMg
Pj0gRVJST1JfTUFYKSB7Ci0JCWRyaXZlLT5kcml2ZXItPmVuZF9yZXF1ZXN0KGRyaXZlLCAwLCAw
KTsKKwkJLyogCisJCSAqIG1ha2Ugc3VyZSByZXF1ZXN0IGlzIGZ1bGx5IGVuZGVkLS1vdGhlcndp
c2UgdGhlIAorCQkgKiBjb21tYW5kIHdpbGwgYmUgcmV0cmllZCB3aXRob3V0IHJxLT5lcnJvcnMg
Z2V0dGluZworCQkgKiByZXNldCB0byB6ZXJvLCB3aGljaCBjb3VsZCBjYXVzZSB1cyB0byBnZXQg
c3R1Y2sKKwkJICogaW4gYSBsb29wIHdpdGggaW5maW5pdGUgcmV0cmllcyB3aXRob3V0IGFueSBt
b3JlCisJCSAqIHJlc2V0IGF0dGVtcHRzCisJCSAqLworCQlpbnQgbnNlY3RvcnMgPSBycS0+aGFy
ZF9ucl9zZWN0b3JzOworCQlpZiAoYmxrX3BjX3JlcXVlc3QocnEpKQorCQkJbnNlY3RvcnMgPSAo
cnEtPmRhdGFfbGVuICsgNTExKSA+PiA5OworCQlpZiAoIW5zZWN0b3JzKQorCQkJbnNlY3RvcnMg
PSAxOworCQlkcml2ZS0+ZHJpdmVyLT5lbmRfcmVxdWVzdChkcml2ZSwgMCwgbnNlY3RvcnMpOwog
CX0gZWxzZSB7CiAJCWlmICgocnEtPmVycm9ycyAmIEVSUk9SX1JFU0VUKSA9PSBFUlJPUl9SRVNF
VCkgewogCQkJKytycS0+ZXJyb3JzOwo=

------_=_NextPart_001_01C5210A.B5061A58--
