From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/4] pata_cmd640: implement sff_irq_check() method
Date: Fri, 8 Oct 2010 18:56:39 +0400
Message-ID: <201010081856.39644.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:49228 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757388Ab0JHO5X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Oct 2010 10:57:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_cmd640.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/drivers/ata/pata_cmd640.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_cmd640.c
+++ linux-2.6/drivers/ata/pata_cmd640.c
@@ -161,6 +161,17 @@ static int cmd640_port_start(struct ata_
 	return 0;
 }
 
+static bool cmd640_sff_irq_check(struct ata_port *ap)
+{
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
+	int irq_reg		= ap->port_no ? ARTIM23 : CFR;
+	u8  irq_stat, irq_mask	= ap->port_no ? 0x10 : 0x04;
+
+	pci_read_config_byte(pdev, irq_reg, &irq_stat);
+
+	return irq_stat & irq_mask;
+}
+
 static struct scsi_host_template cmd640_sht = {
 	ATA_PIO_SHT(DRV_NAME),
 };
@@ -169,6 +180,7 @@ static struct ata_port_operations cmd640
 	.inherits	= &ata_sff_port_ops,
 	/* In theory xfer_noirq is not needed once we kill the prefetcher */
 	.sff_data_xfer	= ata_sff_data_xfer_noirq,
+	.sff_irq_check	= cmd640_sff_irq_check,
 	.qc_issue	= cmd640_qc_issue,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= cmd640_set_piomode,
