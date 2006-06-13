From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/7] sata_nv: implement irq manipulation methods
Date: Wed, 14 Jun 2006 06:31:04 +0900
Message-ID: <11502342644086-git-send-email-htejun@gmail.com>
References: <11502342632913-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:15545 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932284AbWFMVa4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 17:30:56 -0400
Received: by py-out-1112.google.com with SMTP id i49so160763pye
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 14:30:55 -0700 (PDT)
In-Reply-To: <11502342632913-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add four irq manipulation callbacks to nv_host_desc and implement
those methods for nf2/3 and ck804.  These methods will be used by new
irq_handler, EH and hotplug support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

d47f98a5ada7fb993f659f4ba1eb496457122455
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index f370044..93e74aa 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -77,6 +77,16 @@ enum {
 	NV_MCP_SATA_CFG_20_SATA_SPACE_EN = 0x04,
 };
 
+static u8 nf2_get_irq_mask(struct ata_host_set *host_set);
+static void nf2_set_irq_mask(struct ata_host_set *host_set, u8 mask);
+static u8 nf2_get_irq_status(struct ata_host_set *host_set);
+static void nf2_clr_irq_status(struct ata_host_set *host_set);
+
+static u8 ck804_get_irq_mask(struct ata_host_set *host_set);
+static void ck804_set_irq_mask(struct ata_host_set *host_set, u8 mask);
+static u8 ck804_get_irq_status(struct ata_host_set *host_set);
+static void ck804_clr_irq_status(struct ata_host_set *host_set);
+
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
 				 struct pt_regs *regs);
@@ -133,6 +143,10 @@ static const struct pci_device_id nv_pci
 struct nv_host_desc
 {
 	enum nv_host_type	host_type;
+	u8   (*get_irq_mask) (struct ata_host_set *host_set);
+	void (*set_irq_mask) (struct ata_host_set *host_set, u8 mask);
+	u8   (*get_irq_status) (struct ata_host_set *host_set);
+	void (*clr_irq_status) (struct ata_host_set *host_set);
 };
 static struct nv_host_desc nv_device_tbl[] = {
 	{
@@ -140,12 +154,24 @@ static struct nv_host_desc nv_device_tbl
 	},
 	{
 		.host_type	= NFORCE2,
+		.get_irq_mask	= nf2_get_irq_mask,
+		.set_irq_mask	= nf2_set_irq_mask,
+		.get_irq_status	= nf2_get_irq_status,
+		.clr_irq_status	= nf2_clr_irq_status,
 	},
 	{
 		.host_type	= NFORCE3,
+		.get_irq_mask	= nf2_get_irq_mask,
+		.set_irq_mask	= nf2_set_irq_mask,
+		.get_irq_status	= nf2_get_irq_status,
+		.clr_irq_status	= nf2_clr_irq_status,
 	},
 	{
 		.host_type	= CK804,
+		.get_irq_mask	= ck804_get_irq_mask,
+		.set_irq_mask	= ck804_set_irq_mask,
+		.get_irq_status	= ck804_get_irq_status,
+		.clr_irq_status	= ck804_clr_irq_status,
 	},
 };
 
@@ -225,6 +251,46 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static u8 nf2_get_irq_mask(struct ata_host_set *host_set)
+{
+	return inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
+}
+
+static void nf2_set_irq_mask(struct ata_host_set *host_set, u8 mask)
+{
+	outb(mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
+}
+
+static u8 nf2_get_irq_status(struct ata_host_set *host_set)
+{
+	return inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
+}
+
+static void nf2_clr_irq_status(struct ata_host_set *host_set)
+{
+	outb(0xff, host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
+}
+
+static u8 ck804_get_irq_mask(struct ata_host_set *host_set)
+{
+	return readb(host_set->mmio_base + NV_INT_ENABLE_CK804);
+}
+
+static void ck804_set_irq_mask(struct ata_host_set *host_set, u8 mask)
+{
+	writeb(mask, host_set->mmio_base + NV_INT_ENABLE_CK804);
+}
+
+static u8 ck804_get_irq_status(struct ata_host_set *host_set)
+{
+	return readb(host_set->mmio_base + NV_INT_STATUS_CK804);
+}
+
+static void ck804_clr_irq_status(struct ata_host_set *host_set)
+{
+	writeb(0xff, host_set->mmio_base + NV_INT_STATUS_CK804);
+}
+
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
 				 struct pt_regs *regs)
 {
@@ -277,6 +343,18 @@ static void nv_scr_write (struct ata_por
 
 static void nv_host_stop (struct ata_host_set *host_set)
 {
+	struct nv_host_desc *host_desc = host_set->private_data;
+
+	/* disable SATA space for CK804 */
+	if (host_desc->host_type == CK804) {
+		struct pci_dev *pdev = to_pci_dev(host_set->dev);
+		u8 regval;
+
+		pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
+		regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
+		pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
+	}
+
 	ata_pci_host_stop(host_set);
 }
 
@@ -337,6 +415,15 @@ static int nv_init_one (struct pci_dev *
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
-- 
1.3.2


