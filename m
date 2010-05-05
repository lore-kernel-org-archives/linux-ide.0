From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 3/3] libata: Make sil680 do its own exec_command posting
Date: Wed, 05 May 2010 10:25:58 +0100
Message-ID: <20100505092542.586.16410.stgit@localhost.localdomain>
References: <20100505092350.586.46344.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39740 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751342Ab0EEKE1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 06:04:27 -0400
In-Reply-To: <20100505092350.586.46344.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Use our own mmio area to avoid PCI posting. This avoids the rather slow
paranoid implementation in the default handler.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/pata_sil680.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)


diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index c6c589c..43faf10 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -190,15 +190,37 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	pci_write_config_word(pdev, ua, ultra);
 }
 
+/**
+ *	sil680_sff_exec_command - issue ATA command to host controller
+ *	@ap: port to which command is being issued
+ *	@tf: ATA taskfile register set
+ *
+ *	Issues ATA command, with proper synchronization with interrupt
+ *	handler / other threads. Use our MMIO space for PCI posting to avoid
+ *	a hideously slow cycle all the way to the device.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void sil680_sff_exec_command(struct ata_port *ap,
+					const struct ata_taskfile *tf)
+{
+	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
+	iowrite8(tf->command, ap->ioaddr.command_addr);
+	ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+}
+
 static struct scsi_host_template sil680_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
+
 static struct ata_port_operations sil680_port_ops = {
-	.inherits	= &ata_bmdma32_port_ops,
-	.cable_detect	= sil680_cable_detect,
-	.set_piomode	= sil680_set_piomode,
-	.set_dmamode	= sil680_set_dmamode,
+	.inherits		= &ata_bmdma32_port_ops,
+	.sff_exec_command	= sil680_sff_exec_command,
+	.cable_detect		= sil680_cable_detect,
+	.set_piomode		= sil680_set_piomode,
+	.set_dmamode		= sil680_set_dmamode,
 };
 
 /**

