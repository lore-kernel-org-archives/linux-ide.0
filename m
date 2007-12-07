From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_sil: fix spurious IRQ handling
Date: Sat, 08 Dec 2007 08:45:27 +0900
Message-ID: <4759DB17.9010505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:20715 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbXLGXpe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Dec 2007 18:45:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1769572wah
        for <linux-ide@vger.kernel.org>; Fri, 07 Dec 2007 15:45:33 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: mark.paulus@technologist.com, sveint@gmail.com, bug-track@fisher-privat.net

Interestingly, sata_sil raises spurious interrupts if it's coupled
with Sil SATA_PATA bridge.  Currently, sata_sil interrupt handler is
strict about spurious interrupts and freezes the port when it occurs.
This patch makes it more forgiving.

* On SATA PHY event interrupt, serror value is checked to see whether
  it really is PHYRDY CHG event.  If not, SATA PHY event interrupt is
  ignored.

* If ATA interrupt occurs while no command is in progress, it's
  cleared and ignored.

This fixes bugzilla bug 9505.

  http://bugzilla.kernel.org/show_bug.cgi?id=9505

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_sil.c |   29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -390,23 +390,28 @@ static void sil_host_intr(struct ata_por
 		sil_scr_read(ap, SCR_ERROR, &serror);
 		sil_scr_write(ap, SCR_ERROR, serror);
 
-		/* Trigger hotplug and accumulate SError only if the
-		 * port isn't already frozen.  Otherwise, PHY events
-		 * during hardreset makes controllers with broken SIEN
-		 * repeat probing needlessly.
+		/* Sometimes spurious interrupts occur, double check
+		 * it's PHYRDY CHG.
 		 */
-		if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
-			ata_ehi_hotplugged(&ap->link.eh_info);
-			ap->link.eh_info.serror |= serror;
+		if (serror & SERR_PHYRDY_CHG) {
+			/* Trigger hotplug and accumulate SError only
+			 * if the port isn't already frozen.
+			 * Otherwise, PHY events during hardreset
+			 * makes controllers with broken SIEN repeat
+			 * probing needlessly.
+			 */
+			if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
+				ata_ehi_hotplugged(&ap->link.eh_info);
+				ap->link.eh_info.serror |= serror;
+			}
+			goto freeze;
 		}
 
-		goto freeze;
+		if (!(bmdma2 & SIL_DMA_COMPLETE))
+			return;
 	}
 
-	if (unlikely(!qc))
-		goto freeze;
-
-	if (unlikely(qc->tf.flags & ATA_TFLAG_POLLING)) {
+	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
 		/* this sometimes happens, just clear IRQ */
 		ata_chk_status(ap);
 		return;
