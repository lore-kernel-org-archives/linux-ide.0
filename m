From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/7] pata_ali: Fix and workaround for FIFO DMA bug
Date: Mon, 05 Jan 2009 14:13:53 +0000
Message-ID: <20090105141327.28189.88640.stgit@localhost.localdomain>
References: <20090105141102.28189.44312.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56424 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754327AbZAEONj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 09:13:39 -0500
In-Reply-To: <20090105141102.28189.44312.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

From: Alan Cox <alan@redhat.com>

In very obscure cases this can cause problems. We need to help the hardware
out a bit to avoid DMA problems on a reset.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/pata_ali.c |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)


diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index d2ea2db..a4f9e39 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -35,7 +35,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.7.7"
+#define DRV_VERSION "0.7.8"
 
 static int ali_atapi_dma = 0;
 module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
@@ -341,6 +341,23 @@ static int ali_check_atapi_dma(struct ata_queued_cmd *qc)
 	return 0;
 }
 
+static void ali_c2_c3_postreset(struct ata_link *link, unsigned int *classes)
+{
+	u8 r;
+	int port_bit = 4 << link->ap->port_no;
+
+	/* If our bridge is an ALI 1533 then do the extra work */
+	if (isa_bridge) {
+		/* Tristate and re-enable the bus signals */
+		pci_read_config_byte(isa_bridge, 0x58, &r);
+		r &= ~port_bit;
+		pci_write_config_byte(isa_bridge, 0x58, r);
+		r |= port_bit;
+		pci_write_config_byte(isa_bridge, 0x58, r);
+	}
+	ata_sff_postreset(link, classes);
+}
+
 static struct scsi_host_template ali_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
 };
@@ -381,6 +398,17 @@ static struct ata_port_operations ali_c2_port_ops = {
 	.check_atapi_dma = ali_check_atapi_dma,
 	.cable_detect	= ali_c2_cable_detect,
 	.dev_config	= ali_lock_sectors,
+	.postreset	= ali_c2_c3_postreset,
+};
+
+/*
+ *	Port operations for DMA capable ALi with cable detect
+ */
+static struct ata_port_operations ali_c4_port_ops = {
+	.inherits	= &ali_dma_base_ops,
+	.check_atapi_dma = ali_check_atapi_dma,
+	.cable_detect	= ali_c2_cable_detect,
+	.dev_config	= ali_lock_sectors,
 };
 
 /*
@@ -504,7 +532,7 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = ATA_UDMA5,
-		.port_ops = &ali_c2_port_ops
+		.port_ops = &ali_c4_port_ops
 	};
 	/* Revision 0xC5 is UDMA133 with LBA48 DMA */
 	static const struct ata_port_info info_c5 = {

