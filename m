From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Fix (hopefully) all the remaining problems with
 devices failing setup/identify
Date: Wed, 31 Jan 2007 17:26:05 +0000
Message-ID: <20070131172605.2c5dfc78@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41422 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030302AbXAaRNo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 12:13:44 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Two fixes in this test patch. One of them allows old CF cards to refuse
pio mode setting, and one to wait for the drive to settle after a set
features changes the speed settings, which is based upon the workarounds
used by drivers/ide.

Please test and report back if you have an afflicted system. This patch
isn't for merging just testing.

The CF card fix will still display errors when the card works (got fixes
for that once I know the cure works) but should then be found/usable.

Not signed off by anyone, not for merging

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-core.c linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-01-31 16:25:43.000000000 +0000
@@ -2404,6 +2418,10 @@
 		dev->flags |= ATA_DFLAG_PIO;
 
 	err_mask = ata_dev_set_xfermode(dev);
+	/* Old CFA may refuse this command, which is just fine */
+	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
+        	err_mask &= ~AC_ERR_DEV;
+
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_ERR, "failed to set xfermode "
 			       "(err_mask=0x%x)\n", err_mask);
@@ -5088,6 +5119,7 @@
 {
 	struct ata_eh_info *ehi = &ap->eh_info;
 	u8 status, host_stat = 0;
+	int i;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
 		ap->id, qc->tf.protocol, ap->hsm_task_state);
@@ -5142,6 +5174,20 @@
 	status = ata_chk_status(ap);
 	if (unlikely(status & ATA_BUSY))
 		goto idle_irq;
+		
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
 
 	/* ack bmdma irq events */
 	ap->ops->irq_clear(ap);
