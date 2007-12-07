From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: clear link->eh_info.serror from ata_std_postreset()
Date: Sat, 08 Dec 2007 08:47:01 +0900
Message-ID: <4759DB75.1010702@gmail.com>
References: <4759DB17.9010505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:23879 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbXLGXrJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Dec 2007 18:47:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1770200wah
        for <linux-ide@vger.kernel.org>; Fri, 07 Dec 2007 15:47:08 -0800 (PST)
In-Reply-To: <4759DB17.9010505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: mark.paulus@technologist.com, sveint@gmail.com, bug-track@fisher-privat.net

link->eh_info.serror is used to cache SError for controllers which
need it cleared from interrupt handler to clear IRQ.  It also should
be cleared after reset just like SError itself.

Make ata_std_postreset() clear link->eh_info.serror too and update
sata_sil such that it doesn't care about bookkeeping the value.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 drivers/ata/sata_sil.c    |   11 +----------
 2 files changed, 2 insertions(+), 10 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3923,6 +3923,7 @@ void ata_std_postreset(struct ata_link *
 	/* clear SError */
 	if (sata_scr_read(link, SCR_ERROR, &serror) == 0)
 		sata_scr_write(link, SCR_ERROR, serror);
+	link->eh_info.serror = 0;
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -394,16 +394,7 @@ static void sil_host_intr(struct ata_por
 		 * it's PHYRDY CHG.
 		 */
 		if (serror & SERR_PHYRDY_CHG) {
-			/* Trigger hotplug and accumulate SError only
-			 * if the port isn't already frozen.
-			 * Otherwise, PHY events during hardreset
-			 * makes controllers with broken SIEN repeat
-			 * probing needlessly.
-			 */
-			if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
-				ata_ehi_hotplugged(&ap->link.eh_info);
-				ap->link.eh_info.serror |= serror;
-			}
+			ap->link.eh_info.serror |= serror;
 			goto freeze;
 		}
 
