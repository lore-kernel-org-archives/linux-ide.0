From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] sata_nv: kill not-working hotplug code
Date: Sat, 17 Jun 2006 15:49:55 +0900
Message-ID: <11505269952304-git-send-email-htejun@gmail.com>
References: <11505269953650-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.231]:14522 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932264AbWFQGuA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 02:50:00 -0400
Received: by wr-out-0506.google.com with SMTP id 50so491046wri
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2006 23:49:59 -0700 (PDT)
In-Reply-To: <11505269953650-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sata_nv contained hotplug code which is mainly for demonstrating how
hotplug event is handled.  This patch kills the demo code in
prepration for real hotplug implementation.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_nv.c |  169 ------------------------------------------------
 1 files changed, 0 insertions(+), 169 deletions(-)

bfecdd1697c29c0ca85c76a25e4666ec8a79e353
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 9055124..70f8194 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -64,12 +64,6 @@ enum {
 	NV_INT_STATUS_SDEV_PM		= 0x20,
 	NV_INT_STATUS_SDEV_ADDED	= 0x40,
 	NV_INT_STATUS_SDEV_REMOVED	= 0x80,
-	NV_INT_STATUS_PDEV_HOTPLUG	= (NV_INT_STATUS_PDEV_ADDED |
-					   NV_INT_STATUS_PDEV_REMOVED),
-	NV_INT_STATUS_SDEV_HOTPLUG	= (NV_INT_STATUS_SDEV_ADDED |
-					   NV_INT_STATUS_SDEV_REMOVED),
-	NV_INT_STATUS_HOTPLUG		= (NV_INT_STATUS_PDEV_HOTPLUG |
-					   NV_INT_STATUS_SDEV_HOTPLUG),
 
 	NV_INT_ENABLE			= 0x11,
 	NV_INT_ENABLE_CK804		= 0x441,
@@ -81,12 +75,6 @@ enum {
 	NV_INT_ENABLE_SDEV_PM		= 0x20,
 	NV_INT_ENABLE_SDEV_ADDED	= 0x40,
 	NV_INT_ENABLE_SDEV_REMOVED	= 0x80,
-	NV_INT_ENABLE_PDEV_HOTPLUG	= (NV_INT_ENABLE_PDEV_ADDED |
-					   NV_INT_ENABLE_PDEV_REMOVED),
-	NV_INT_ENABLE_SDEV_HOTPLUG	= (NV_INT_ENABLE_SDEV_ADDED |
-					   NV_INT_ENABLE_SDEV_REMOVED),
-	NV_INT_ENABLE_HOTPLUG		= (NV_INT_ENABLE_PDEV_HOTPLUG |
-					   NV_INT_ENABLE_SDEV_HOTPLUG),
 
 	NV_INT_CONFIG			= 0x12,
 	NV_INT_CONFIG_METHD		= 0x01, // 0 = INT, 1 = SMI
@@ -102,12 +90,6 @@ static irqreturn_t nv_interrupt (int irq
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void nv_host_stop (struct ata_host_set *host_set);
-static void nv_enable_hotplug(struct ata_probe_ent *probe_ent);
-static void nv_disable_hotplug(struct ata_host_set *host_set);
-static int nv_check_hotplug(struct ata_host_set *host_set);
-static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent);
-static void nv_disable_hotplug_ck804(struct ata_host_set *host_set);
-static int nv_check_hotplug_ck804(struct ata_host_set *host_set);
 
 enum nv_host_type
 {
@@ -158,34 +140,18 @@ static const struct pci_device_id nv_pci
 struct nv_host_desc
 {
 	enum nv_host_type	host_type;
-	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
-	void			(*disable_hotplug)(struct ata_host_set *host_set);
-	int			(*check_hotplug)(struct ata_host_set *host_set);
-
 };
 static struct nv_host_desc nv_device_tbl[] = {
 	{
 		.host_type	= GENERIC,
-		.enable_hotplug	= NULL,
-		.disable_hotplug= NULL,
-		.check_hotplug	= NULL,
 	},
 	{
 		.host_type	= NFORCE2,
-		.enable_hotplug	= nv_enable_hotplug,
-		.disable_hotplug= nv_disable_hotplug,
-		.check_hotplug	= nv_check_hotplug,
 	},
 	{
 		.host_type	= NFORCE3,
-		.enable_hotplug	= nv_enable_hotplug,
-		.disable_hotplug= nv_disable_hotplug,
-		.check_hotplug	= nv_check_hotplug,
 	},
 	{	.host_type	= CK804,
-		.enable_hotplug	= nv_enable_hotplug_ck804,
-		.disable_hotplug= nv_disable_hotplug_ck804,
-		.check_hotplug	= nv_check_hotplug_ck804,
 	},
 };
 
@@ -275,7 +241,6 @@ static irqreturn_t nv_interrupt (int irq
 				 struct pt_regs *regs)
 {
 	struct ata_host_set *host_set = dev_instance;
-	struct nv_host *host = host_set->private_data;
 	unsigned int i;
 	unsigned int handled = 0;
 	unsigned long flags;
@@ -301,9 +266,6 @@ static irqreturn_t nv_interrupt (int irq
 
 	}
 
-	if (host->host_desc->check_hotplug)
-		handled += host->host_desc->check_hotplug(host_set);
-
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
 	return IRQ_RETVAL(handled);
@@ -329,10 +291,6 @@ static void nv_host_stop (struct ata_hos
 {
 	struct nv_host *host = host_set->private_data;
 
-	// Disable hotplug event interrupts.
-	if (host->host_desc->disable_hotplug)
-		host->host_desc->disable_hotplug(host_set);
-
 	kfree(host);
 
 	ata_pci_host_stop(host_set);
@@ -409,10 +367,6 @@ static int nv_init_one (struct pci_dev *
 	if (rc != NV_PORTS)
 		goto err_out_iounmap;
 
-	// Enable hotplug event interrupts.
-	if (host->host_desc->enable_hotplug)
-		host->host_desc->enable_hotplug(probe_ent);
-
 	kfree(probe_ent);
 
 	return 0;
@@ -432,129 +386,6 @@ err_out:
 	return rc;
 }
 
-static void nv_enable_hotplug(struct ata_probe_ent *probe_ent)
-{
-	u8 intr_mask;
-
-	outb(NV_INT_STATUS_HOTPLUG,
-		probe_ent->port[0].scr_addr + NV_INT_STATUS);
-
-	intr_mask = inb(probe_ent->port[0].scr_addr + NV_INT_ENABLE);
-	intr_mask |= NV_INT_ENABLE_HOTPLUG;
-
-	outb(intr_mask, probe_ent->port[0].scr_addr + NV_INT_ENABLE);
-}
-
-static void nv_disable_hotplug(struct ata_host_set *host_set)
-{
-	u8 intr_mask;
-
-	intr_mask = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
-
-	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
-
-	outb(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
-}
-
-static int nv_check_hotplug(struct ata_host_set *host_set)
-{
-	u8 intr_status;
-
-	intr_status = inb(host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
-
-	// Clear interrupt status.
-	outb(0xff, host_set->ports[0]->ioaddr.scr_addr + NV_INT_STATUS);
-
-	if (intr_status & NV_INT_STATUS_HOTPLUG) {
-		if (intr_status & NV_INT_STATUS_PDEV_ADDED)
-			printk(KERN_WARNING "nv_sata: "
-				"Primary device added\n");
-
-		if (intr_status & NV_INT_STATUS_PDEV_REMOVED)
-			printk(KERN_WARNING "nv_sata: "
-				"Primary device removed\n");
-
-		if (intr_status & NV_INT_STATUS_SDEV_ADDED)
-			printk(KERN_WARNING "nv_sata: "
-				"Secondary device added\n");
-
-		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
-			printk(KERN_WARNING "nv_sata: "
-				"Secondary device removed\n");
-
-		return 1;
-	}
-
-	return 0;
-}
-
-static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent)
-{
-	struct pci_dev *pdev = to_pci_dev(probe_ent->dev);
-	u8 intr_mask;
-	u8 regval;
-
-	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
-	regval |= NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
-
-	writeb(NV_INT_STATUS_HOTPLUG, probe_ent->mmio_base + NV_INT_STATUS_CK804);
-
-	intr_mask = readb(probe_ent->mmio_base + NV_INT_ENABLE_CK804);
-	intr_mask |= NV_INT_ENABLE_HOTPLUG;
-
-	writeb(intr_mask, probe_ent->mmio_base + NV_INT_ENABLE_CK804);
-}
-
-static void nv_disable_hotplug_ck804(struct ata_host_set *host_set)
-{
-	struct pci_dev *pdev = to_pci_dev(host_set->dev);
-	u8 intr_mask;
-	u8 regval;
-
-	intr_mask = readb(host_set->mmio_base + NV_INT_ENABLE_CK804);
-
-	intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
-
-	writeb(intr_mask, host_set->mmio_base + NV_INT_ENABLE_CK804);
-
-	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
-	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
-	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
-}
-
-static int nv_check_hotplug_ck804(struct ata_host_set *host_set)
-{
-	u8 intr_status;
-
-	intr_status = readb(host_set->mmio_base + NV_INT_STATUS_CK804);
-
-	// Clear interrupt status.
-	writeb(0xff, host_set->mmio_base + NV_INT_STATUS_CK804);
-
-	if (intr_status & NV_INT_STATUS_HOTPLUG) {
-		if (intr_status & NV_INT_STATUS_PDEV_ADDED)
-			printk(KERN_WARNING "nv_sata: "
-				"Primary device added\n");
-
-		if (intr_status & NV_INT_STATUS_PDEV_REMOVED)
-			printk(KERN_WARNING "nv_sata: "
-				"Primary device removed\n");
-
-		if (intr_status & NV_INT_STATUS_SDEV_ADDED)
-			printk(KERN_WARNING "nv_sata: "
-				"Secondary device added\n");
-
-		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
-			printk(KERN_WARNING "nv_sata: "
-				"Secondary device removed\n");
-
-		return 1;
-	}
-
-	return 0;
-}
-
 static int __init nv_init(void)
 {
 	return pci_module_init(&nv_pci_driver);
-- 
1.3.2


