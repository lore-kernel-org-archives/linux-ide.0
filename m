From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_via: Cache and rewrite the device bit
Date: Fri, 17 Apr 2009 12:21:21 +0100
Message-ID: <20090417111946.25043.97103.stgit@t61.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:34985 "EHLO
	t61.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757111AbZDQKWf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 06:22:35 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Some VIA chipsets will reset the DEV bit after IEN changes on ctl. Our
optimised write path avoids doing this but we need to remove the
optimisation on these devices.

[Identified and some original patches proposed by Josehn Chan @ VIA but
discussion then all ground to a halt so given a test case I dug it back out]

Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk
Tested-by: Christoph Bisping (bug #13086)
---

 drivers/ata/pata_via.c |   74 +++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 67 insertions(+), 7 deletions(-)


diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index b08e6e0..45657ca 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -62,7 +62,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_via"
-#define DRV_VERSION "0.3.3"
+#define DRV_VERSION "0.3.4"
 
 /*
  *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
@@ -136,6 +136,9 @@ static const struct via_isa_bridge {
 	{ NULL }
 };
 
+struct via_port {
+	u8 cached_device;
+};
 
 /*
  *	Cable special cases
@@ -346,14 +349,70 @@ static void via_set_dmamode(struct ata_port *ap, struct ata_device *adev)
  */
 static void via_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
 {
-	struct ata_taskfile tmp_tf;
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	struct via_port *vp = ap->private_data;
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+	int newctl = 0;
+
+	if (tf->ctl != ap->last_ctl) {
+		iowrite8(tf->ctl, ioaddr->ctl_addr);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+		newctl = 1;
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		iowrite8(tf->device, ioaddr->device_addr);
+		vp->cached_device = tf->device;
+	} else if (newctl)
+		iowrite8(vp->cached_device, ioaddr->device_addr);
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		WARN_ON_ONCE(!ioaddr->ctl_addr);
+		iowrite8(tf->hob_feature, ioaddr->feature_addr);
+		iowrite8(tf->hob_nsect, ioaddr->nsect_addr);
+		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
+		iowrite8(tf->hob_lbam, ioaddr->lbam_addr);
+		iowrite8(tf->hob_lbah, ioaddr->lbah_addr);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
 
-	if (ap->ctl != ap->last_ctl && !(tf->flags & ATA_TFLAG_DEVICE)) {
-		tmp_tf = *tf;
-		tmp_tf.flags |= ATA_TFLAG_DEVICE;
-		tf = &tmp_tf;
+	if (is_addr) {
+		iowrite8(tf->feature, ioaddr->feature_addr);
+		iowrite8(tf->nsect, ioaddr->nsect_addr);
+		iowrite8(tf->lbal, ioaddr->lbal_addr);
+		iowrite8(tf->lbam, ioaddr->lbam_addr);
+		iowrite8(tf->lbah, ioaddr->lbah_addr);
+		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
 	}
-	ata_sff_tf_load(ap, tf);
+
+	ata_wait_idle(ap);
+}
+
+static int via_port_start(struct ata_port *ap)
+{
+	struct via_port *vp;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	int ret = ata_sff_port_start(ap);
+	if (ret < 0)
+		return ret;
+
+	vp = devm_kzalloc(&pdev->dev, sizeof(struct via_port), GFP_KERNEL);
+	if (vp == NULL)
+		return -ENOMEM;
+	ap->private_data = vp;
+	return 0;
 }
 
 static struct scsi_host_template via_sht = {
@@ -367,6 +426,7 @@ static struct ata_port_operations via_port_ops = {
 	.set_dmamode	= via_set_dmamode,
 	.prereset	= via_pre_reset,
 	.sff_tf_load	= via_tf_load,
+	.port_start	= via_port_start,
 };
 
 static struct ata_port_operations via_port_ops_noirq = {

