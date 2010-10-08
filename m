From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/4] pata_pdc202xx_old: implement sff_irq_check() method
Date: Fri, 8 Oct 2010 18:57:45 +0400
Message-ID: <201010081857.45919.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:51785 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758566Ab0JHO6Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Oct 2010 10:58:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_pdc202xx_old.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Index: linux-2.6/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_pdc202xx_old.c
+++ linux-2.6/drivers/ata/pata_pdc202xx_old.c
@@ -44,6 +44,27 @@ static void pdc202xx_exec_command(struct
 	ndelay(400);
 }
 
+static bool pdc202xx_irq_check(struct ata_port *ap)
+{
+	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
+	unsigned long master	= pci_resource_start(pdev, 4);
+	u8 sc1d			= inb(master + 0x1d);
+
+	if (ap->port_no) {
+		/*
+		 * bit 7: error, bit 6: interrupting,
+		 * bit 5: FIFO full, bit 4: FIFO empty
+		 */
+		return sc1d & 0x40;
+	} else	{
+		/*
+		 * bit 3: error, bit 2: interrupting,
+		 * bit 1: FIFO full, bit 0: FIFO empty
+		 */
+		return sc1d & 0x04;
+	}
+}
+
 /**
  *	pdc202xx_configure_piomode	-	set chip PIO timing
  *	@ap: ATA interface
@@ -282,6 +303,7 @@ static struct ata_port_operations pdc202
 	.set_dmamode		= pdc202xx_set_dmamode,
 
 	.sff_exec_command	= pdc202xx_exec_command,
+	.sff_irq_check		= pdc202xx_irq_check,
 };
 
 static struct ata_port_operations pdc2026x_port_ops = {
@@ -297,6 +319,7 @@ static struct ata_port_operations pdc202
 	.port_start		= pdc2026x_port_start,
 
 	.sff_exec_command	= pdc202xx_exec_command,
+	.sff_irq_check		= pdc202xx_irq_check,
 };
 
 static int pdc202xx_init_one(struct pci_dev *dev, const struct pci_device_id *id)
