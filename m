From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/4] pata_sl82c105: implement sff_irq_check() method
Date: Fri, 8 Oct 2010 19:02:13 +0400
Message-ID: <201010081902.13183.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:51795 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758289Ab0JHPCx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Oct 2010 11:02:53 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_sl82c105.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6/drivers/ata/pata_sl82c105.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sl82c105.c
+++ linux-2.6/drivers/ata/pata_sl82c105.c
@@ -227,6 +227,16 @@ static int sl82c105_qc_defer(struct ata_
 	return 0;
 }
 
+static bool sl82c105_sff_irq_check(struct ata_port *ap)
+{
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
+	u32 val, mask		= ap->port_no ? CTRL_IDE_IRQB : CTRL_IDE_IRQA;
+
+	pci_read_config_dword(pdev, 0x40, &val);
+
+	return val & mask;
+}
+
 static struct scsi_host_template sl82c105_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
@@ -239,6 +249,7 @@ static struct ata_port_operations sl82c1
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= sl82c105_set_piomode,
 	.prereset	= sl82c105_pre_reset,
+	.sff_irq_check	= sl82c105_sff_irq_check,
 };
 
 /**
