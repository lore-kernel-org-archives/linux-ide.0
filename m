From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] ata_piix: implement SIDPR SCR access
Date: Fri, 18 Jan 2008 18:36:30 +0900
Message-ID: <12006489902825-git-send-email-htejun@gmail.com>
References: <12006489901911-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:35641 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbYARJgm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 04:36:42 -0500
Received: by rv-out-0910.google.com with SMTP id k20so835838rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 01:36:36 -0800 (PST)
In-Reply-To: <12006489901911-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

For ICH8, SCRs can be accessed using index and data register pair
located at BAR 5.  This patch implements support for it such that PHY
status, errors and hardreset are available for those controllers.

This is the only case where two devices on a PATA channel have access
to SCRs and creates a unique problem of mapping two SCRs to one link.
Note that this is different from PMP case in that they aren't quite
separate links - e.g. softreset resets both devices.

This problem is worked around by merging the SCR values.  To upper
layer, it looks like there is a single link with one set of SCRs but
with two devices.  This works well enough for PHY event, error
reporting and hardreset.

Supporting hardreset is important because in rare cases SATA devices
fail to recover without it after PHY errors.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |  251 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 247 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 58b9c89..a9987ec 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -101,9 +101,14 @@ enum {
 	ICH5_PMR		= 0x90, /* port mapping register */
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
+	PIIX_SIDPR_BAR		= 5,
+	PIIX_SIDPR_LEN		= 16,
+	PIIX_SIDPR_IDX		= 0,
+	PIIX_SIDPR_DATA		= 4,
 
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
+	PIIX_FLAG_SIDPR		= (1 << 29), /* SATA idx/data pair regs */
 
 	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
 	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
@@ -152,6 +157,7 @@ struct piix_map_db {
 
 struct piix_host_priv {
 	const int *map;
+	void __iomem *sidpr;
 };
 
 static int piix_init_one(struct pci_dev *pdev,
@@ -162,6 +168,9 @@ static void piix_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static void ich_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int ich_pata_cable_detect(struct ata_port *ap);
 static u8 piix_vmw_bmdma_status(struct ata_port *ap);
+static int piix_sidpr_scr_read(struct ata_port *ap, unsigned int reg, u32 *val);
+static int piix_sidpr_scr_write(struct ata_port *ap, unsigned int reg, u32 val);
+static void piix_sidpr_error_handler(struct ata_port *ap);
 #ifdef CONFIG_PM
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int piix_pci_device_resume(struct pci_dev *pdev);
@@ -411,6 +420,35 @@ static const struct ata_port_operations piix_vmw_ops = {
 	.port_start		= ata_port_start,
 };
 
+static const struct ata_port_operations piix_sidpr_sata_ops = {
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_data_xfer,
+
+	.scr_read		= piix_sidpr_scr_read,
+	.scr_write		= piix_sidpr_scr_write,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= piix_sidpr_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+
+	.port_start		= ata_port_start,
+};
+
 static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
 	.port_enable = 0x3,
@@ -598,7 +636,8 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich8_sata_ahci] =
 	{
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI |
+				  PIIX_FLAG_SIDPR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -607,7 +646,8 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich8_2port_sata] =
 	{
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI |
+				  PIIX_FLAG_SIDPR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -625,7 +665,8 @@ static struct ata_port_info piix_port_info[] = {
 
 	[ich8m_apple_sata_ahci] =
 	{
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI,
+		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_AHCI |
+				  PIIX_FLAG_SIDPR,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6,
@@ -974,6 +1015,180 @@ static void ich_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	do_pata_set_dmamode(ap, adev, 1);
 }
 
+/*
+ * Serial ATA Index/Data Pair Superset Registers access
+ *
+ * Beginning from ICH8, there's a sane way to access SCRs using index
+ * and data register pair located at BAR5.  This creates an
+ * interesting problem of mapping two SCRs to one port.
+ *
+ * Although they have separate SCRs, the master and slave aren't
+ * independent enough to be treated as separate links - e.g. softreset
+ * resets both.  Also, there's no protocol defined for hard resetting
+ * singled device sharing the virtual port (no defined way to acquire
+ * device signature).  This is worked around by merging the SCR values
+ * into one sensible value and requesting follow-up SRST after
+ * hardreset.
+ *
+ * SCR merging is perfomed in nibbles which is the unit contents in
+ * SCRs are organized.  If two values are equal, the value is used.
+ * When they differ, merge table which lists precedence of possible
+ * values is consulted and the first match or the last entry when
+ * nothing matches is used.  When there's no merge table for the
+ * specific nibble, value from the first port is used.
+ */
+static const int piix_sidx_map[] = {
+	[SCR_STATUS]	= 0,
+	[SCR_ERROR]	= 2,
+	[SCR_CONTROL]	= 1,
+};
+
+static void piix_sidpr_sel(struct ata_device *dev, unsigned int reg)
+{
+	struct ata_port *ap = dev->link->ap;
+	struct piix_host_priv *hpriv = ap->host->private_data;
+
+	iowrite32(((ap->port_no * 2 + dev->devno) << 8) | piix_sidx_map[reg],
+		  hpriv->sidpr + PIIX_SIDPR_IDX);
+}
+
+static int piix_sidpr_read(struct ata_device *dev, unsigned int reg)
+{
+	struct piix_host_priv *hpriv = dev->link->ap->host->private_data;
+
+	piix_sidpr_sel(dev, reg);
+	return ioread32(hpriv->sidpr + PIIX_SIDPR_DATA);
+}
+
+static void piix_sidpr_write(struct ata_device *dev, unsigned int reg, u32 val)
+{
+	struct piix_host_priv *hpriv = dev->link->ap->host->private_data;
+
+	piix_sidpr_sel(dev, reg);
+	iowrite32(val, hpriv->sidpr + PIIX_SIDPR_DATA);
+}
+
+u32 piix_merge_scr(u32 val0, u32 val1, const int * const *merge_tbl)
+{
+	u32 val = 0;
+	int i, mi;
+
+	for (i = 0, mi = 0; i < 32 / 4; i++) {
+		u8 c0 = (val0 >> (i * 4)) & 0xf;
+		u8 c1 = (val1 >> (i * 4)) & 0xf;
+		u8 merged = c0;
+		const int *cur;
+
+		/* if no merge preference, assume the first value */
+		cur = merge_tbl[mi];
+		if (!cur)
+			goto done;
+		mi++;
+
+		/* if two values equal, use it */
+		if (c0 == c1)
+			goto done;
+
+		/* choose the first match or the last from the merge table */
+		while (*cur != -1) {
+			if (c0 == *cur || c1 == *cur)
+				break;
+			cur++;
+		}
+		if (*cur == -1)
+			cur--;
+		merged = *cur;
+	done:
+		val |= merged << (i * 4);
+	}
+
+	return val;
+}
+
+static int piix_sidpr_scr_read(struct ata_port *ap, unsigned int reg, u32 *val)
+{
+	const int * const sstatus_merge_tbl[] = {
+		/* DET */ (const int []){ 1, 3, 0, 4, 3, -1 },
+		/* SPD */ (const int []){ 2, 1, 0, -1 },
+		/* IPM */ (const int []){ 6, 2, 1, 0, -1 },
+		NULL,
+	};
+	const int * const scontrol_merge_tbl[] = {
+		/* DET */ (const int []){ 1, 0, 4, 0, -1 },
+		/* SPD */ (const int []){ 0, 2, 1, 0, -1 },
+		/* IPM */ (const int []){ 0, 1, 2, 3, 0, -1 },
+		NULL,
+	};
+	u32 v0, v1;
+
+	if (reg >= ARRAY_SIZE(piix_sidx_map))
+		return -EINVAL;
+
+	if (!(ap->flags & ATA_FLAG_SLAVE_POSS)) {
+		*val = piix_sidpr_read(&ap->link.device[0], reg);
+		return 0;
+	}
+
+	v0 = piix_sidpr_read(&ap->link.device[0], reg);
+	v1 = piix_sidpr_read(&ap->link.device[1], reg);
+
+	switch (reg) {
+	case SCR_STATUS:
+		*val = piix_merge_scr(v0, v1, sstatus_merge_tbl);
+		break;
+	case SCR_ERROR:
+		*val = v0 | v1;
+		break;
+	case SCR_CONTROL:
+		*val = piix_merge_scr(v0, v1, scontrol_merge_tbl);
+		break;
+	}
+
+	return 0;
+}
+
+static int piix_sidpr_scr_write(struct ata_port *ap, unsigned int reg, u32 val)
+{
+	if (reg >= ARRAY_SIZE(piix_sidx_map))
+		return -EINVAL;
+
+	piix_sidpr_write(&ap->link.device[0], reg, val);
+
+	if (ap->flags & ATA_FLAG_SLAVE_POSS)
+		piix_sidpr_write(&ap->link.device[1], reg, val);
+
+	return 0;
+}
+
+static int piix_sidpr_hardreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline)
+{
+	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
+	int rc;
+
+	/* do hardreset */
+	rc = sata_link_hardreset(link, timing, deadline);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR,
+				"COMRESET failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (ata_link_offline(link)) {
+		*class = ATA_DEV_NONE;
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
+static void piix_sidpr_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
+			   piix_sidpr_hardreset, ata_std_postreset);
+}
+
 #ifdef CONFIG_PM
 static int piix_broken_suspend(void)
 {
@@ -1290,6 +1505,32 @@ static const int *__devinit piix_init_sata_map(struct pci_dev *pdev,
 	return map;
 }
 
+static void __devinit piix_init_sidpr(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	struct piix_host_priv *hpriv = host->private_data;
+	int i;
+
+	/* check for availability */
+	for (i = 0; i < 4; i++)
+		if (hpriv->map[i] == IDE)
+			return;
+
+	if (!(host->ports[0]->flags & PIIX_FLAG_SIDPR))
+		return;
+
+	if (pci_resource_start(pdev, PIIX_SIDPR_BAR) == 0 ||
+	    pci_resource_len(pdev, PIIX_SIDPR_BAR) != PIIX_SIDPR_LEN)
+		return;
+
+	if (pcim_iomap_regions(pdev, 1 << PIIX_SIDPR_BAR, DRV_NAME))
+		return;
+
+	hpriv->sidpr = pcim_iomap_table(pdev)[PIIX_SIDPR_BAR];
+	host->ports[0]->ops = &piix_sidpr_sata_ops;
+	host->ports[1]->ops = &piix_sidpr_sata_ops;
+}
+
 static void piix_iocfg_bit18_quirk(struct pci_dev *pdev)
 {
 	static const struct dmi_system_id sysids[] = {
@@ -1394,8 +1635,10 @@ static int piix_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	if (port_flags & ATA_FLAG_SATA)
+	if (port_flags & ATA_FLAG_SATA) {
 		piix_init_pcs(host, piix_map_db_table[ent->driver_data]);
+		piix_init_sidpr(host);
+	}
 
 	/* apply IOCFG bit18 quirk */
 	piix_iocfg_bit18_quirk(pdev);
-- 
1.5.2.4

