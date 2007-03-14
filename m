From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: always use polling SETXFER
Date: Wed, 14 Mar 2007 14:33:38 +0900
Message-ID: <20070314053338.GA15600@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:21970 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933830AbXCNFdq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 01:33:46 -0400
Received: by wr-out-0506.google.com with SMTP id i28so51294wra
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 22:33:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, pmhahn@titan.lahn.de, flyboy@gmail.com

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

Jeff Garzik suggests that, in the long term, it might be better to
modify libata HSM implementation such that we're more tolerant of
erratic ATAPI IRQ behavior - e.g. default to IRQ but falling back to
polling if the device doesn't seem ready at the point of interrupt.
Such change might be necessary to support ancient/weird ATAPI devices.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14629a3..3a8da9d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3575,10 +3575,13 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
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
 
@@ -5036,14 +5039,6 @@ unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
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
index 96b7179..377e792 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -426,7 +426,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* Early VIA without UDMA support */
 	static struct ata_port_info via_mwdma_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops
@@ -434,7 +434,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* Ditto with IRQ masking required */
 	static struct ata_port_info via_mwdma_info_borked = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.port_ops = &via_port_ops_noirq,
@@ -442,7 +442,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* VIA UDMA 33 devices (and borked 66) */
 	static struct ata_port_info via_udma33_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7,
@@ -451,7 +451,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* VIA UDMA 66 devices */
 	static struct ata_port_info via_udma66_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
@@ -460,7 +460,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* VIA UDMA 100 devices */
 	static struct ata_port_info via_udma100_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
@@ -469,7 +469,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* UDMA133 with bad AST (All current 133) */
 	static struct ata_port_info via_udma133_info = {
 		.sht = &via_sht,
-		.flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SETXFER_POLLING,
+		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7f,	/* FIXME: should check north bridge */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0ad28a3..b9fc57c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -171,7 +171,6 @@ enum {
 	ATA_FLAG_SKIP_D2H_BSY	= (1 << 12), /* can't wait for the first D2H
 					      * Register FIS clearing BSY */
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
-	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
 
