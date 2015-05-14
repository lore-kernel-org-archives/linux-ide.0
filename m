From: wenxiong@linux.vnet.ibm.com
Subject: [PATCH V2] ahci: Add support for EEH error recovery
Date: Thu, 14 May 2015 11:55:17 -0500
Message-ID: <1431622517-5851-1-git-send-email-wenxiong@linux.vnet.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:45559 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932470AbbENQ7g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2015 12:59:36 -0400
Received: from /spool/local
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-ide@vger.kernel.org> from <wenxiong@us.ibm.com>;
	Thu, 14 May 2015 13:59:32 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id C32DE3520054
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 12:58:27 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4EGwKAP852260
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 13:58:20 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4EGxTxS008587
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2015 13:59:29 -0300
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, bjking1@us.ibm.com, wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.vnet.ibm.com>, Brian King <bjking@linux.vnet.ibm.com>

From: Wen Xiong <wenxiong@linux.vnet.ibm.com>

On the Power platform, the pci_error_handlers map to our EEH recovery.
In that case, without this patch, if we hit any sort of PCIe error, we
won't be able to recover and we'll lose all access to the ahci disks.
This could be the adapter trying to access an invalid DMA address due
to a transient hardware issue, or it could be due to a driver bug giving
the adapter an invalid address. It could also be other various PCIe
errors that cause our PCIe bridge chip to isolate the device and
place it into the EEH "frozen" state. When this occurs, if the driver
associated with the hardware does not have these handlers registered,
powerpc arch kernel code will hotplug remove the adapter, recover the
adapter, then hotplug add it back. This works OK for some devices,
but generally not so well for storage devices with mounted filesystems,
which would tend to go readonly in this case.

This patch adds the callback functions to support EEH(Extended Error
Handling) error recovery in ahci driver. Also adds the code in
ahci_error_handler to issue an MMIO load then check if it is in EEH.
If it is in EEH, ahci_error_handler will wait until EEH recovery is completed.

Signed-off-by: Wen Xiong <wenxiong@linux.vnet.ibm.com>
Signed-off-by: Brian King <bjking@linux.vnet.ibm.com>

---
 drivers/ata/ahci.c    |   70 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci.h    |    3 ++
 drivers/ata/libahci.c |   11 +++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 65ee944..0184677 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -96,6 +96,10 @@ static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int ahci_pci_device_resume(struct pci_dev *pdev);
 #endif
 
+static pci_ers_result_t ahci_pci_error_detected(struct pci_dev *pdev,
+					       pci_channel_state_t state);
+static pci_ers_result_t ahci_pci_slot_reset(struct pci_dev *pdev);
+
 static struct scsi_host_template ahci_sht = {
 	AHCI_SHT("ahci"),
 };
@@ -520,6 +524,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ }	/* terminate list */
 };
 
+static const struct pci_error_handlers ahci_err_handler = {
+	.error_detected = ahci_pci_error_detected,
+	.slot_reset = ahci_pci_slot_reset,
+};
 
 static struct pci_driver ahci_pci_driver = {
 	.name			= DRV_NAME,
@@ -530,6 +538,7 @@ static struct pci_driver ahci_pci_driver = {
 	.suspend		= ahci_pci_device_suspend,
 	.resume			= ahci_pci_device_resume,
 #endif
+	.err_handler		= &ahci_err_handler,
 };
 
 #if defined(CONFIG_PATA_MARVELL) || defined(CONFIG_PATA_MARVELL_MODULE)
@@ -813,6 +822,64 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 }
 #endif
 
+/**
+ * ahci_pci_error_detected - Called when a PCI error is detected.
+ * @pdev:	PCI device struct
+ * @state:	PCI channel state
+ *
+ * Description: Called when a PCI error is detected.
+ *
+ * Return value:
+ * PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT
+ */
+static pci_ers_result_t ahci_pci_error_detected(struct pci_dev *pdev,
+					       pci_channel_state_t state)
+{
+	struct ata_host *host = pci_get_drvdata(pdev);
+	int i;
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	for (i = 0; i < host->n_ports; i++)
+		scsi_block_requests(host->ports[i]->scsi_host);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+
+}
+
+/**
+ * ahci_pci_slot_reset - Called when PCI slot has been reset.
+ * @pdev:	PCI device struct
+ *
+ * Description: This routine is called by the pci error recovery
+ * code after the PCI slot has been reset, just before we
+ * should resume normal operations.
+ */
+static pci_ers_result_t ahci_pci_slot_reset(struct pci_dev *pdev)
+{
+	struct ata_host *host = pci_get_drvdata(pdev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	int i, rc;
+
+	pci_restore_state(pdev);
+
+	pci_save_state(pdev);
+
+	rc = ahci_pci_reset_controller(host);
+	if (rc)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	ahci_pci_init_controller(host);
+
+	for (i = 0; i < host->n_ports; i++)
+		scsi_unblock_requests(host->ports[i]->scsi_host);
+
+	wake_up_all(&hpriv->eeh_wait_q);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
 {
 	int rc;
@@ -1439,6 +1506,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
 
+	init_waitqueue_head(&hpriv->eeh_wait_q);
 	/* must set flag prior to save config in order to take effect */
 	if (ahci_broken_devslp(pdev))
 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
@@ -1549,6 +1617,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
+	pci_save_state(pdev);
+
 	return ahci_host_activate(host, pdev->irq, &ahci_sht);
 }
 
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 71262e0..6bbf747 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -51,6 +51,8 @@
 #define EM_MSG_LED_VALUE_OFF          0xfff80000
 #define EM_MSG_LED_VALUE_ON           0x00010000
 
+#define AHCI_PCI_ERROR_RECOVERY_TIMEOUT	(120 * HZ)
+
 enum {
 	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_CLKS		= 5,
@@ -341,6 +343,7 @@ struct ahci_host_priv {
 	struct phy		**phys;
 	unsigned		nports;		/* Number of ports */
 	void			*plat_data;	/* Other platform data */
+	wait_queue_head_t	eeh_wait_q;
 	/*
 	 * Optional ahci_start_engine override, if not set this gets set to the
 	 * default ahci_start_engine during ahci_save_initial_config, this can
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 287c4ba..bd7422a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -43,6 +43,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
+#include <linux/pci.h>
 #include "ahci.h"
 #include "libata.h"
 
@@ -1968,6 +1969,16 @@ static void ahci_thaw(struct ata_port *ap)
 void ahci_error_handler(struct ata_port *ap)
 {
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u32 irq_stat;
+
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+
+	if (pci_channel_offline(pdev))
+		wait_event_timeout(hpriv->eeh_wait_q,
+				!pci_channel_offline(pdev),
+				AHCI_PCI_ERROR_RECOVERY_TIMEOUT);
 
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
-- 
1.7.1

