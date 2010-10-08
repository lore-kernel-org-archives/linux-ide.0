From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/4] pata_sil680: implement sff_irq_check() method
Date: Fri, 8 Oct 2010 19:01:08 +0400
Message-ID: <201010081901.08447.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:51792 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758576Ab0JHPBs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Oct 2010 11:01:48 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_sil680.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/drivers/ata/pata_sil680.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sil680.c
+++ linux-2.6/drivers/ata/pata_sil680.c
@@ -210,6 +210,17 @@ static void sil680_sff_exec_command(stru
 	ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 }
 
+static bool sil680_sff_irq_check(struct ata_port *ap)
+{
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
+	unsigned long addr	= sil680_selreg(ap, 1);
+	u8 val;
+
+	pci_read_config_byte(pdev, addr, &val);
+
+	return val & 0x08;
+}
+
 static struct scsi_host_template sil680_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
@@ -218,6 +229,7 @@ static struct scsi_host_template sil680_
 static struct ata_port_operations sil680_port_ops = {
 	.inherits		= &ata_bmdma32_port_ops,
 	.sff_exec_command	= sil680_sff_exec_command,
+	.sff_irq_check		= sil680_sff_irq_check,
 	.cable_detect		= sil680_cable_detect,
 	.set_piomode		= sil680_set_piomode,
 	.set_dmamode		= sil680_set_dmamode,
