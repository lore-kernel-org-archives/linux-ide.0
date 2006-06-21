From: Velu Erwan <erwan@seanodes.com>
Subject: ATIIXP patch
Date: Wed, 21 Jun 2006 11:23:16 +0200
Message-ID: <44991004.8080509@seanodes.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010809000006070407080706"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from seanodes.co.fr.clara.net ([212.43.220.11]:48877 "EHLO
	seanodes.co.fr.clara.net") by vger.kernel.org with ESMTP
	id S1751355AbWFUJuO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Jun 2006 05:50:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org
Cc: bzolnier@gmail.com, Bruno Harbulot <bruno_harbulot@yahoo.co.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010809000006070407080706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hey Andrew,

As suggested by Randy Dunlap on the linux-ide mailing list 
(http://marc.theaimsgroup.com/?l=linux-ide&m=115082279504424&w=2),
I send you this patch Bruno Harbulot did on a previous 'really crappy' 
patch I did.

We've been testing it for a while, it works fine so we'd like to see it 
intergrated in your tree and maybe upstream later.

This patch allow the sata port of the ATIIXP chipset to work at 55MB/sec 
instead of 14.

Regards,
Erwan

--------------010809000006070407080706
Content-Type: text/x-patch;
 name="ide-iops.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-iops.c.patch"

--- linux-source-2.6.14.orig/drivers/ide/ide-iops.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-source-2.6.14/drivers/ide/ide-iops.c	2005-11-05 14:58:04.000000000 +0000
@@ -1,6 +1,10 @@
 /*
+ * linux/drivers/ide/ide-iops.c	Version 0.38	Nov 05, 2005
  * linux/drivers/ide/ide-iops.c	Version 0.37	Mar 05, 2003
  *
+ *  Version 0.38		80pin cable detection for SATA drive
+ *  				(bruno_harbulot@yahoo.co.uk)
+ *  
  *  Copyright (C) 2000-2002	Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2003		Red Hat <alan@redhat.com>
  *
@@ -601,6 +605,14 @@
  */
 u8 eighty_ninty_three (ide_drive_t *drive)
 {
+	/* On SATA drives, word 93 (i.e. hw_config) should be 0.
+	 * This can be tested with the hw_config or this:
+	   if (ata_id_is_sata((u16*)(drive->id)))
+		return 1;
+	 * (remember to include <linux/ata.h>)
+	 */
+	if (drive->id->hw_config == 0)
+		return 1;
 	if(HWIF(drive)->udma_four == 0)
 		return 0;
 	if (!(drive->id->hw_config & 0x6000))

--------------010809000006070407080706--
