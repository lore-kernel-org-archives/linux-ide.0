From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ata_piix: ignore ATA_DMA_ERR on vmware ich4
Date: Mon, 07 Jan 2008 19:38:53 +0900
Message-ID: <4782013D.7010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:45631 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbYAGKi7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 05:38:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so12440282wah.23
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 02:38:58 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

VMware ich4 emulation incorrectly sets DMA_ERR on TF error.  Ignore
it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index bb62a58..b406b39 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -132,6 +132,7 @@ enum {
 	ich8_2port_sata,
 	ich8m_apple_sata_ahci,		/* locks up on second port enable */
 	tolapai_sata_ahci,
+	piix_pata_vmw,			/* PIIX4 for VMware, spurious DMA_ERR */
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -165,6 +166,7 @@ static void piix_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static void ich_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int ich_pata_cable_detect(struct ata_port *ap);
+static u8 piix_vmw_bmdma_status(struct ata_port *ap);
 #ifdef CONFIG_PM
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int piix_pci_device_resume(struct pci_dev *pdev);
@@ -175,6 +177,8 @@ static unsigned int in_module_init = 1;
 static const struct pci_device_id piix_pci_tbl[] = {
 	/* Intel PIIX3 for the 430HX etc */
 	{ 0x8086, 0x7010, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_mwdma },
+	/* VMware ICH4 */
+	{ 0x8086, 0x7111, 0x15ad, 0x1976, 0, 0, piix_pata_vmw },
 	/* Intel PIIX4 for the 430TX/440BX/MX chipset: UDMA 33 */
 	/* Also PIIX4E (fn3 rev 2) and PIIX4M (fn3 rev 3) */
 	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
@@ -383,6 +387,38 @@ static const struct ata_port_operations piix_sata_ops = {
 	.port_start		= ata_port_start,
 };
 
+static const struct ata_port_operations piix_vmw_ops = {
+	.set_piomode		= piix_set_piomode,
+	.set_dmamode		= piix_set_dmamode,
+	.mode_filter		= ata_pci_default_filter,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= piix_vmw_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_data_xfer,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= piix_pata_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_40wire,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+
+	.port_start		= ata_port_start,
+};
+
 static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
 	.port_enable = 0x3,
@@ -623,6 +659,16 @@ static struct ata_port_info piix_port_info[] = {
 		.port_ops	= &piix_sata_ops,
 	},
 
+	[piix_pata_vmw] =
+	{
+		.sht		= &piix_sht,
+		.flags		= PIIX_PATA_FLAGS,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x06, /* mwdma1-2 ?? CHECK 0 should be ok but slow */
+		.udma_mask	= ATA_UDMA_MASK_40C,
+		.port_ops	= &piix_vmw_ops,
+	},
+
 };
 
 static struct pci_bits piix_enable_bits[] = {
@@ -1135,6 +1181,11 @@ static int piix_pci_device_resume(struct pci_dev *pdev)
 }
 #endif
 
+static u8 piix_vmw_bmdma_status(struct ata_port *ap)
+{
+	return ata_bmdma_status(ap) & ~ATA_DMA_ERR;
+}
+
 #define AHCI_PCI_BAR 5
 #define AHCI_GLOBAL_CTL 0x04
 #define AHCI_ENABLE (1 << 31)
