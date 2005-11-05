From: Bruno Harbulot <bruno_harbulot@yahoo.co.uk>
Subject: [PATCH] Re: ATIIXP and libata
Date: Sat, 5 Nov 2005 15:27:56 +0000 (GMT)
Message-ID: <20051105152756.86796.qmail@web86805.mail.ukl.yahoo.com>
References: <58cb370e0511040217y778fab7cj47d198b53126f9d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1723501559-1131204476=:84839"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web86805.mail.ukl.yahoo.com ([217.12.13.47]:65423 "HELO
	web86805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932072AbVKEP15 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Nov 2005 10:27:57 -0500
In-Reply-To: <58cb370e0511040217y778fab7cj47d198b53126f9d7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Velu Erwan <erwan@seanodes.com>

--0-1723501559-1131204476=:84839
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

--- Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> > (I don't know much about the subject, but I presume that
> workarounds to
> > get ata_id_is_sata "to work somehow" from atiixp.c would not be the
> > right thing to do, even if feasible.)
> 
> <linux/ata.h> include is used by both IDE and libata
> driver, however ata_id_is_sata() shouldn't be used
> directly in atiixp.c but similar check should be added
> to eighty_ninty_three() from ide-iops.c.
> 

I had a closer look at the problem, and I've written the patch for
ide-iops.c attached to this message. I wasn't sure about using
hw_config or ata_id_is_sata to read word 93.
Should other checks be performed? I'm not sure whether there should be
a test similar to "(ap->cbl == ATA_CBL_SATA)" mentionned in the patch
posted on this list in "[PATCH] libata ATA vs SATA detection and
workaround." on 30/09/04.

It seems that using this, checking that the PCI device is an IXP200 (as
in Erwan's patch) is not necessary.

Regards,

Bruno.


		
___________________________________________________________ 
Does your mail provider give you FREE antivirus protection? 
Get Yahoo! Mail http://uk.mail.yahoo.com
--0-1723501559-1131204476=:84839
Content-Type: text/x-patch; name="ide-iops.c.patch"
Content-Description: 183343436-ide-iops.c.patch
Content-Disposition: inline; filename="ide-iops.c.patch"

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

--0-1723501559-1131204476=:84839--
