From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pdc2027x: Restore various updates done on the driver
Date: Thu, 8 Mar 2007 23:39:20 +0000
Message-ID: <20070308233920.7371d07d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53389 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030819AbXCHWfF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:35:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

- Use of cable_detect method
- ata_pci_default_filter needed on PATA100 ops
- Filter for UDMA 133 errata from vendor (not enabled in this diff but
added ready)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_pdc2027x.c linux-2.6.21-rc3-mm2/drivers/ata/pata_pdc2027x.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/pata_pdc2027x.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/pata_pdc2027x.c	2007-03-08 16:34:56.000000000 +0000
@@ -35,7 +35,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.8"
+#define DRV_VERSION	"0.8ac1"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -66,8 +66,10 @@
 static void pdc2027x_error_handler(struct ata_port *ap);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
-static void pdc2027x_post_set_mode(struct ata_port *ap);
 static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);
+static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long mask);
+static int pdc2027x_cable_detect(struct ata_port *ap);
+static int pdc2027x_set_mode(struct ata_port *ap, struct ata_device **r_failed);
 
 /*
  * ATA Timing Tables based on 133MHz controller clock.
@@ -146,6 +148,7 @@
 
 static struct ata_port_operations pdc2027x_pata100_ops = {
 	.port_disable		= ata_port_disable,
+	.mode_filter		= ata_pci_default_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -166,6 +169,7 @@
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= pdc2027x_cable_detect,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -261,7 +267,7 @@
 }
 
 /**
- *	pdc2027x_pata_cbl_detect - Probe host controller cable detect info
+ *	pdc2027x_pata_cable_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
  *
  *	Read 80c cable indicator from Promise extended register.
@@ -270,7 +276,7 @@
  *	LOCKING:
  *	None (inherited from caller).
  */
-static void pdc2027x_cbl_detect(struct ata_port *ap)
+static int pdc2027x_cable_detect(struct ata_port *ap)
 {
 	u32 cgcr;
 
@@ -281,13 +287,10 @@
 
 	PDPRINTK("No cable or 80-conductor cable on port %d\n", ap->port_no);
 
-	ap->cbl = ATA_CBL_PATA80;
-	return;
-
+	return ATA_CBL_PATA80;
 cbl40:
 	printk(KERN_INFO DRV_NAME ": 40-conductor cable detected on port %d\n", ap->port_no);
-	ap->cbl = ATA_CBL_PATA40;
-	ap->udma_mask &= ATA_UDMA_MASK_40C;
+	return ATA_CBL_PATA40;
 }
 
 /**
@@ -315,7 +318,6 @@
 	/* Check whether port enabled */
 	if (!pdc2027x_port_enabled(ap))
 		return -ENOENT;
-	pdc2027x_cbl_detect(ap);
 	return ata_std_prereset(ap, deadline);
 }
 
@@ -335,6 +337,32 @@
 }
 
 /**
+ *	pdc2720x_mode_filter	-	mode selection filter
+ *	@adev: ATA device
+ *	@mask: list of modes proposed
+ *
+ *	Block UDMA on devices that cause trouble with this controller.
+ */
+
+static unsigned long pdc2027x_mode_filter(struct ata_device *adev, unsigned long mask)
+{
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
+	struct ata_device *pair = ata_dev_pair(adev);
+	
+	if (adev->class != ATA_DEV_ATA || adev->devno == 0 || pair == NULL)
+		return ata_pci_default_filter(adev, mask);
+
+	/* Check for slave of a Maxtor at UDMA6 */
+	ata_id_c_string(pair->id, model_num, ATA_ID_PROD,
+			  ATA_ID_PROD_LEN + 1);
+	/* If the master is a maxtor in UDMA6 then the slave should not use UDMA 6 */
+	if(strstr(model_num, "Maxtor") == 0 && pair->dma_mode == XFER_UDMA_6)
+		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
+	
+	return ata_pci_default_filter(adev, mask);
+}
+
+/**
  *	pdc2027x_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port to configure
  *	@adev: um
