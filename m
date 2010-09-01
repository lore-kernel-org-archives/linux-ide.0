From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] ata_piix: implement LPM support
Date: Wed,  1 Sep 2010 17:50:08 +0200
Message-ID: <1283356208-1884-6-git-send-email-tj@kernel.org>
References: <1283356208-1884-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35961 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755895Ab0IAPud (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Sep 2010 11:50:33 -0400
In-Reply-To: <1283356208-1884-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Now that DIPM can be used independently from HIPM, ata_piix can
support LPM too.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ata_piix.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 3971bc0..8f333f2 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -175,6 +175,8 @@ static int piix_sidpr_scr_read(struct ata_link *link,
 			       unsigned int reg, u32 *val);
 static int piix_sidpr_scr_write(struct ata_link *link,
 				unsigned int reg, u32 val);
+static int piix_sidpr_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+			      unsigned hints);
 static bool piix_irq_check(struct ata_port *ap);
 #ifdef CONFIG_PM
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
@@ -344,11 +346,22 @@ static struct ata_port_operations ich_pata_ops = {
 	.set_dmamode		= ich_set_dmamode,
 };
 
+static struct device_attribute *piix_sidpr_shost_attrs[] = {
+	&dev_attr_link_power_management_policy,
+	NULL
+};
+
+static struct scsi_host_template piix_sidpr_sht = {
+	ATA_BMDMA_SHT(DRV_NAME),
+	.shost_attrs		= piix_sidpr_shost_attrs,
+};
+
 static struct ata_port_operations piix_sidpr_sata_ops = {
 	.inherits		= &piix_sata_ops,
 	.hardreset		= sata_std_hardreset,
 	.scr_read		= piix_sidpr_scr_read,
 	.scr_write		= piix_sidpr_scr_write,
+	.set_lpm		= piix_sidpr_set_lpm,
 };
 
 static const struct piix_map_db ich5_map_db = {
@@ -980,6 +993,12 @@ static int piix_sidpr_scr_write(struct ata_link *link,
 	return 0;
 }
 
+static int piix_sidpr_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
+			      unsigned hints)
+{
+	return sata_link_scr_lpm(link, policy, false);
+}
+
 static bool piix_irq_check(struct ata_port *ap)
 {
 	if (unlikely(!ap->ioaddr.bmdma_addr))
@@ -1539,6 +1558,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	struct device *dev = &pdev->dev;
 	struct ata_port_info port_info[2];
 	const struct ata_port_info *ppi[] = { &port_info[0], &port_info[1] };
+	struct scsi_host_template *sht = &piix_sht;
 	unsigned long port_flags;
 	struct ata_host *host;
 	struct piix_host_priv *hpriv;
@@ -1608,6 +1628,8 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 		rc = piix_init_sidpr(host);
 		if (rc)
 			return rc;
+		if (host->ports[0]->ops == &piix_sidpr_sata_ops)
+			sht = &piix_sidpr_sht;
 	}
 
 	/* apply IOCFG bit18 quirk */
@@ -1634,7 +1656,7 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	host->flags |= ATA_HOST_PARALLEL_SCAN;
 
 	pci_set_master(pdev);
-	return ata_pci_sff_activate_host(host, ata_bmdma_interrupt, &piix_sht);
+	return ata_pci_sff_activate_host(host, ata_bmdma_interrupt, sht);
 }
 
 static void piix_remove_one(struct pci_dev *pdev)
-- 
1.7.1

