From: akpm@linux-foundation.org
Subject: [patch 10/10] libata: fix (hopefully) all the remaining problems with devices failing setup/identify
Date: Tue, 02 Oct 2007 13:53:05 -0700
Message-ID: <200710022053.l92Kr5Rj021706@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33984 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753901AbXJBUxS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 16:53:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk

From: Alan <alan@lxorguk.ukuu.org.uk>

Two fixes in this test patch.  One of them allows old CF cards to refuse
pio mode setting, and one to wait for the drive to settle after a set
features changes the speed settings, which is based upon the workarounds
used by drivers/ide.

Please test and report back if you have an afflicted system.  This patch
isn't for merging just testing.

The CF card fix will still display errors when the card works (got fixes
for that once I know the cure works) but should then be found/usable.

Not signed off by anyone, not for merging


Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff -puN drivers/ata/libata-core.c~libata-fix-hopefully-all-the-remaining-problems-with drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-fix-hopefully-all-the-remaining-problems-with
+++ a/drivers/ata/libata-core.c
@@ -5933,6 +5933,7 @@ inline unsigned int ata_host_intr (struc
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
 	u8 status, host_stat = 0;
+	int i;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
@@ -5989,6 +5990,20 @@ inline unsigned int ata_host_intr (struc
 	if (unlikely(status & ATA_BUSY))
 		goto idle_irq;
 
+	if (unlikely(qc->tf.command == ATA_CMD_SET_FEATURES &&
+			qc->tf.feature == SETFEATURES_XFER)) {
+		/* Let the timings change settle and the drive catch up as
+		   some hardware needs up to 10uS to get its brain back in
+		   gear. Taken from the workarounds in drivers/ide done by
+		   Matthew Faupel/Niccolo Rigacci */
+		for (i = 0; i < 10; i++) {
+			if ((status & (ATA_BUSY | ATA_DRQ | ATA_ERR)) == 0)
+				break;
+			udelay(1);
+			status = ata_chk_status(ap);
+		}
+	}
+
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
 
_
