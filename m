From: Denis Turischev <denis@compulab.co.il>
Subject: pata_sch: fix PSTS register reading.
Date: Wed, 20 Jan 2010 13:45:22 +0200
Message-ID: <4B56ECD2.20107@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:47575 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760Ab0ATLoj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jan 2010 06:44:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org

pata_sch: fix PSTS register reading.

According to Poulsbo SCH datasheet (p. 353): "Reading reserved bits returns
an indeterminate, inconsistent value".
Bit 7 of PSTS register read as 1 when there is slave disk drive attached,
despite being described as reserved with zero value. This causes wrong 
feature
decoding in ata_sff_tf_read.

Fix it by implementing pata_sch specific sff_tf_read with appropriate bit
masks on PSTS register.

Signed-off-by: Denis Turischev <denis@compulab.co.il>
CC: stable@kernel.org

--- linux-2.6.33-rc4.orig/drivers/ata/pata_sch.c    2010-01-13 
07:15:00.000000000 +0200
+++ linux-2.6.33-rc4/drivers/ata/pata_sch.c    2010-01-20 
11:19:16.000000000 +0200
@@ -49,6 +49,11 @@
     USD    = (1 << 31),    /* Use Synchronous DMA */
 };
 
+/* see SCH datasheet page 353 */
+enum {
+    PSTSM    = 0x7f,        /* PSTS Bit Mask */
+};
+
 static int sch_init_one(struct pci_dev *pdev,
              const struct pci_device_id *ent);
 static void sch_set_piomode(struct ata_port *ap, struct ata_device *adev);
@@ -75,11 +80,47 @@
     ATA_BMDMA_SHT(DRV_NAME),
 };
 
+/**
+ *    sch_tf_read - input device's ATA taskfile shadow registers
+ *    @ap: Port from which input is read
+ *    @tf: ATA taskfile register set for storing input
+ *
+ *    Note: Original code is ata_sff_tf_read().
+ */
+
+static void sch_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+    struct ata_ioports *ioaddr = &ap->ioaddr;
+
+    tf->command = ata_sff_check_status(ap);
+    tf->feature = ioread8(ioaddr->error_addr) && PSTSM;
+    tf->nsect = ioread8(ioaddr->nsect_addr);
+    tf->lbal = ioread8(ioaddr->lbal_addr);
+    tf->lbam = ioread8(ioaddr->lbam_addr);
+    tf->lbah = ioread8(ioaddr->lbah_addr);
+    tf->device = ioread8(ioaddr->device_addr);
+
+    if (tf->flags & ATA_TFLAG_LBA48) {
+        if (likely(ioaddr->ctl_addr)) {
+            iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
+            tf->hob_feature = ioread8(ioaddr->error_addr) && PSTSM;
+            tf->hob_nsect = ioread8(ioaddr->nsect_addr);
+            tf->hob_lbal = ioread8(ioaddr->lbal_addr);
+            tf->hob_lbam = ioread8(ioaddr->lbam_addr);
+            tf->hob_lbah = ioread8(ioaddr->lbah_addr);
+            iowrite8(tf->ctl, ioaddr->ctl_addr);
+            ap->last_ctl = tf->ctl;
+        } else
+            WARN_ON_ONCE(1);
+    }
+}
+
 static struct ata_port_operations sch_pata_ops = {
     .inherits        = &ata_bmdma_port_ops,
     .cable_detect        = ata_cable_unknown,
     .set_piomode        = sch_set_piomode,
     .set_dmamode        = sch_set_dmamode,
+    .sff_tf_read        = sch_tf_read,
 };
 
 static struct ata_port_info sch_port_info = {
