From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/13] ata_piix: convert ata_piix to new probing mechanism
Date: Mon, 29 May 2006 15:38:56 +0900
Message-ID: <11488847362755-git-send-email-htejun@gmail.com>
References: <11488847352050-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:50265 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751306AbWE2GjR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:39:17 -0400
Received: by py-out-1112.google.com with SMTP id i75so365089pye
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:39:17 -0700 (PDT)
In-Reply-To: <11488847352050-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert ata_piix to new probing mechanism.  Automatic hotplug is not
supported due to hardware limitation (no PHY event interrupt), but
warm plugging works.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |   87 +++++++++++++++++------------------------------
 1 files changed, 32 insertions(+), 55 deletions(-)

b5bcb83ff6ea2ec505c54d91f8fa806521750eae
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 54c2e52..521b718 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -146,11 +146,10 @@ struct piix_map_db {
 
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
-
-static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes);
-static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
+static void piix_pata_error_handler(struct ata_port *ap);
+static void piix_sata_error_handler(struct ata_port *ap);
 
 static unsigned int in_module_init = 1;
 
@@ -237,8 +236,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.probe_reset		= piix_pata_probe_reset,
-
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -249,7 +246,7 @@ static const struct ata_port_operations 
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= piix_pata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
@@ -269,8 +266,6 @@ static const struct ata_port_operations 
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
 
-	.probe_reset		= piix_sata_probe_reset,
-
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -281,7 +276,7 @@ static const struct ata_port_operations 
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= piix_sata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
@@ -466,59 +461,51 @@ cbl40:
 }
 
 /**
- *	piix_pata_probeinit - probeinit for PATA host controller
+ *	piix_pata_prereset - prereset for PATA host controller
  *	@ap: Target port
  *
- *	Probeinit including cable detection.
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-static void piix_pata_probeinit(struct ata_port *ap)
-{
-	piix_pata_cbl_detect(ap);
-	ata_std_probeinit(ap);
-}
-
-/**
- *	piix_pata_probe_reset - Perform reset on PATA port and classify
- *	@ap: Port to reset
- *	@classes: Resulting classes of attached devices
- *
- *	Reset PATA phy and classify attached devices.
+ *	Prereset including cable detection.
  *
  *	LOCKING:
  *	None (inherited from caller).
  */
-static int piix_pata_probe_reset(struct ata_port *ap, unsigned int *classes)
+static int piix_pata_prereset(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->hard_port_no])) {
 		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
+		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
 	}
 
-	return ata_drive_probe_reset(ap, piix_pata_probeinit,
-				     ata_std_softreset, NULL,
-				     ata_std_postreset, classes);
+	piix_pata_cbl_detect(ap);
+
+	return ata_std_prereset(ap);
+}
+
+static void piix_pata_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, piix_pata_prereset, ata_std_softreset, NULL,
+			   ata_std_postreset);
 }
 
 /**
- *	piix_sata_probe - Probe PCI device for present SATA devices
- *	@ap: Port associated with the PCI device we wish to probe
+ *	piix_sata_prereset - prereset for SATA host controller
+ *	@ap: Target port
  *
  *	Reads and configures SATA PCI device's PCI config register
  *	Port Configuration and Status (PCS) to determine port and
- *	device availability.
+ *	device availability.  Return -ENODEV to skip reset if no
+ *	device is present.
  *
  *	LOCKING:
  *	None (inherited from caller).
  *
  *	RETURNS:
- *	Mask of avaliable devices on the port.
+ *	0 if device is present, -ENODEV otherwise.
  */
-static unsigned int piix_sata_probe (struct ata_port *ap)
+static int piix_sata_prereset(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	const unsigned int *map = ap->host_set->private_data;
@@ -560,29 +547,19 @@ static unsigned int piix_sata_probe (str
 	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
 		ap->id, pcs, present_mask);
 
-	return present_mask;
-}
-
-/**
- *	piix_sata_probe_reset - Perform reset on SATA port and classify
- *	@ap: Port to reset
- *	@classes: Resulting classes of attached devices
- *
- *	Reset SATA phy and classify attached devices.
- *
- *	LOCKING:
- *	None (inherited from caller).
- */
-static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes)
-{
-	if (!piix_sata_probe(ap)) {
+	if (!present_mask) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
+		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
 		return 0;
 	}
 
-	return ata_drive_probe_reset(ap, ata_std_probeinit,
-				     ata_std_softreset, NULL,
-				     ata_std_postreset, classes);
+	return ata_std_prereset(ap);
+}
+
+static void piix_sata_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, piix_sata_prereset, ata_std_softreset, NULL,
+			   ata_std_postreset);
 }
 
 /**
-- 
1.3.2


