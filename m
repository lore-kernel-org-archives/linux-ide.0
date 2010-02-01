From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] pata_opti: move code to be re-used by ide2libata to pata_opti.h
Date: Mon, 01 Feb 2010 15:08:38 +0100
Message-ID: <20100201140838.15716.8085.sendpatchset@localhost>
References: <20100201140832.15716.393.sendpatchset@localhost>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100201140832.15716.393.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_opti: move code to be re-used by ide2libata to pata_opti.h

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_opti.c |   90 ------------------------------------------------
 drivers/ata/pata_opti.h |   90 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 89 deletions(-)

Index: b/drivers/ata/pata_opti.c
===================================================================
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -35,14 +35,6 @@
 #define DRV_NAME "pata_opti"
 #define DRV_VERSION "0.2.9"
 
-enum {
-	READ_REG	= 0,	/* index of Read cycle timing register */
-	WRITE_REG 	= 1,	/* index of Write cycle timing register */
-	CNTRL_REG 	= 3,	/* index of Control register */
-	STRAP_REG 	= 5,	/* index of Strap register */
-	MISC_REG 	= 6	/* index of Miscellaneous register */
-};
-
 /**
  *	opti_pre_reset		-	probe begin
  *	@link: ATA link
@@ -66,87 +58,7 @@ static int opti_pre_reset(struct ata_lin
 	return ata_sff_prereset(link, deadline);
 }
 
-/**
- *	opti_write_reg		-	control register setup
- *	@ap: ATA port
- *	@value: value
- *	@reg: control register number
- *
- *	The Opti uses magic 'trapdoor' register accesses to do configuration
- *	rather than using PCI space as other controllers do. The double inw
- *	on the error register activates configuration mode. We can then write
- *	the control register
- */
-
-static void opti_write_reg(struct ata_port *ap, u8 val, int reg)
-{
-	void __iomem *regio = ap->ioaddr.cmd_addr;
-
-	/* These 3 unlock the control register access */
-	ioread16(regio + 1);
-	ioread16(regio + 1);
-	iowrite8(3, regio + 2);
-
-	/* Do the I/O */
-	iowrite8(val, regio + reg);
-
-	/* Relock */
-	iowrite8(0x83, regio + 2);
-}
-
-/**
- *	opti_set_piomode	-	set initial PIO mode data
- *	@ap: ATA interface
- *	@adev: ATA device
- *
- *	Called to do the PIO mode setup. Timing numbers are taken from
- *	the FreeBSD driver then pre computed to keep the code clean. There
- *	are two tables depending on the hardware clock speed.
- */
-
-static void opti_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	struct ata_device *pair = ata_dev_pair(adev);
-	int clock;
-	int pio = adev->pio_mode - XFER_PIO_0;
-	void __iomem *regio = ap->ioaddr.cmd_addr;
-	u8 addr;
-
-	/* Address table precomputed with prefetch off and a DCLK of 2 */
-	static const u8 addr_timing[2][5] = {
-		{ 0x30, 0x20, 0x20, 0x10, 0x10 },
-		{ 0x20, 0x20, 0x10, 0x10, 0x10 }
-	};
-	static const u8 data_rec_timing[2][5] = {
-		{ 0x6B, 0x56, 0x42, 0x32, 0x31 },
-		{ 0x58, 0x44, 0x32, 0x22, 0x21 }
-	};
-
-	iowrite8(0xff, regio + 5);
-	clock = ioread16(regio + 5) & 1;
-
-	/*
- 	 *	As with many controllers the address setup time is shared
- 	 *	and must suit both devices if present.
-	 */
-
-	addr = addr_timing[clock][pio];
-	if (pair) {
-		/* Hardware constraint */
-		u8 pair_addr = addr_timing[clock][pair->pio_mode - XFER_PIO_0];
-		if (pair_addr > addr)
-			addr = pair_addr;
-	}
-
-	/* Commence primary programming sequence */
-	opti_write_reg(ap, adev->devno, MISC_REG);
-	opti_write_reg(ap, data_rec_timing[clock][pio], READ_REG);
-	opti_write_reg(ap, data_rec_timing[clock][pio], WRITE_REG);
-	opti_write_reg(ap, addr, MISC_REG);
-
-	/* Programming sequence complete, override strapping */
-	opti_write_reg(ap, 0x85, CNTRL_REG);
-}
+#include "pata_opti.h"
 
 static struct scsi_host_template opti_sht = {
 	ATA_PIO_SHT(DRV_NAME),
Index: b/drivers/ata/pata_opti.h
===================================================================
--- /dev/null
+++ b/drivers/ata/pata_opti.h
@@ -0,0 +1,90 @@
+
+enum {
+	READ_REG	= 0,	/* index of Read cycle timing register */
+	WRITE_REG 	= 1,	/* index of Write cycle timing register */
+	CNTRL_REG 	= 3,	/* index of Control register */
+	STRAP_REG 	= 5,	/* index of Strap register */
+	MISC_REG 	= 6	/* index of Miscellaneous register */
+};
+
+/**
+ *	opti_write_reg		-	control register setup
+ *	@ap: ATA port
+ *	@value: value
+ *	@reg: control register number
+ *
+ *	The Opti uses magic 'trapdoor' register accesses to do configuration
+ *	rather than using PCI space as other controllers do. The double inw
+ *	on the error register activates configuration mode. We can then write
+ *	the control register
+ */
+
+static void opti_write_reg(struct ata_port *ap, u8 val, int reg)
+{
+	void __iomem *regio = ap->ioaddr.cmd_addr;
+
+	/* These 3 unlock the control register access */
+	ioread16(regio + 1);
+	ioread16(regio + 1);
+	iowrite8(3, regio + 2);
+
+	/* Do the I/O */
+	iowrite8(val, regio + reg);
+
+	/* Relock */
+	iowrite8(0x83, regio + 2);
+}
+
+/**
+ *	opti_set_piomode	-	set initial PIO mode data
+ *	@ap: ATA interface
+ *	@adev: ATA device
+ *
+ *	Called to do the PIO mode setup. Timing numbers are taken from
+ *	the FreeBSD driver then pre computed to keep the code clean. There
+ *	are two tables depending on the hardware clock speed.
+ */
+
+static void opti_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct ata_device *pair = ata_dev_pair(adev);
+	int clock;
+	int pio = adev->pio_mode - XFER_PIO_0;
+	void __iomem *regio = ap->ioaddr.cmd_addr;
+	u8 addr;
+
+	/* Address table precomputed with prefetch off and a DCLK of 2 */
+	static const u8 addr_timing[2][5] = {
+		{ 0x30, 0x20, 0x20, 0x10, 0x10 },
+		{ 0x20, 0x20, 0x10, 0x10, 0x10 }
+	};
+	static const u8 data_rec_timing[2][5] = {
+		{ 0x6B, 0x56, 0x42, 0x32, 0x31 },
+		{ 0x58, 0x44, 0x32, 0x22, 0x21 }
+	};
+
+	iowrite8(0xff, regio + 5);
+	clock = ioread16(regio + 5) & 1;
+
+	/*
+	 *	As with many controllers the address setup time is shared
+	 *	and must suit both devices if present.
+	 */
+
+	addr = addr_timing[clock][pio];
+	if (pair) {
+		/* Hardware constraint */
+		u8 pair_addr = addr_timing[clock][pair->pio_mode - XFER_PIO_0];
+		if (pair_addr > addr)
+			addr = pair_addr;
+	}
+
+	/* Commence primary programming sequence */
+	opti_write_reg(ap, adev->devno, MISC_REG);
+	opti_write_reg(ap, data_rec_timing[clock][pio], READ_REG);
+	opti_write_reg(ap, data_rec_timing[clock][pio], WRITE_REG);
+	opti_write_reg(ap, addr, MISC_REG);
+
+	/* Programming sequence complete, override strapping */
+	opti_write_reg(ap, 0x85, CNTRL_REG);
+}
