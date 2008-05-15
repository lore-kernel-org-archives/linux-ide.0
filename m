From: Tejun Heo <htejun@gmail.com>
Subject: libata: force hardreset if link is in powersave mode
Date: Thu, 15 May 2008 22:14:57 +0900
Message-ID: <482C3751.8030206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:47368 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbYEONPE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2008 09:15:04 -0400
Received: by wr-out-0506.google.com with SMTP id c48so134365wra.1
        for <linux-ide@vger.kernel.org>; Thu, 15 May 2008 06:15:04 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org
Cc: matthieu.castet@parrot.com

Inhibiting link PM mode doesn't bring the link back online if it's
already in powersave mode.  If SRST is used in these cases, libata EH
thinks that the link is offline and fails detection.  Force hardreset
if link is in powersave mode.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Patch for -stable only.  Devel branch now uses hardreset by default so
this type of promotion logic isn't necessary anymore.

 drivers/ata/libata-core.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6.25/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.25.orig/drivers/ata/libata-core.c
+++ linux-2.6.25/drivers/ata/libata-core.c
@@ -3960,6 +3960,7 @@ int ata_std_prereset(struct ata_link *li
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
+	u32 sstatus;
 	int rc;
 
 	/* handle link resume */
@@ -3973,6 +3974,17 @@ int ata_std_prereset(struct ata_link *li
 	if (ap->flags & ATA_FLAG_PMP)
 		ehc->i.action |= ATA_EH_HARDRESET;
 
+	/* if link powersave is on, force hardreset */
+	if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0) {
+		u8 ipm = sstatus >> 8;
+
+		if (ipm == 2 || ipm == 6) {
+			ata_link_printk(link, KERN_INFO, "link in powersave "
+				"mode (ipm=%d), forcing hardreset\n", ipm);
+			ehc->i.action |= ATA_EH_HARDRESET;
+		}
+	}
+
 	/* if we're about to do hardreset, nothing more to do */
 	if (ehc->i.action & ATA_EH_HARDRESET)
 		return 0;
