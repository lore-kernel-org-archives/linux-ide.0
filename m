From: akpm@linux-foundation.org
Subject: [patch 08/10] libata: add a horkage entry for DRQ mishandling (atapi tapes)
Date: Tue, 02 Oct 2007 13:53:04 -0700
Message-ID: <200710022053.l92Kr4md021700@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35690 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753915AbXJBUxb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 16:53:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

This will allow us to handle the tape drive problems Mark Lord reported

On Thu, 20 Sep 2007 22:42:17 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > According to information I have received, some ATA (and possibly ATAPI?) 
> > devices intentionally return some data in these cases.  In the case of 
> > certain ATA devices, this returned data permits inspection of the 
> > incorrected data.
> 
> News to me. ATA like ST-506/ST-412 exposes error data on I/O READ/WRITE
> via the READ_BUFFER functionality but its basically useless without a lot
> of knowledge of the drive on anything post ST-412 era.
> 
> Got any references ?
> 
> The other possibility is to whine but accept it happens - on the other
> hand being lax about HSM errors is asking for corruption and it seems
> to be unique to this tape device.
> 
> (and someone please don't tell me early pre ATAPI standard devices are
> trying to return the sense data in this way or I'll be ill)

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    9 +++++++--
 include/linux/libata.h    |    1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-add-a-horkage-entry-for-drq-mishandling-atapi drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-add-a-horkage-entry-for-drq-mishandling-atapi
+++ a/drivers/ata/libata-core.c
@@ -5240,8 +5240,13 @@ fsm_start:
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
 			ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
 					"error, dev_stat 0x%X\n", status);
-			qc->err_mask |= AC_ERR_HSM;
-			ap->hsm_task_state = HSM_ST_ERR;
+
+			/* Some tape drives muck this up so don't explode
+			   in those cases */
+			if (!(qc->dev->horkage & ATA_HORKAGE_DRQ)) {
+				qc->err_mask |= AC_ERR_HSM;
+				ap->hsm_task_state = HSM_ST_ERR;
+			}
 			goto fsm_start;
 		}
 
diff -puN include/linux/libata.h~libata-add-a-horkage-entry-for-drq-mishandling-atapi include/linux/libata.h
--- a/include/linux/libata.h~libata-add-a-horkage-entry-for-drq-mishandling-atapi
+++ a/include/linux/libata.h
@@ -338,6 +338,7 @@ enum {
 	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
 	ATA_HORKAGE_SKIP_PM	= (1 << 5),	/* Skip PM operations */
 	ATA_HORKAGE_HPA_SIZE	= (1 << 6),	/* native size off by one */
+	ATA_HORKAGE_DRQ		= (1 << 7),	/* Device forgets to clear DRQ on error */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT 
 	    renumber */
_
