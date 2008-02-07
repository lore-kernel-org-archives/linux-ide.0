From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove stale version number
Date: Thu, 7 Feb 2008 22:15:54 +0100
Message-ID: <200802072215.54384.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:59350 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934804AbYBGVCu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 16:02:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so58488wah.23
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 13:02:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>


On Thursday 03 January 2008, Robert Hancock wrote:

[...]

> How about getting rid of this stupid thing in drivers/ide/ide.c:
>=20
> #define=A0=A0=A0=A0=A0=A0=A0REVISION=A0=A0=A0=A0=A0=A0=A0=A0"Revision=
: 7.00alpha2"
>=20
> which is used in:
>=20
> printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n"=
);
>=20
> It's been 7.00alpha2 for god knows how long, so clearly this version=20
> number is not useful..

Cc: Robert Hancock <hancockr@shaw.ca>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/drivers/ide/ide.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -44,8 +44,6 @@
  *  inspiration from lots of linux users, esp.  hamish@zot.apana.org.a=
u
  */
=20
-#define	REVISION	"Revision: 7.00alpha2"
-
 #define _IDE_C			/* Tell ide.h it's really us */
=20
 #include <linux/module.h>
@@ -1618,7 +1616,7 @@ static int __init ide_init(void)
 {
 	int ret;
=20
-	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n"=
);
+	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver\n");
 	system_bus_speed =3D ide_system_bus_speed();
=20
 	printk(KERN_INFO "ide: Assuming %dMHz system bus speed "
