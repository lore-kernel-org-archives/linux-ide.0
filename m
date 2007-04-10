From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pdc2027x: Updates
Date: Wed, 11 Apr 2007 00:19:00 +0100
Message-ID: <20070411001900.58ab4a45@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:40766 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161071AbXDJXQF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Apr 2007 19:16:05 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

Correct missing modefilter (crash if BAR4 unassigned)
Use Cable Detect method
Wrap ->set_mode instead ready for ->post_set_mode removal
Maxtor errata as per Jeff Garzik report
Remove duplicated private udma_mask hacking

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 93bcdad..8261f4f 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -35,7 +35,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.8"
+#define DRV_VERSION	"0.9"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -66,8 +66,10 @@ static int pdc2027x_init_one(struct pci_
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
@@ -146,6 +148,7 @@ static struct scsi_host_template pdc2027
 
 static struct ata_port_operations pdc2027x_pata100_ops = {
 	.port_disable		= ata_port_disable,
+	.mode_filter		= ata_pci_default_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -166,6 +169,7 @@ static struct ata_port_operations pdc202
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= pdc2027x_cable_detect,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -179,7 +183,8 @@ static struct ata_port_operations pdc202
 	.port_disable		= ata_port_disable,
 	.set_piomode		= pdc2027x_set_piomode,
 	.set_dmamode		= pdc2027x_set_dmamode,
-	.post_set_mode		= pdc2027x_post_set_mode,
+	.set_mode		= pdc2027x_set_mode,
+	.mode_filter		= pdc2027x_mode_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -200,6 +205,7 @@ static struct ata_port_operations pdc202
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= pdc2027x_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= pdc2027x_cable_detect,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -261,7 +267,7 @@ static inline void __iomem *dev_mmio(str
 }
 
 /**
- *	pdc2027x_pata_cbl_detect - Probe host controller cable detect info
+ *	pdc2027x_pata_cable_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
  *
  *	Read 80c cable indicator from Promise extended register.
@@ -270,7 +276,7 @@ static inline void __iomem *dev_mmio(str
  *	LOCKING:
  *	None (inherited from caller).
  */
-static void pdc2027x_cbl_detect(struct ata_port *ap)
+static int pdc2027x_cable_detect(struct ata_port *ap)
 {
 	u32 cgcr;
 
@@ -281,13 +287,10 @@ static void pdc2027x_cbl_detect(struct a
 
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
@@ -314,7 +317,6 @@ static int pdc2027x_prereset(struct ata_
 	/* Check whether port enabled */
 	if (!pdc2027x_port_enabled(ap))
 		return -ENOENT;
-	pdc2027x_cbl_detect(ap);
 	return ata_std_prereset(ap);
 }
 
@@ -334,6 +336,32 @@ static void pdc2027x_error_handler(struc
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
@@ -444,17 +472,22 @@ static void pdc2027x_set_dmamode(struct 
 }
 
 /**
- *	pdc2027x_post_set_mode - Set the timing registers back to correct values.
+ *	pdc2027x_set_mode - Set the timing registers back to correct values.
  *	@ap: Port to configure
+ *	@r_failed: Returned device for failure
  *
  *	The pdc2027x hardware will look at "SET FEATURES" and change the timing registers
  *	automatically. The values set by the hardware might be incorrect, under 133Mhz PLL.
  *	This function overwrites the possibly incorrect values set by the hardware to be correct.
  */
-static void pdc2027x_post_set_mode(struct ata_port *ap)
+static int pdc2027x_set_mode(struct ata_port *ap, struct ata_device **r_failed)
 {
 	int i;
 
+	i = ata_do_set_mode(ap, r_failed);
+	if (i < 0)
+		return i;
+
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 
@@ -476,6 +509,7 @@ static void pdc2027x_post_set_mode(struc
 			}
 		}
 	}
+	return 0;
 }
 
 /**
