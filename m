From: Bart Hartgers <bart.hartgers@gmail.com>
Subject: [patch 1/1] Delay on vt6420 when starting ATAPI DMA write
Date: Sun, 14 Feb 2010 13:04:50 +0100
Message-ID: <20100214120819.947320201@gmail.com>
References: <20100214120449.503204189@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=sata_via/vt6420-atapi-dma.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Bart Hartgers <bart.hartgers@gmail.com>
List-Id: linux-ide@vger.kernel.org

When writing a disc on certain lite-on dvd-writers (also rebadged 
as optiarc/LG/...) connected to a vt6420, the ATAPI CDB ends
up in the datastream and on the disc, causing silent corruption. 
Delaying between sending the CDB and starting DMA seems to 
prevent this.

I do not know if there are burners that do not suffer from
this, but the patch should be safe for those as well.

There are many reports of this issue, but AFAICT no solution was 
found before. For example:
http://lkml.indiana.edu/hypermail/linux/kernel/0802.3/0561.html

Signed-off-by: Bart Hartgers <bart.hartgers@gmail.com>
---
Index: linux-2.6.33-rc4/drivers/ata/sata_via.c
===================================================================
--- linux-2.6.33-rc4.orig/drivers/ata/sata_via.c	2010-02-14 11:54:15.000000000 +0100
+++ linux-2.6.33-rc4/drivers/ata/sata_via.c	2010-02-14 11:55:42.000000000 +0100
@@ -40,11 +40,13 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_via"
-#define DRV_VERSION	"2.5"
+#define DRV_VERSION	"2.6"
 
 /*
  * vt8251 is different from other sata controllers of VIA.  It has two
@@ -80,6 +82,7 @@ static int vt8251_scr_write(struct ata_l
 static void svia_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 static void svia_noop_freeze(struct ata_port *ap);
 static int vt6420_prereset(struct ata_link *link, unsigned long deadline);
+static void vt6420_bmdma_start(struct ata_queued_cmd *qc);
 static int vt6421_pata_cable_detect(struct ata_port *ap);
 static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
 static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
@@ -121,6 +124,7 @@ static struct ata_port_operations vt6420
 	.inherits		= &svia_base_ops,
 	.freeze			= svia_noop_freeze,
 	.prereset		= vt6420_prereset,
+	.bmdma_start		= vt6420_bmdma_start,
 };
 
 static struct ata_port_operations vt6421_pata_ops = {
@@ -377,6 +381,17 @@ static int vt6420_prereset(struct ata_li
 	return 0;
 }
 
+static void vt6420_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	if ((qc->tf.command == ATA_CMD_PACKET) &&
+	    (qc->scsicmd->sc_data_direction == DMA_TO_DEVICE)) {
+		/* Prevents corruption on some ATAPI burners */
+		ata_sff_pause(ap);
+	}
+	ata_bmdma_start(qc);
+}
+
 static int vt6421_pata_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);

-- 
