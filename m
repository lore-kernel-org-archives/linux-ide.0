From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Implement the technote about promise/maxtor drives
Date: Wed, 31 Jan 2007 17:12:51 +0000
Message-ID: <20070131171251.4210bcdb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48165 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932969AbXAaRAe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 12:00:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

I don't have the hardware combination to test this one so would
appreciate people testing it before it goes anywhere further

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_pdc2027x.c linux-2.6.20-rc6-mm3/drivers/ata/pata_pdc2027x.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_pdc2027x.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/pata_pdc2027x.c	2007-01-31 14:31:02.000000000 +0000
@@ -68,6 +68,7 @@
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_post_set_mode(struct ata_port *ap);
 static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);
+static unsigned long pdc2027x_mode_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask);
 
 /*
  * ATA Timing Tables based on 133MHz controller clock.
@@ -146,6 +147,7 @@
 
 static struct ata_port_operations pdc2027x_pata100_ops = {
 	.port_disable		= ata_port_disable,
+	.mode_filter		= ata_pci_default_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -180,6 +182,7 @@
 	.set_piomode		= pdc2027x_set_piomode,
 	.set_dmamode		= pdc2027x_set_dmamode,
 	.post_set_mode		= pdc2027x_post_set_mode,
+	.mode_filter		= pdc2027x_mode_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -334,6 +337,33 @@
 }
 
 /**
+ *	pdc2720x_mode_filter	-	mode selection filter
+ *	@ap: ATA interface
+ *	@adev: ATA device
+ *
+ *	Block UDMA on devices that cause trouble with this controller.
+ */
+
+static unsigned long pdc2027x_mode_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
+{
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
+	struct ata_device *pair = ata_dev_pair(adev);
+	
+	if (adev->class != ATA_DEV_ATA || adev->devno == 0 || pair == NULL)
+		return ata_pci_default_filter(ap, adev, mask);
+
+	/* Check for slave of a Maxtor at UDMA6 */
+	ata_id_c_string(pair->id, model_num, ATA_ID_PROD,
+			  ATA_ID_PROD_LEN + 1);
+	/* If the master is a maxtor in UDMA6 then the slave should not use UDMA 6 */
+	if(strstr(model_num, "Maxtor") == 0 && pair->dma_mode == XFER_UDMA_6)
+		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
+	
+	return ata_pci_default_filter(ap, adev, mask);
+}
+
+
+/**
  *	pdc2027x_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port to configure
  *	@adev: um
