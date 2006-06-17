From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/6] sata_nv: better irq handlers
Date: Sat, 17 Jun 2006 15:49:56 +0900
Message-ID: <115052699637-git-send-email-htejun@gmail.com>
References: <11505269953650-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.206]:64100 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932443AbWFQGuB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 02:50:01 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1303343nze
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2006 23:50:00 -0700 (PDT)
In-Reply-To: <11505269953650-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

nf2/3 and ck804 have irq status register.  Implement better irq
handler for those flavors of nv.  This patch makes different flavors
of nv controllers use different irq handlers by using separate
port_info for each flavor.

This change also makes following EH and hotplug updates easier to
integrate.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |  211 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 194 insertions(+), 17 deletions(-)

7472c9c3ac075355e09ec44776040d633d7338df
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 1cb7b44..94cb179 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -78,8 +78,13 @@ enum {
 };
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static irqreturn_t nv_interrupt (int irq, void *dev_instance,
-				 struct pt_regs *regs);
+static void nv_ck804_host_stop(struct ata_host_set *host_set);
+static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance,
+					struct pt_regs *regs);
+static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance,
+				    struct pt_regs *regs);
+static irqreturn_t nv_ck804_interrupt(int irq, void *dev_instance,
+				      struct pt_regs *regs);
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
@@ -154,7 +159,7 @@ static struct scsi_host_template nv_sht 
 	.bios_param		= ata_std_bios_param,
 };
 
-static const struct ata_port_operations nv_ops = {
+static const struct ata_port_operations nv_generic_ops = {
 	.port_disable		= ata_port_disable,
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -170,7 +175,7 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.eng_timeout		= ata_eng_timeout,
 	.data_xfer		= ata_pio_data_xfer,
-	.irq_handler		= nv_interrupt,
+	.irq_handler		= nv_generic_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
@@ -179,6 +184,56 @@ static const struct ata_port_operations 
 	.host_stop		= ata_pci_host_stop,
 };
 
+static const struct ata_port_operations nv_nf2_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.exec_command		= ata_exec_command,
+	.check_status		= ata_check_status,
+	.dev_select		= ata_std_dev_select,
+	.phy_reset		= sata_phy_reset,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.eng_timeout		= ata_eng_timeout,
+	.data_xfer		= ata_pio_data_xfer,
+	.irq_handler		= nv_nf2_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+	.scr_read		= nv_scr_read,
+	.scr_write		= nv_scr_write,
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_pci_host_stop,
+};
+
+static const struct ata_port_operations nv_ck804_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.exec_command		= ata_exec_command,
+	.check_status		= ata_check_status,
+	.dev_select		= ata_std_dev_select,
+	.phy_reset		= sata_phy_reset,
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.eng_timeout		= ata_eng_timeout,
+	.data_xfer		= ata_pio_data_xfer,
+	.irq_handler		= nv_ck804_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+	.scr_read		= nv_scr_read,
+	.scr_write		= nv_scr_write,
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= nv_ck804_host_stop,
+};
+
 /* FIXME: The hardware provides the necessary SATA PHY controls
  * to support ATA_FLAG_SATA_RESET.  However, it is currently
  * necessary to disable that flag, to solve misdetection problems.
@@ -187,16 +242,43 @@ static const struct ata_port_operations 
  * This problem really needs to be investigated further.  But in the
  * meantime, we avoid ATA_FLAG_SATA_RESET to get people working.
  */
-static struct ata_port_info nv_port_info = {
-	.sht		= &nv_sht,
-	.host_flags	= ATA_FLAG_SATA |
-			  /* ATA_FLAG_SATA_RESET | */
-			  ATA_FLAG_SRST |
-			  ATA_FLAG_NO_LEGACY,
-	.pio_mask	= NV_PIO_MASK,
-	.mwdma_mask	= NV_MWDMA_MASK,
-	.udma_mask	= NV_UDMA_MASK,
-	.port_ops	= &nv_ops,
+static struct ata_port_info nv_port_info[] = {
+	/* generic */
+	{
+		.sht		= &nv_sht,
+		.host_flags	= ATA_FLAG_SATA |
+				  /* ATA_FLAG_SATA_RESET | */
+				  ATA_FLAG_SRST |
+				  ATA_FLAG_NO_LEGACY,
+		.pio_mask	= NV_PIO_MASK,
+		.mwdma_mask	= NV_MWDMA_MASK,
+		.udma_mask	= NV_UDMA_MASK,
+		.port_ops	= &nv_generic_ops,
+	},
+	/* nforce2/3 */
+	{
+		.sht		= &nv_sht,
+		.host_flags	= ATA_FLAG_SATA |
+				  /* ATA_FLAG_SATA_RESET | */
+				  ATA_FLAG_SRST |
+				  ATA_FLAG_NO_LEGACY,
+		.pio_mask	= NV_PIO_MASK,
+		.mwdma_mask	= NV_MWDMA_MASK,
+		.udma_mask	= NV_UDMA_MASK,
+		.port_ops	= &nv_nf2_ops,
+	},
+	/* ck804 */
+	{
+		.sht		= &nv_sht,
+		.host_flags	= ATA_FLAG_SATA |
+				  /* ATA_FLAG_SATA_RESET | */
+				  ATA_FLAG_SRST |
+				  ATA_FLAG_NO_LEGACY,
+		.pio_mask	= NV_PIO_MASK,
+		.mwdma_mask	= NV_MWDMA_MASK,
+		.udma_mask	= NV_UDMA_MASK,
+		.port_ops	= &nv_ck804_ops,
+	},
 };
 
 MODULE_AUTHOR("NVIDIA");
@@ -205,8 +287,8 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static irqreturn_t nv_interrupt (int irq, void *dev_instance,
-				 struct pt_regs *regs)
+static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance,
+					struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int i;
@@ -239,6 +321,79 @@ static irqreturn_t nv_interrupt (int irq
 	return IRQ_RETVAL(handled);
 }
 
+static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
+{
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
+	int handled;
+
+	/* bail out if not our interrupt */
+	if (!(irq_stat & NV_INT_DEV))
+		return 0;
+
+	/* DEV interrupt w/ no active qc? */
+	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
+		ata_check_status(ap);
+		return 1;
+	}
+
+	/* handle interrupt */
+	handled = ata_host_intr(ap, qc);
+	if (unlikely(!handled)) {
+		/* spurious, clear it */
+		ata_check_status(ap);
+	}
+
+	return 1;
+}
+
+static irqreturn_t nv_do_interrupt(struct ata_host_set *host_set, u8 irq_stat)
+{
+	int i, handled = 0;
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap = host_set->ports[i];
+
+		if (ap && !(ap->flags & ATA_FLAG_DISABLED))
+			handled += nv_host_intr(ap, irq_stat);
+
+		irq_stat >>= NV_INT_PORT_SHIFT;
+	}
+
+	return IRQ_RETVAL(handled);
+}
+
+static irqreturn_t nv_nf2_interrupt(int irq, void *dev_instance,
+				    struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	unsigned long flags;
+	u8 irq_stat;
+	irqreturn_t ret;
+
+	spin_lock_irqsave(&host_set->lock, flags);
+	irq_stat = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
+	ret = nv_do_interrupt(host_set, irq_stat);
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	return ret;
+}
+
+static irqreturn_t nv_ck804_interrupt(int irq, void *dev_instance,
+				      struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	unsigned long flags;
+	u8 irq_stat;
+	irqreturn_t ret;
+
+	spin_lock_irqsave(&host_set->lock, flags);
+	irq_stat = readb(host_set->mmio_base + NV_INT_STATUS_CK804);
+	ret = nv_do_interrupt(host_set, irq_stat);
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	return ret;
+}
+
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
@@ -294,7 +449,7 @@ static int nv_init_one (struct pci_dev *
 
 	rc = -ENOMEM;
 
-	ppi = &nv_port_info;
+	ppi = &nv_port_info[ent->driver_data];
 	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		goto err_out_regions;
@@ -310,6 +465,15 @@ static int nv_init_one (struct pci_dev *
 	probe_ent->port[0].scr_addr = base + NV_PORT0_SCR_REG_OFFSET;
 	probe_ent->port[1].scr_addr = base + NV_PORT1_SCR_REG_OFFSET;
 
+	/* enable SATA space for CK804 */
+	if (ent->driver_data == CK804) {
+		u8 regval;
+
+		pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
+		regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+		pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	}
+
 	pci_set_master(pdev);
 
 	rc = ata_device_add(probe_ent);
@@ -333,6 +497,19 @@ err_out:
 	return rc;
 }
 
+static void nv_ck804_host_stop(struct ata_host_set *host_set)
+{
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+	u8 regval;
+
+	/* disable SATA space for CK804 */
+	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
+	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+
+	ata_pci_host_stop(host_set);
+}
+
 static int __init nv_init(void)
 {
 	return pci_module_init(&nv_pci_driver);
-- 
1.3.2


