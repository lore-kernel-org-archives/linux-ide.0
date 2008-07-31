From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] pata_via: clean up recent tf_load changes
Date: Thu, 31 Jul 2008 18:02:35 +0900
Message-ID: <48917FAB.3000703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59856 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbYGaJEJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 05:04:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, JosephChan@via.com.tw

Commit bfce5e0179ad059035df28558724ff60af708e09 implemented custom
tf_load for pata_via.  This patch cleans it up a bit.

* Instead of duplicating whole body, copy tf and set ATA_TFLAG_DEVICE
  when necessary.

* Rename via_ata_tf_load() to via_tf_load().

* No need to set .tf_load in via_port_ops_noirq as it inherits from
  via_port_ops.

* Clean up indentation.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/ata/pata_via.c |   59 +++++++++----------------------------------------
 1 file changed, 11 insertions(+), 48 deletions(-)

diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 57d951b..8fdb2ce 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -324,62 +324,26 @@ static void via_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 }
 
 /**
- *	via_ata_sff_tf_load - send taskfile registers to host controller
+ *	via_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
  *
  *	Outputs ATA taskfile to standard ATA host controller.
  *
  *	Note: This is to fix the internal bug of via chipsets, which
- *  will reset the device register after changing the IEN bit on
- *  ctl register
+ *	will reset the device register after changing the IEN bit on
+ *	ctl register
  */
-static void via_ata_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
+static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	struct ata_ioports *ioaddr = &ap->ioaddr;
-	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
-
-	if (tf->ctl != ap->last_ctl) {
-		iowrite8(tf->ctl, ioaddr->ctl_addr);
-		iowrite8(tf->device, ioaddr->device_addr);
-		ap->last_ctl = tf->ctl;
-		ata_wait_idle(ap);
-	}
-
-	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		iowrite8(tf->hob_feature, ioaddr->feature_addr);
-		iowrite8(tf->hob_nsect, ioaddr->nsect_addr);
-		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
-		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
-		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
-		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
-			tf->hob_feature,
-			tf->hob_nsect,
-			tf->hob_lbal,
-			tf->hob_lbam,
-			tf->hob_lbah);
-	}
+	struct ata_taskfile tmp_tf;
 
-	if (is_addr) {
-		iowrite8(tf->feature, ioaddr->feature_addr);
-		iowrite8(tf->nsect, ioaddr->nsect_addr);
-		iowrite8(tf->lbal, ioaddr->lbal_addr);
-		iowrite8(tf->lbam, ioaddr->lbam_addr);
-		iowrite8(tf->lbah, ioaddr->lbah_addr);
-		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
-			tf->feature,
-			tf->nsect,
-			tf->lbal,
-			tf->lbam,
-			tf->lbah);
+	if (ap->ctl != ap->last_ctl && !(tf->flags & ATA_TFLAG_DEVICE)) {
+		tmp_tf = *tf;
+		tmp_tf.flags |= ATA_TFLAG_DEVICE;
+		tf = &tmp_tf;
 	}
-
-	if (tf->flags & ATA_TFLAG_DEVICE) {
-		iowrite8(tf->device, ioaddr->device_addr);
-		VPRINTK("device 0x%X\n", tf->device);
-	}
-
-	ata_wait_idle(ap);
+	ata_sff_tf_load(ap, tf);
 }
 
 static struct scsi_host_template via_sht = {
@@ -392,13 +356,12 @@ static struct ata_port_operations via_port_ops = {
 	.set_piomode	= via_set_piomode,
 	.set_dmamode	= via_set_dmamode,
 	.prereset	= via_pre_reset,
-	.sff_tf_load = via_ata_tf_load,
+	.sff_tf_load	= via_tf_load,
 };
 
 static struct ata_port_operations via_port_ops_noirq = {
 	.inherits	= &via_port_ops,
 	.sff_data_xfer	= ata_sff_data_xfer_noirq,
-	.sff_tf_load = via_ata_tf_load,
 };
 
 /**
