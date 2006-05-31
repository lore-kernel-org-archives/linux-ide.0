From: Velu Erwan <erwan@seanodes.com>
Subject: Re: [PATCH] Re: ATIIXP and libata
Date: Thu, 01 Jun 2006 00:00:25 +0200
Message-ID: <447E11F9.1030804@seanodes.com>
References: <20051105152756.86796.qmail@web86805.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from seanodes.co.fr.clara.net ([212.43.220.11]:51842 "EHLO
	seanodes.co.fr.clara.net") by vger.kernel.org with ESMTP
	id S965196AbWEaWA3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 18:00:29 -0400
In-Reply-To: <20051105152756.86796.qmail@web86805.mail.ukl.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bruno Harbulot <bruno_harbulot@yahoo.co.uk>, linux-ide@vger.kernel.org

Bruno Harbulot a =E9crit :

>I had a closer look at the problem, and I've written the patch for
>ide-iops.c attached to this message. I wasn't sure about using
>hw_config or ata_id_is_sata to read word 93.
>Should other checks be performed? I'm not sure whether there should be
>a test similar to "(ap->cbl =3D=3D ATA_CBL_SATA)" mentionned in the pa=
tch
>posted on this list in "[PATCH] libata ATA vs SATA detection and
>workaround." on 30/09/04.
> =20
>
Bartlomiej, I've tried the latest 2.6.17-rc5 and the atiixp still=20
doesn't works out of the shelf.
Bruno's patch sounds to integrate the remarks you made about my crappy=20
initial patch but it is not integrated.
I've applied it, and uncommenting its ata_id_is_sata() call.
On my ATIIXP (pundit-R), my performances are good ~55MB/sec. Without=20
this patch I'm sticked at 14MB/sec.

It is possible to apply that patch upstream to fix this issue ?
This patch applies to 2.6.17-rc5.

--- linux-2.6.17-rc5.20mdk/drivers/ide/ide-iops.c.old    2006-03-20=20
06:53:29.000000000 +0100
+++ linux-2.6.17-rc5.20mdk/drivers/ide/ide-iops.c    2006-05-31=20
23:51:53.000000000 +0200
@@ -1,6 +1,10 @@
 /*
+ * linux/drivers/ide/ide-iops.c    Version 0.38    Nov 05, 2005
  * linux/drivers/ide/ide-iops.c    Version 0.37    Mar 05, 2003
  *
+ *  Version 0.38        80pin cable detection for SATA drive
+ *                  (bruno_harbulot@yahoo.co.uk)
+ *=20
  *  Copyright (C) 2000-2002    Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2003        Red Hat <alan@redhat.com>
  *
@@ -24,6 +28,7 @@
 #include <linux/hdreg.h>
 #include <linux/ide.h>
 #include <linux/bitops.h>
+#include <linux/ata.h>
=20
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -595,6 +600,12 @@
  */
 u8 eighty_ninty_three (ide_drive_t *drive)
 {
+    /* On SATA drives, word 93 (i.e. hw_config) should be 0.
+     * This can be tested with the hw_config or this: */
+    if (ata_id_is_sata((u16*)(drive->id)))
+        return 1;
+    if (drive->id->hw_config =3D=3D 0)
+        return 1;
     if(HWIF(drive)->udma_four =3D=3D 0)
         return 0;
     if (!(drive->id->hw_config & 0x6000))
