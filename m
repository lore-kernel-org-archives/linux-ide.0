From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 7/7] libata: Add 32bit PIO support
Date: Mon, 05 Jan 2009 14:16:39 +0000
Message-ID: <20090105141619.28189.6174.stgit@localhost.localdomain>
References: <20090105141102.28189.44312.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46519 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754147AbZAEOQ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 09:16:26 -0500
In-Reply-To: <20090105141102.28189.44312.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

From: Alan Cox <alan@redhat.com>

This matters for some controllers and in one or two cases almost doubles
PIO performance. Add a bmdma32 operations set we can inherit and activate
it for some controllers

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/ata_piix.c    |    2 +-
 drivers/ata/libata-sff.c  |   53 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_ali.c    |    6 +++--
 drivers/ata/pata_amd.c    |    4 ++-
 drivers/ata/pata_mpiix.c  |    3 ++-
 drivers/ata/pata_sil680.c |    4 ++-
 include/linux/libata.h    |    3 +++
 7 files changed, 66 insertions(+), 9 deletions(-)


diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 5fdf167..d3f6c9d 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -308,7 +308,7 @@ static struct scsi_host_template piix_sht = {
 };
 
 static struct ata_port_operations piix_pata_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &ata_bmdma32_port_ops,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= piix_set_piomode,
 	.set_dmamode		= piix_set_dmamode,
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 61b1fb4..5c93377 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -83,6 +83,13 @@ const struct ata_port_operations ata_bmdma_port_ops = {
 };
 EXPORT_SYMBOL_GPL(ata_bmdma_port_ops);
 
+const struct ata_port_operations ata_bmdma32_port_ops = {
+	.inherits		= &ata_bmdma_port_ops,
+
+	.sff_data_xfer		= ata_sff_data_xfer32,
+};
+EXPORT_SYMBOL_GPL(ata_bmdma32_port_ops);
+
 /**
  *	ata_fill_sg - Fill PCI IDE PRD table
  *	@qc: Metadata associated with taskfile to be transferred
@@ -739,6 +746,52 @@ unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
 EXPORT_SYMBOL_GPL(ata_sff_data_xfer);
 
 /**
+ *	ata_sff_data_xfer32 - Transfer data by PIO
+ *	@dev: device to target
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@rw: read/write
+ *
+ *	Transfer data from/to the device data register by PIO using 32bit
+ *	I/O operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	Bytes consumed.
+ */
+
+unsigned int ata_sff_data_xfer32(struct ata_device *dev, unsigned char *buf,
+			       unsigned int buflen, int rw)
+{
+	struct ata_port *ap = dev->link->ap;
+	void __iomem *data_addr = ap->ioaddr.data_addr;
+	unsigned int words = buflen >> 2;
+	int slop = buflen & 3;
+
+	/* Transfer multiple of 4 bytes */
+	if (rw == READ)
+		ioread32_rep(data_addr, buf, words);
+	else
+		iowrite32_rep(data_addr, buf, words);
+
+	if (unlikely(slop)) {
+		__le32 pad;
+		if (rw == READ) {
+			pad = cpu_to_le32(ioread32(ap->ioaddr.data_addr));
+			memcpy(buf + buflen - slop, &pad, slop);
+		} else {
+			memcpy(&pad, buf + buflen - slop, slop);
+			iowrite32(le32_to_cpu(pad), ap->ioaddr.data_addr);
+		}
+		words++;
+	}
+	return words << 2;
+}
+EXPORT_SYMBOL_GPL(ata_sff_data_xfer32);
+
+/**
  *	ata_sff_data_xfer_noirq - Transfer data by PIO
  *	@dev: device to target
  *	@buf: data buffer
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index a4f9e39..a7999c1 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -151,8 +151,7 @@ static void ali_fifo_control(struct ata_port *ap, struct ata_device *adev, int o
 
 	pci_read_config_byte(pdev, pio_fifo, &fifo);
 	fifo &= ~(0x0F << shift);
-	if (on)
-		fifo |= (on << shift);
+	fifo |= (on << shift);
 	pci_write_config_byte(pdev, pio_fifo, fifo);
 }
 
@@ -370,10 +369,11 @@ static struct ata_port_operations ali_early_port_ops = {
 	.inherits	= &ata_sff_port_ops,
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= ali_set_piomode,
+	.sff_data_xfer  = ata_sff_data_xfer32,
 };
 
 static const struct ata_port_operations ali_dma_base_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 	.set_piomode	= ali_set_piomode,
 	.set_dmamode	= ali_set_dmamode,
 };
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 0ec9c7d..63719ab 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.3.10"
+#define DRV_VERSION "0.3.11"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -345,7 +345,7 @@ static struct scsi_host_template amd_sht = {
 };
 
 static const struct ata_port_operations amd_base_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 	.prereset	= amd_pre_reset,
 };
 
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 7c8faa4..aa576ca 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -35,7 +35,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_mpiix"
-#define DRV_VERSION "0.7.6"
+#define DRV_VERSION "0.7.7"
 
 enum {
 	IDETIM = 0x6C,		/* IDE control register */
@@ -146,6 +146,7 @@ static struct ata_port_operations mpiix_port_ops = {
 	.cable_detect	= ata_cable_40wire,
 	.set_piomode	= mpiix_set_piomode,
 	.prereset	= mpiix_pre_reset,
+	.sff_data_xfer	= ata_sff_data_xfer32,
 };
 
 static int mpiix_init_one(struct pci_dev *dev, const struct pci_device_id *id)
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 83580a5..9e764e5 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -32,7 +32,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sil680"
-#define DRV_VERSION "0.4.8"
+#define DRV_VERSION "0.4.9"
 
 #define SIL680_MMIO_BAR		5
 
@@ -195,7 +195,7 @@ static struct scsi_host_template sil680_sht = {
 };
 
 static struct ata_port_operations sil680_port_ops = {
-	.inherits	= &ata_bmdma_port_ops,
+	.inherits	= &ata_bmdma32_port_ops,
 	.cable_detect	= sil680_cable_detect,
 	.set_piomode	= sil680_set_piomode,
 	.set_dmamode	= sil680_set_dmamode,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bdc9696..b8c6788 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1521,6 +1521,7 @@ extern void sata_pmp_error_handler(struct ata_port *ap);
 
 extern const struct ata_port_operations ata_sff_port_ops;
 extern const struct ata_port_operations ata_bmdma_port_ops;
+extern const struct ata_port_operations ata_bmdma32_port_ops;
 
 /* PIO only, sg_tablesize and dma_boundary limits can be removed */
 #define ATA_PIO_SHT(drv_name)					\
@@ -1548,6 +1549,8 @@ extern void ata_sff_exec_command(struct ata_port *ap,
 				 const struct ata_taskfile *tf);
 extern unsigned int ata_sff_data_xfer(struct ata_device *dev,
 			unsigned char *buf, unsigned int buflen, int rw);
+extern unsigned int ata_sff_data_xfer32(struct ata_device *dev,
+			unsigned char *buf, unsigned int buflen, int rw);
 extern unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev,
 			unsigned char *buf, unsigned int buflen, int rw);
 extern u8 ata_sff_irq_on(struct ata_port *ap);

