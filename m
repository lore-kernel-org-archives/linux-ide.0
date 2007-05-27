From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: always use polling SETXFER
Date: Sun, 27 May 2007 15:10:40 +0200
Message-ID: <46598350.6030403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:25992 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbXE0NKz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 May 2007 09:10:55 -0400
Received: by nz-out-0506.google.com with SMTP id n1so667236nzf
        for <linux-ide@vger.kernel.org>; Sun, 27 May 2007 06:10:54 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Several people have reported LITE-ON LTR-48246S detection failed
because SETXFER fails.  It seems the device raises IRQ too early after
SETXFER.  This is controller independent.  The same problem has been
reported for different controllers.

So, now we have pata_via where the controller raises IRQ before it's
ready after SETXFER and a device which does similar thing.  This patch
makes libata always execute SETXFER via polling.  As this only happens
during EH, performance impact is nil.  Setting ATA_TFLAG_POLLING is
also moved from issue hot path to ata_dev_set_xfermode() - the only
place where SETXFER can be issued.

Note that ATA_TFLAG_POLLING applies only to drivers which implement
SFF TF interface and use libata HSM.  More advanced controllers ignore
the flag.  This doesn't matter for this fix as SFF TF controllers are
the problematic ones.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   13 ++++---------
 drivers/ata/pata_via.c    |   12 ++++++------
 include/linux/libata.h    |    1 -
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3ca9c61..4d6de65 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3932,10 +3932,13 @@ static unsigned int ata_dev_set_xfermode
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
 
+	/* Some controllers and ATAPI devices show flaky interrupt
+	 * behavior after setting xfer mode.  Use polling instead.
+	 */
 	ata_tf_init(dev, &tf);
 	tf.command = ATA_CMD_SET_FEATURES;
 	tf.feature = SETFEATURES_XFER;
-	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE | ATA_TFLAG_POLLING;
 	tf.protocol = ATA_PROT_NODATA;
 	tf.nsect = dev->xfer_mode;
 
@@ -5413,14 +5416,6 @@ unsigned int ata_qc_issue_prot(struct at
 		}
 	}
 
-	/* Some controllers show flaky interrupt behavior after
-	 * setting xfer mode.  Use polling instead.
-	 */
-	if (unlikely(qc->tf.command == ATA_CMD_SET_FEATURES &&
-		     qc->tf.feature == SETFEATURES_XFER) &&
-	    (ap->flags & ATA_FLAG_SETXFER_POLLING))
-		qc->tf.flags |= ATA_TFLAG_POLLING;
-
 	/* select the device */
 	ata_dev_select(ap, qc->dev->devno, 1, 0);
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index a8462f1..63eca29 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -452,7 +452,7 @@ static int via_init_one(struct pci_dev *
 	/* Early VIA without UDMA support */
 	static const struct ata_port_info via_mwdma_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops
@@ -460,7 +460,7 @@ static int via_init_one(struct pci_dev *
 	/* Ditto with IRQ masking required */
 	static const struct ata_port_info via_mwdma_info_borked = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops_noirq,
@@ -468,7 +468,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 33 devices (and borked 66) */
 	static const struct ata_port_info via_udma33_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7,
@@ -477,7 +477,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 66 devices */
 	static const struct ata_port_info via_udma66_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
@@ -486,7 +486,7 @@ static int via_init_one(struct pci_dev *
 	/* VIA UDMA 100 devices */
 	static const struct ata_port_info via_udma100_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -495,7 +495,7 @@ static int via_init_one(struct pci_dev *
 	/* UDMA133 with bad AST (All current 133) */
 	static const struct ata_port_info via_udma133_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,	/* FIXME: should check north bridge */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 85f7b1b..a6a3113 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -171,7 +171,6 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
-	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
 	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */

