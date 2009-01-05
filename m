From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/7] pata_hpt3x3: Workarounds for chipset
Date: Mon, 05 Jan 2009 14:12:51 +0000
Message-ID: <20090105141220.28189.53195.stgit@localhost.localdomain>
References: <20090105141102.28189.44312.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56418 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754083AbZAEOMh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 09:12:37 -0500
In-Reply-To: <20090105141102.28189.44312.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Correct the DMA bit flags (UDMA and MWDMA were swapped)
Add workarounds so that we clear ERR and INTR bits before issuing a DMA
Add workarounds so that we stop a live DMA before touching the CTL register

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/pata_hpt3x3.c |   51 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 45 insertions(+), 6 deletions(-)


diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index f11a320..1c9016e 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -23,7 +23,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x3"
-#define DRV_VERSION	"0.5.3"
+#define DRV_VERSION	"0.6.1"
 
 /**
  *	hpt3x3_set_piomode		-	PIO setup
@@ -80,14 +80,48 @@ static void hpt3x3_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	r2 &= ~(0x11 << dn);	/* Clear MWDMA and UDMA bits */
 
 	if (adev->dma_mode >= XFER_UDMA_0)
-		r2 |= (0x10 << dn);	/* Ultra mode */
+		r2 |= (0x01 << dn);	/* Ultra mode */
 	else
-		r2 |= (0x01 << dn);	/* MWDMA */
+		r2 |= (0x10 << dn);	/* MWDMA */
 
 	pci_write_config_dword(pdev, 0x44, r1);
 	pci_write_config_dword(pdev, 0x48, r2);
 }
-#endif /* CONFIG_PATA_HPT3X3_DMA */
+
+/**
+ *	hpt3x3_freeze		-	DMA workaround
+ *	@ap: port to freeze
+ *
+ *	When freezing an HPT3x3 we must stop any pending DMA before
+ *	writing to the control register or the chip will hang
+ */
+
+static int hpt3x3_freeze(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->ioaddr.bmdma_addr;
+
+	iowrite8(ioread8(mmio + ATA_DMA_CMD) & ~ ATA_DMA_START,
+			mmio + ATA_DMA_CMD);
+	ata_sff_dma_pause(ap);
+	ata_sff_freeze(ap);
+}
+
+/**
+ *	hpt3x3_bmdma_setup	-	DMA workaround
+ *	@qc: Queued command
+ *
+ *	When issuing BMDMA we must clean up the error/active bits in
+ *	software on this device
+ */
+
+static void hpt3x3_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 r = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	r |= ATA_DMA_INTR | ATA_DMA_ERR;
+	iowrite8(r, ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	return ata_bmdma_setup(qc);
+}
 
 /**
  *	hpt3x3_atapi_dma	-	ATAPI DMA check
@@ -101,18 +135,23 @@ static int hpt3x3_atapi_dma(struct ata_queued_cmd *qc)
 	return 1;
 }
 
+#endif /* CONFIG_PATA_HPT3X3_DMA */
+
 static struct scsi_host_template hpt3x3_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
 static struct ata_port_operations hpt3x3_port_ops = {
 	.inherits	= &ata_bmdma_port_ops,
-	.check_atapi_dma= hpt3x3_atapi_dma,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= hpt3x3_set_piomode,
 #if defined(CONFIG_PATA_HPT3X3_DMA)
 	.set_dmamode	= hpt3x3_set_dmamode,
+	.bmdma_setup	= hpt3x3_bmdma_setup,
+	.check_atapi_dma= hpt3x3_atapi_dma,
+	.freeze		= hpt3x3_freeze,
 #endif
+	
 };
 
 /**
@@ -257,4 +296,4 @@ MODULE_DEVICE_TABLE(pci, hpt3x3);
 MODULE_VERSION(DRV_VERSION);
 
 module_init(hpt3x3_init);
-module_exit(hpt3x3_exit);
+module_exit(hpt3x3_exit);
\ No newline at end of file

