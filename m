From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch] use __u8 rather than u8 in userspace SIZE defines in hdreg.h
Date: Sun, 28 Jan 2007 07:17:47 -0500
Message-ID: <200701280717.48776.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sRJvFzs44WlYfJn"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:42152 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbXA1MRJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Jan 2007 07:17:09 -0500
Received: from home.wh0rd.org (pool-151-203-5-76.bos.east.verizon.net [151.203.5.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 781A864C69
	for <linux-ide@vger.kernel.org>; Sun, 28 Jan 2007 12:17:07 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

--Boundary-00=_sRJvFzs44WlYfJn
Content-Type: multipart/signed;
  boundary="nextPart10451067.z3RKCag94U";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart10451067.z3RKCag94U
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the hdreg.h exports some SIZE defines to userspace but it utilizes sizeof(u=
8)=20
in its definition ... that's no good so the trivial attached patch changes=
=20
that to sizeof(__u8)
=2Dmike

--nextPart10451067.z3RKCag94U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iQIVAwUARbyUbEFjO5/oN/WBAQJHrxAAzudDzqQLAzGrWjB9AyQ4cytrKdIFyjyV
BVOOggsHcBc+7G437iU8GL+1914cxNJoDPFHTOtfyvlowKzu4nzb8h3BEbb4oSLh
7iOJ1cTyEnSrPaQiz6QuYdxOhD7pXcei4Bk9XDFL+NkmSKReOMzRQnN2DhEGc746
YZXRXVrwASEm9pc3hdIsZhImOyBdAvXqAoyqSOtFYfmD84bClwWDY7TZ9ZVVwFDX
K0o0bPxdhfV97yvQl6HXhV1AzFXptFqoDzONjbjQKRk138wgcy9n7BekvfEk5PiA
INSsGKnhnt1gV+g8D0AT+fA6bEhe/8LEKcZviFMUkBZpfCZzOSnxvn/U/PhFG07m
ZzadCgd7tLMJqW21BVKAQWOibj8Oq/yPq+zdRXcoexnlTBQrBhxavumvU2BXz+hP
WvcLWwg7Or8dpdCWL6mN89MdhGrVT0oGiPqhVlfWJNZJ5rJ4QPlQJPuhU/JNgTZS
ZzctN/Ilz21zMNzH42rH7y0YGXsda2PVaNzVcZet4APqh9RYHFTyephDK9a4gygW
EowZoGJBMY46H8hgB4VQ+vR/DCo0q4a9XK2KVZMZSKswXqYoVlX5XBMo43kdZdxA
8dnvePV8SFPflbXEfd24lqgukMxMJbj3tYWdf+xoq9C6oiH/A96bw6FmtiT5CSvO
IV1RYPzJ9mc=
=PGUv
-----END PGP SIGNATURE-----

--nextPart10451067.z3RKCag94U--

--Boundary-00=_sRJvFzs44WlYfJn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-use-__-types-in-hdreg-header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-use-__-types-in-hdreg-header.patch"

Use __u8 rather than u8 in SIZE defines exported to userspace.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>

--- a/include/linux/hdreg.h
+++ b/include/linux/hdreg.h
@@ -60,13 +60,15 @@
 #define TAG_MASK		0xf8
 #endif /* __KERNEL__ */
 
+#include <linux/types.h>
+
 /*
  * Command Header sizes for IOCTL commands
  */
 
-#define HDIO_DRIVE_CMD_HDR_SIZE		(4 * sizeof(u8))
-#define HDIO_DRIVE_HOB_HDR_SIZE		(8 * sizeof(u8))
-#define HDIO_DRIVE_TASK_HDR_SIZE	(8 * sizeof(u8))
+#define HDIO_DRIVE_CMD_HDR_SIZE		(4 * sizeof(__u8))
+#define HDIO_DRIVE_HOB_HDR_SIZE		(8 * sizeof(__u8))
+#define HDIO_DRIVE_TASK_HDR_SIZE	(8 * sizeof(__u8))
 
 #define IDE_DRIVE_TASK_INVALID		-1
 #define IDE_DRIVE_TASK_NO_DATA		0

--Boundary-00=_sRJvFzs44WlYfJn--
