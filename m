From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 48/68] pata_cypress: move code to be re-used by ide2libata to pata_cypress.h
Date: Fri, 29 Jan 2010 17:08:16 +0100
Message-ID: <20100129160816.21495.94589.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755415Ab0A2QId@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cypress: move code to be re-used by ide2libata to pata_cypress.h

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cypress.c |   88 ---------------------------------------------
 drivers/ata/pata_cypress.h |   88 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 87 deletions(-)

Index: b/drivers/ata/pata_cypress.c
===================================================================
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -20,93 +20,7 @@
 #define DRV_NAME "pata_cypress"
 #define DRV_VERSION "0.1.5"
 
-/* here are the offset definitions for the registers */
-
-enum {
-	CY82_IDE_CMDREG		= 0x04,
-	CY82_IDE_ADDRSETUP	= 0x48,
-	CY82_IDE_MASTER_IOR	= 0x4C,
-	CY82_IDE_MASTER_IOW	= 0x4D,
-	CY82_IDE_SLAVE_IOR	= 0x4E,
-	CY82_IDE_SLAVE_IOW	= 0x4F,
-	CY82_IDE_MASTER_8BIT	= 0x50,
-	CY82_IDE_SLAVE_8BIT	= 0x51,
-
-	CY82_INDEX_PORT		= 0x22,
-	CY82_DATA_PORT		= 0x23,
-
-	CY82_INDEX_CTRLREG1	= 0x01,
-	CY82_INDEX_CHANNEL0	= 0x30,
-	CY82_INDEX_CHANNEL1	= 0x31,
-	CY82_INDEX_TIMEOUT	= 0x32
-};
-
-/**
- *	cy82c693_set_piomode	-	set initial PIO mode data
- *	@ap: ATA interface
- *	@adev: ATA device
- *
- *	Called to do the PIO mode setup.
- */
-
-static void cy82c693_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	struct ata_timing t;
-	const unsigned long T = 1000000 / 33;
-	short time_16, time_8;
-	u32 addr;
-
-	ata_timing_compute(adev->id, adev->pio_mode, adev->pio_mode, &t, T, 1);
-
-	time_16 = clamp_val(t.recover - 1, 0, 15) |
-		  (clamp_val(t.active - 1, 0, 15) << 4);
-	time_8 = clamp_val(t.act8b - 1, 0, 15) |
-		 (clamp_val(t.rec8b - 1, 0, 15) << 4);
-
-	if (adev->devno == 0) {
-		pci_read_config_dword(pdev, CY82_IDE_ADDRSETUP, &addr);
-
-		addr &= ~0x0F;	/* Mask bits */
-		addr |= clamp_val(t.setup - 1, 0, 15);
-
-		pci_write_config_dword(pdev, CY82_IDE_ADDRSETUP, addr);
-		pci_write_config_byte(pdev, CY82_IDE_MASTER_IOR, time_16);
-		pci_write_config_byte(pdev, CY82_IDE_MASTER_IOW, time_16);
-		pci_write_config_byte(pdev, CY82_IDE_MASTER_8BIT, time_8);
-	} else {
-		pci_read_config_dword(pdev, CY82_IDE_ADDRSETUP, &addr);
-
-		addr &= ~0xF0;	/* Mask bits */
-		addr |= (clamp_val(t.setup - 1, 0, 15) << 4);
-
-		pci_write_config_dword(pdev, CY82_IDE_ADDRSETUP, addr);
-		pci_write_config_byte(pdev, CY82_IDE_SLAVE_IOR, time_16);
-		pci_write_config_byte(pdev, CY82_IDE_SLAVE_IOW, time_16);
-		pci_write_config_byte(pdev, CY82_IDE_SLAVE_8BIT, time_8);
-	}
-}
-
-/**
- *	cy82c693_set_dmamode	-	set initial DMA mode data
- *	@ap: ATA interface
- *	@adev: ATA device
- *
- *	Called to do the DMA mode setup.
- */
-
-static void cy82c693_set_dmamode(struct ata_port *ap, struct ata_device *adev)
-{
-	int reg = CY82_INDEX_CHANNEL0 + ap->port_no;
-
-	/* Be afraid, be very afraid. Magic registers  in low I/O space */
-	outb(reg, 0x22);
-	outb(adev->dma_mode - XFER_MW_DMA_0, 0x23);
-
-	/* 0x50 gives the best behaviour on the Alpha's using this chip */
-	outb(CY82_INDEX_TIMEOUT, 0x22);
-	outb(0x50, 0x23);
-}
+#include "pata_cypress.h"
 
 static struct scsi_host_template cy82c693_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
Index: b/drivers/ata/pata_cypress.h
===================================================================
--- /dev/null
+++ b/drivers/ata/pata_cypress.h
@@ -0,0 +1,88 @@
+
+/* here are the offset definitions for the registers */
+
+enum {
+	CY82_IDE_CMDREG		= 0x04,
+	CY82_IDE_ADDRSETUP	= 0x48,
+	CY82_IDE_MASTER_IOR	= 0x4C,
+	CY82_IDE_MASTER_IOW	= 0x4D,
+	CY82_IDE_SLAVE_IOR	= 0x4E,
+	CY82_IDE_SLAVE_IOW	= 0x4F,
+	CY82_IDE_MASTER_8BIT	= 0x50,
+	CY82_IDE_SLAVE_8BIT	= 0x51,
+
+	CY82_INDEX_PORT		= 0x22,
+	CY82_DATA_PORT		= 0x23,
+
+	CY82_INDEX_CTRLREG1	= 0x01,
+	CY82_INDEX_CHANNEL0	= 0x30,
+	CY82_INDEX_CHANNEL1	= 0x31,
+	CY82_INDEX_TIMEOUT	= 0x32
+};
+
+/**
+ *	cy82c693_set_piomode	-	set initial PIO mode data
+ *	@ap: ATA interface
+ *	@adev: ATA device
+ *
+ *	Called to do the PIO mode setup.
+ */
+
+static void cy82c693_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	struct ata_timing t;
+	const unsigned long T = 1000000 / 33;
+	short time_16, time_8;
+	u32 addr;
+
+	ata_timing_compute(adev->id, adev->pio_mode, adev->pio_mode, &t, T, 1);
+
+	time_16 = clamp_val(t.recover - 1, 0, 15) |
+		  (clamp_val(t.active - 1, 0, 15) << 4);
+	time_8 = clamp_val(t.act8b - 1, 0, 15) |
+		 (clamp_val(t.rec8b - 1, 0, 15) << 4);
+
+	if (adev->devno == 0) {
+		pci_read_config_dword(pdev, CY82_IDE_ADDRSETUP, &addr);
+
+		addr &= ~0x0F;	/* Mask bits */
+		addr |= clamp_val(t.setup - 1, 0, 15);
+
+		pci_write_config_dword(pdev, CY82_IDE_ADDRSETUP, addr);
+		pci_write_config_byte(pdev, CY82_IDE_MASTER_IOR, time_16);
+		pci_write_config_byte(pdev, CY82_IDE_MASTER_IOW, time_16);
+		pci_write_config_byte(pdev, CY82_IDE_MASTER_8BIT, time_8);
+	} else {
+		pci_read_config_dword(pdev, CY82_IDE_ADDRSETUP, &addr);
+
+		addr &= ~0xF0;	/* Mask bits */
+		addr |= (clamp_val(t.setup - 1, 0, 15) << 4);
+
+		pci_write_config_dword(pdev, CY82_IDE_ADDRSETUP, addr);
+		pci_write_config_byte(pdev, CY82_IDE_SLAVE_IOR, time_16);
+		pci_write_config_byte(pdev, CY82_IDE_SLAVE_IOW, time_16);
+		pci_write_config_byte(pdev, CY82_IDE_SLAVE_8BIT, time_8);
+	}
+}
+
+/**
+ *	cy82c693_set_dmamode	-	set initial DMA mode data
+ *	@ap: ATA interface
+ *	@adev: ATA device
+ *
+ *	Called to do the DMA mode setup.
+ */
+
+static void cy82c693_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	int reg = CY82_INDEX_CHANNEL0 + ap->port_no;
+
+	/* Be afraid, be very afraid. Magic registers  in low I/O space */
+	outb(reg, 0x22);
+	outb(adev->dma_mode - XFER_MW_DMA_0, 0x23);
+
+	/* 0x50 gives the best behaviour on the Alpha's using this chip */
+	outb(CY82_INDEX_TIMEOUT, 0x22);
+	outb(0x50, 0x23);
+}
