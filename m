From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4 v2] ata: Add driver for Faraday Technology FTIDE010
Date: Sat, 20 May 2017 01:05:59 +0200
Message-ID: <20170519230600.16782-3-linus.walleij@linaro.org>
References: <20170519230600.16782-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33394 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756220AbdESXGV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2017 19:06:21 -0400
Received: by mail-lf0-f43.google.com with SMTP id m18so7973613lfj.0
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2017 16:06:20 -0700 (PDT)
In-Reply-To: <20170519230600.16782-1-linus.walleij@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org
Cc: Janos Laube <janos.dev@gmail.com>, Paulius Zaleckas <paulius.zaleckas@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Florian Fainelli <f.fainelli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, John Feng-Hsin Chiang <john453@faraday-tech.com>, Greentime Hu <green.hu@gmail.com>

This adds a driver for the Faraday Technology FTIDE010
PATA IP block.

When used with the Storlink/Storm/Cortina Systems Gemini
SoC, the PATA interface is accompanied by a PATA<->SATA
bridge, so while the device appear as a PATA controller,
it attaches physically to SATA disks, and also has a
designated memory area with registers to set up the bridge.

The Gemini SATA bridge is separated into its own driver
file to make things modular and make it possible to reuse
the PATA driver as stand-alone on other systems than the
Gemini.

dmesg excerpt from the D-Link DIR-685 storage router:
gemini-sata-bridge 46000000.sata: SATA ID 00000e00, PHY ID: 01000100
gemini-sata-bridge 46000000.sata: set up the Gemini IDE/SATA nexus
ftide010 63000000.ata: set up Gemini PATA0
ftide010 63000000.ata: device ID 00000500, irq 26, io base 0x63000000
ftide010 63000000.ata: SATA0 (master) start
gemini-sata-bridge 46000000.sata: SATA0 PHY ready
scsi host0: pata-ftide010
ata1: PATA max UDMA/133 irq 26
ata1.00: ATA-8: INTEL SSDSA2CW120G3, 4PC10302, max UDMA/133
ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSA2CW12 0302 PQ: 0 ANSI: 5
ata1.00: Enabling discard_zeroes_data
sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 GB/112 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache:
                  enabled, doesn't support DPO or FUA
ata1.00: Enabling discard_zeroes_data
ata1.00: Enabling discard_zeroes_data
sd 0:0:0:0: [sda] Attached SCSI disk

After this I can flawlessly mount and read/write copy etc files
from /dev/sda[n].

Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drop the parsing of timings from the device tree, instead
  keeping it in the driver, copying over the documentation
  from the device tree and the nice structure so that
  it's easy to modify for other SoCs.
- Some fixes to bail out from .port_start() if there is no
  drive connected to the bridge, without us having to wait
  for a timeout.
- Fix up the inclusion guard in the header file to be an
  inclusion guard and not #ifdef CONFIG_FOO (which will anyways
  not work for things compiled as module).

Faraday people: I do not have it from a source that this
hardware is really FTIDE010 but I would be VERY surprised
if it is not. U-Boot has an FTIDE020 IDE controller
synthesized in the Andestech platform, and it has a similar
yet different register layout, featuring similar timing
set-ups:
http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/block/ftide020.h
http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/block/ftide020.c
---
 MAINTAINERS                 |   9 +
 drivers/ata/Kconfig         |  21 ++
 drivers/ata/Makefile        |   2 +
 drivers/ata/pata_ftide010.c | 552 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/sata_gemini.c   | 419 +++++++++++++++++++++++++++++++++
 drivers/ata/sata_gemini.h   |  21 ++
 6 files changed, 1024 insertions(+)
 create mode 100644 drivers/ata/pata_ftide010.c
 create mode 100644 drivers/ata/sata_gemini.c
 create mode 100644 drivers/ata/sata_gemini.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b8f133..96753be12026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7531,6 +7531,15 @@ S:	Maintained
 F:	drivers/ata/pata_*.c
 F:	drivers/ata/ata_generic.c
 
+LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
+M:	Linus Walleij <linus.walleij@linaro.org>
+L:	linux-ide@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git
+S:	Maintained
+F:	drivers/ata/pata_ftide010.c
+F:	drivers/ata/sata_gemini.c
+F:	drivers/ata/sata_gemini.h
+
 LIBATA SATA AHCI PLATFORM devices support
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Tejun Heo <tj@kernel.org>
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index de3eaf051697..948fc86980a1 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -213,6 +213,16 @@ config SATA_FSL
 
 	  If unsure, say N.
 
+config SATA_GEMINI
+	tristate "Gemini SATA bridge support"
+	depends on PATA_FTIDE010
+	default ARCH_GEMINI
+	help
+	  This enabled support for the FTIDE010 to SATA bridge
+	  found in Cortina Systems Gemini platform.
+
+	  If unsure, say N.
+
 config SATA_AHCI_SEATTLE
 	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
 	depends on ARCH_SEATTLE
@@ -599,6 +609,17 @@ config PATA_EP93XX
 
 	  If unsure, say N.
 
+config PATA_FTIDE010
+	tristate "Faraday Technology FTIDE010 PATA support"
+	depends on OF
+	depends on ARM
+	default ARCH_GEMINI
+	help
+	  This option enables support for the Faraday FTIDE010
+	  PATA controller found in the Cortina Gemini SoCs.
+
+	  If unsure, say N.
+
 config PATA_HPT366
 	tristate "HPT 366/368 PATA support"
 	depends on PCI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index cd931a5eba92..a26ef5a93919 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SATA_ACARD_AHCI)	+= acard-ahci.o libahci.o
 obj-$(CONFIG_SATA_AHCI_SEATTLE)	+= ahci_seattle.o libahci.o libahci_platform.o
 obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o libahci_platform.o
 obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
+obj-$(CONFIG_SATA_GEMINI)	+= sata_gemini.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
@@ -60,6 +61,7 @@ obj-$(CONFIG_PATA_CS5536)	+= pata_cs5536.o
 obj-$(CONFIG_PATA_CYPRESS)	+= pata_cypress.o
 obj-$(CONFIG_PATA_EFAR)		+= pata_efar.o
 obj-$(CONFIG_PATA_EP93XX)	+= pata_ep93xx.o
+obj-$(CONFIG_PATA_FTIDE010)	+= pata_ftide010.o
 obj-$(CONFIG_PATA_HPT366)	+= pata_hpt366.o
 obj-$(CONFIG_PATA_HPT37X)	+= pata_hpt37x.o
 obj-$(CONFIG_PATA_HPT3X2N)	+= pata_hpt3x2n.o
diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
new file mode 100644
index 000000000000..d14100ca7fab
--- /dev/null
+++ b/drivers/ata/pata_ftide010.c
@@ -0,0 +1,552 @@
+/*
+ * Faraday Technology FTIDE010 driver
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * Includes portions of the SL2312/SL3516/Gemini PATA driver
+ * Copyright (C) 2003 StorLine, Inc <jason@storlink.com.tw>
+ * Copyright (C) 2009 Janos Laube <janos.dev@gmail.com>
+ * Copyright (C) 2010 Frederic Pecourt <opengemini@free.fr>
+ * Copyright (C) 2011 Tobias Waldvogel <tobias.waldvogel@gmail.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+#include <linux/bitops.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
+#include "sata_gemini.h"
+
+/**
+ * struct ftide010 - state container for the Faraday FTIDE010
+ * @dev: pointer back to the device representing this controller
+ * @base: remapped I/O space address
+ * @pclk: peripheral clock for the IDE block
+ * @host: pointer to the ATA host for this device
+ * @pio_timings: combined active/recovery values to be written to
+ * the PIO timing register for modes 0, 1, 2, 3 and 4.
+ * @mwdma_50_timings: combined active/recovery values to be written
+ * to the multiword DMA mode timing register for modes 0, 1 and 2
+ * at 50MHz speed
+ * @mwdma_66_timings: same as @mwdma_50_timings but for 66MHz
+ * @udma_50_timings: combined setup/hold values to be written
+ * to the ultra DMA mode timing register for modes 0-5 at 50MHz
+ * speed
+ * @udma_66_timings: combined setup/hold values to be written
+ * to the ultra DMA mode timing register for modes 0-6 at 66MHz
+ * speed
+ * @master_cbl: master cable type
+ * @slave_cbl: slave cable type
+ * @sg: Gemini SATA bridge pointer, if running on the Gemini
+ */
+struct ftide010 {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *pclk;
+	struct ata_host *host;
+	u8 pio_timings[5];
+	u8 mwdma_50_timings[3];
+	u8 mwdma_66_timings[3];
+	u8 udma_50_timings[6];
+	u8 udma_66_timings[7];
+	unsigned int master_cbl;
+	unsigned int slave_cbl;
+	/* Gemini-specific properties */
+	struct sata_gemini *sg;
+	bool master_to_sata0;
+	bool slave_to_sata0;
+	bool master_to_sata1;
+	bool slave_to_sata1;
+};
+
+#define DMA_REG			0x00
+#define DMA_STATUS		0x02
+#define IDE_BMDTPR		0x04
+#define IDE_DEVICE_ID		0x08
+#define PIO_TIMING_REG		0x10
+#define MWDMA_TIMING_REG	0x11
+#define UDMA_TIMING0_REG	0x12 /* Master */
+#define UDMA_TIMING1_REG	0x13 /* Slave */
+#define CLK_MOD_REG		0x14
+/* These registers are mapped directly to the IDE registers */
+#define CMD_DATA_REG		0x20
+#define ERROR_FEATURES_REG	0x21
+#define NSECT_REG		0x22
+#define LBAL_REG		0x23
+#define LBAM_REG		0x24
+#define LBAH_REG		0x25
+#define DEVICE_REG		0x26
+#define STATUS_COMMAND_REG	0x27
+#define ALTSTAT_CTRL_REG	0x36
+
+/* Set this bit for UDMA mode 5 and 6 */
+#define UDMA_TIMING_MODE_56	BIT(7)
+
+/* 0 = 50 MHz, 1 = 66 MHz */
+#define CLK_MOD_DEV0_CLK_SEL	BIT(0)
+#define CLK_MOD_DEV1_CLK_SEL	BIT(1)
+/* Enable UDMA on a device */
+#define CLK_MOD_DEV0_UDMA_EN	BIT(4)
+#define CLK_MOD_DEV1_UDMA_EN	BIT(5)
+
+static struct scsi_host_template pata_ftide010_sht = {
+	ATA_BMDMA_SHT("pata-ftide010"),
+};
+
+/*
+ * We set 66 MHz for all MWDMA modes
+ */
+static const bool set_mdma_66_mhz[] = { true, true, true, true };
+
+/*
+ * We set 66 MHz for UDMA modes 3, 4 and 6 and no others
+ */
+static const bool set_udma_66_mhz[] = { false, false, false, true, true, false, true };
+
+static void ftide010_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct ftide010 *ftide = ap->host->private_data;
+	unsigned short speed = adev->dma_mode;
+	u8 devno = adev->devno & 1;
+	u8 udma_en_mask;
+	u8 f66m_en_mask;
+	u8 clkreg;
+	u8 timreg;
+	unsigned int i;
+
+	/* Target device 0 (master) or 1 (slave) */
+	if (!devno) {
+		udma_en_mask = CLK_MOD_DEV0_UDMA_EN;
+		f66m_en_mask = CLK_MOD_DEV0_CLK_SEL;
+	} else {
+		udma_en_mask = CLK_MOD_DEV1_UDMA_EN;
+		f66m_en_mask = CLK_MOD_DEV1_CLK_SEL;
+	}
+
+	clkreg = ioread8(ftide->base + CLK_MOD_REG);
+	clkreg &= ~udma_en_mask;
+	clkreg &= ~f66m_en_mask;
+
+	if (speed & XFER_UDMA_0) {
+		i = speed & ~XFER_UDMA_0;
+		dev_dbg(ftide->dev, "set UDMA mode %02x, index %d\n",
+			speed, i);
+
+		clkreg |= udma_en_mask;
+		if (set_udma_66_mhz[i]) {
+			clkreg |= f66m_en_mask;
+			timreg = ftide->udma_66_timings[i];
+		} else {
+			timreg = ftide->udma_50_timings[i];
+		}
+
+		/* A special bit needs to be set for modes 5 and 6 */
+		if (i >= 5)
+			timreg |= UDMA_TIMING_MODE_56;
+
+		dev_dbg(ftide->dev, "UDMA write clkreg = %02x, timreg = %02x\n",
+			clkreg, timreg);
+
+		writeb(clkreg, ftide->base + CLK_MOD_REG);
+		writeb(timreg, ftide->base + UDMA_TIMING0_REG + devno);
+	} else {
+		i = speed & ~XFER_MW_DMA_0;
+		dev_dbg(ftide->dev, "set MWDMA mode %02x, index %d\n",
+			speed, i);
+
+		if (set_mdma_66_mhz[i]) {
+			clkreg |= f66m_en_mask;
+			timreg = ftide->mwdma_66_timings[i];
+		} else {
+			timreg = ftide->mwdma_50_timings[i];
+		}
+		dev_dbg(ftide->dev,
+			"MWDMA write clkreg = %02x, timreg = %02x\n",
+			clkreg, timreg);
+		/* This will affect all devices */
+		writeb(clkreg, ftide->base + CLK_MOD_REG);
+		writeb(timreg, ftide->base + MWDMA_TIMING_REG);
+	}
+
+	return;
+}
+
+static void ftide010_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct ftide010 *ftide = ap->host->private_data;
+	unsigned int pio = adev->pio_mode - XFER_PIO_0;
+
+	dev_dbg(ftide->dev, "set PIO mode %02x, index %d\n",
+		adev->pio_mode, pio);
+	writeb(ftide->pio_timings[pio], ftide->base + PIO_TIMING_REG);
+}
+
+static struct ata_port_operations pata_ftide010_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.set_dmamode	= ftide010_set_dmamode,
+	.set_piomode	= ftide010_set_piomode,
+};
+
+static struct ata_port_info ftide010_port_info[] = {
+	{
+		.flags		= ATA_FLAG_SLAVE_POSS,
+		.mwdma_mask	= ATA_MWDMA2,
+		.udma_mask	= ATA_UDMA6,
+		.pio_mask	= ATA_PIO4,
+		.port_ops	= &pata_ftide010_port_ops,
+	},
+};
+
+#if IS_ENABLED(CONFIG_SATA_GEMINI)
+
+static int pata_ftide010_gemini_port_start(struct ata_port *ap)
+{
+	struct ftide010 *ftide = ap->host->private_data;
+	struct device *dev = ftide->dev;
+	struct sata_gemini *sg = ftide->sg;
+	int bridges = 0;
+	int ret;
+
+	ret = ata_bmdma_port_start(ap);
+	if (ret)
+		return ret;
+
+	if (ftide->master_to_sata0) {
+		dev_info(dev, "SATA0 (master) start\n");
+		ret = gemini_sata_start_bridge(sg, 0);
+		if (!ret)
+			bridges++;
+	}
+	if (ftide->master_to_sata1) {
+		dev_info(dev, "SATA1 (master) start\n");
+		ret = gemini_sata_start_bridge(sg, 1);
+		if (!ret)
+			bridges++;
+	}
+	/* Avoid double-starting */
+	if (ftide->slave_to_sata0 && !ftide->master_to_sata0) {
+		dev_info(dev, "SATA0 (slave) start\n");
+		ret = gemini_sata_start_bridge(sg, 0);
+		if (!ret)
+			bridges++;
+	}
+	/* Avoid double-starting */
+	if (ftide->slave_to_sata1 && !ftide->master_to_sata1) {
+		dev_info(dev, "SATA1 (slave) start\n");
+		ret = gemini_sata_start_bridge(sg, 1);
+		if (!ret)
+			bridges++;
+	}
+
+	dev_info(dev, "brought %d bridges online\n", bridges);
+	return (bridges > 0) ? 0 : -EINVAL; // -ENODEV;
+}
+
+static void pata_ftide010_gemini_port_stop(struct ata_port *ap)
+{
+	struct ftide010 *ftide = ap->host->private_data;
+	struct device *dev = ftide->dev;
+	struct sata_gemini *sg = ftide->sg;
+
+	if (ftide->master_to_sata0) {
+		dev_info(dev, "SATA0 (master) stop\n");
+		gemini_sata_stop_bridge(sg, 0);
+	}
+	if (ftide->master_to_sata1) {
+		dev_info(dev, "SATA1 (master) stop\n");
+		gemini_sata_stop_bridge(sg, 1);
+	}
+	/* Avoid double-stopping */
+	if (ftide->slave_to_sata0 && !ftide->master_to_sata0) {
+		dev_info(dev, "SATA0 (slave) stop\n");
+		gemini_sata_stop_bridge(sg, 0);
+	}
+	/* Avoid double-stopping */
+	if (ftide->slave_to_sata1 && !ftide->master_to_sata1) {
+		dev_info(dev, "SATA1 (slave) stop\n");
+		gemini_sata_stop_bridge(sg, 1);
+	}
+}
+
+static int pata_ftide010_gemini_cable_detect(struct ata_port *ap)
+{
+	struct ftide010 *ftide = ap->host->private_data;
+
+	/*
+	 * Return the master cable, I have no clue how to return a different
+	 * cable for the slave than for the master.
+	 */
+	return ftide->master_cbl;
+}
+
+static int pata_ftide010_gemini_init(struct ftide010 *ftide,
+				     bool is_ata1)
+{
+	struct device *dev = ftide->dev;
+	struct sata_gemini *sg;
+	enum gemini_muxmode muxmode;
+
+	/* Look up SATA bridge */
+	sg = gemini_sata_bridge_get();
+	if (IS_ERR(sg))
+		return PTR_ERR(sg);
+	ftide->sg = sg;
+
+	muxmode = gemini_sata_get_muxmode(sg);
+
+	/* Special ops */
+	pata_ftide010_port_ops.port_start =
+		pata_ftide010_gemini_port_start;
+	pata_ftide010_port_ops.port_stop =
+		pata_ftide010_gemini_port_stop;
+	pata_ftide010_port_ops.cable_detect =
+		pata_ftide010_gemini_cable_detect;
+
+	/* Flag port as SATA-capable */
+	if (gemini_sata_bridge_enabled(sg, is_ata1))
+		ftide010_port_info[0].flags |= ATA_FLAG_SATA;
+
+	if (!is_ata1) {
+		switch (muxmode) {
+		case GEMINI_MUXMODE_0:
+			ftide->master_cbl = ATA_CBL_SATA;
+			ftide->slave_cbl = ATA_CBL_PATA40;
+			ftide->master_to_sata0 = true;
+			break;
+		case GEMINI_MUXMODE_1:
+			ftide->master_cbl = ATA_CBL_SATA;
+			ftide->slave_cbl = ATA_CBL_NONE;
+			ftide->master_to_sata0 = true;
+			break;
+		case GEMINI_MUXMODE_2:
+			ftide->master_cbl = ATA_CBL_PATA40;
+			ftide->slave_cbl = ATA_CBL_PATA40;
+			break;
+		case GEMINI_MUXMODE_3:
+			ftide->master_cbl = ATA_CBL_SATA;
+			ftide->slave_cbl = ATA_CBL_SATA;
+			ftide->master_to_sata0 = true;
+			ftide->slave_to_sata1 = true;
+			break;
+		}
+	} else {
+		switch (muxmode) {
+		case GEMINI_MUXMODE_0:
+			ftide->master_cbl = ATA_CBL_SATA;
+			ftide->slave_cbl = ATA_CBL_NONE;
+			ftide->master_to_sata1 = true;
+			break;
+		case GEMINI_MUXMODE_1:
+			ftide->master_cbl = ATA_CBL_SATA;
+			ftide->slave_cbl = ATA_CBL_PATA40;
+			ftide->master_to_sata1 = true;
+			break;
+		case GEMINI_MUXMODE_2:
+			ftide->master_cbl = ATA_CBL_SATA;
+			ftide->slave_cbl = ATA_CBL_SATA;
+			ftide->slave_to_sata0 = true;
+			ftide->master_to_sata1 = true;
+			break;
+		case GEMINI_MUXMODE_3:
+			ftide->master_cbl = ATA_CBL_PATA40;
+			ftide->slave_cbl = ATA_CBL_PATA40;
+			break;
+		}
+	}
+	dev_info(dev, "set up Gemini PATA%d\n", is_ata1);
+
+	return 0;
+}
+#else
+static int pata_ftide010_gemini_init(struct ftide010 *ftide,
+				     bool is_ata1)
+{
+	return -ENOTSUPP;
+}
+#endif
+
+/*
+ * Bus timings
+ *
+ * The unit of the below required timings is two clock periods of the ATA
+ * reference clock which is 30 nanoseconds per unit at 66MHz and 20
+ * nanoseconds per unit at 50 MHz. The PIO timings assume 33MHz speed for
+ * PIO.
+ *
+ * pio_active_time: array of 5 elements for T2 timing for Mode 0,
+ * 1, 2, 3 and 4. Range 0..15.
+ * pio_recovery_time: array of 5 elements for T2l timing for Mode 0,
+ * 1, 2, 3 and 4. Range 0..15.
+ * mdma_50_active_time: array of 4 elements for Td timing for multi
+ * word DMA, Mode 0, 1, and 2 at 50 MHz. Range 0..15.
+ * mdma_50_recovery_time: array of 4 elements for Tk timing for
+ * multi word DMA, Mode 0, 1 and 2 at 50 MHz. Range 0..15.
+ * mdma_66_active_time: array of 4 elements for Td timing for multi
+ * word DMA, Mode 0, 1 and 2 at 66 MHz. Range 0..15.
+ * mdma_66_recovery_time: array of 4 elements for Tk timing for
+ * multi word DMA, Mode 0, 1 and 2 at 66 MHz. Range 0..15.
+ * udma_50_setup_time: array of 4 elements for Tvds timing for ultra
+ * DMA, Mode 0, 1, 2, 3, 4 and 5 at 50 MHz. Range 0..7.
+ * udma_50_hold_time: array of 4 elements for Tdvh timing for
+ * multi word DMA, Mode 0, 1, 2, 3, 4 and 5 at 50 MHz, Range 0..7.
+ * udma_66_setup_time: array of 4 elements for Tvds timing for multi
+ * word DMA, Mode 0, 1, 2, 3, 4, 5 and 6 at 66 MHz. Range 0..7.
+ * udma_66_hold_time: array of 4 elements for Tdvh timing for
+ * multi word DMA, Mode 0, 1, 2, 3, 4, 5 and 6 at 66 MHz. Range 0..7.
+ */
+static const u8 pio_active_time[5] = {10, 10, 10, 3, 3};
+static const u8 pio_recovery_time[5] = {10, 3, 1, 3, 1};
+static const u8 mwdma_50_active_time[3] = {6, 2, 2};
+static const u8 mwdma_50_recovery_time[3] = {6, 2, 1};
+static const u8 mwdma_66_active_time[3] = {8, 3, 3};
+static const u8 mwdma_66_recovery_time[3] = {8, 2, 1};
+static const u8 udma_50_setup_time[6] = {3, 3, 2, 2, 1, 1};
+static const u8 udma_50_hold_time[6] = {3, 1, 1, 1, 1, 1};
+static const u8 udma_66_setup_time[7] = {4, 4, 3, 2, };
+static const u8 udma_66_hold_time[7] = {};
+
+static int pata_ftide010_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct ata_port_info pi = ftide010_port_info[0];
+	const struct ata_port_info *ppi[] = { &pi, NULL };
+	struct ftide010 *ftide;
+	struct resource *res;
+	int irq;
+	int ret;
+	int i;
+
+	ftide = devm_kzalloc(dev, sizeof(*ftide), GFP_KERNEL);
+	if (!ftide)
+		return -ENOMEM;
+	ftide->dev = dev;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	ftide->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ftide->base))
+		return PTR_ERR(ftide->base);
+
+	ftide->pclk = devm_clk_get(dev, "PCLK");
+	if (!IS_ERR(ftide->pclk)) {
+		ret = clk_prepare_enable(ftide->pclk);
+		if (ret) {
+			dev_err(dev, "failed to enable PCLK\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * Assign default timings, this can be augmented for different
+	 * compatible-strings in the future.
+	 */
+	for (i = 0; i < sizeof(ftide->pio_timings); i++) {
+		ftide->pio_timings[i] = (pio_active_time[i] << 4) |
+			pio_recovery_time[i];
+	}
+	for (i = 0; i < sizeof(ftide->mwdma_50_timings); i++) {
+		ftide->mwdma_50_timings[i] = (mwdma_50_active_time[i] << 4) |
+			mwdma_50_recovery_time[i];
+		ftide->mwdma_66_timings[i] = (mwdma_66_active_time[i] << 4) |
+			mwdma_66_recovery_time[i];
+	}
+	for (i = 0; i < sizeof(ftide->udma_50_timings); i++) {
+		ftide->udma_50_timings[i] = (udma_50_setup_time[6] << 4) |
+			udma_50_hold_time[i];
+		ftide->udma_66_timings[i] = (udma_66_setup_time[6] << 4) |
+			udma_66_hold_time[i];
+	}
+
+	/* Some special Cortina Gemini init, if needed */
+	if (of_device_is_compatible(np, "cortina,gemini-pata")) {
+		/*
+		 * We need to know which instance is probing (the
+		 * Gemini has two instances of FTIDE010) and we do
+		 * this simply by looking at the physical base
+		 * address, which is 0x63400000 for ATA1, else we
+		 * are ATA0. This will also set up the cable types.
+		 */
+		ret = pata_ftide010_gemini_init(ftide,
+				(res->start == 0x63400000));
+		if (ret)
+			goto err_dis_clk;
+	} else {
+		/* Else assume we are connected using PATA40 */
+		ftide->master_cbl = ATA_CBL_PATA40;
+		ftide->slave_cbl = ATA_CBL_PATA40;
+	}
+
+	ftide->host = ata_host_alloc_pinfo(dev, ppi, 1);
+	if (!ftide->host) {
+		ret = -ENOMEM;
+		goto err_dis_clk;
+	}
+	ftide->host->private_data = ftide;
+
+	for (i = 0; i < ftide->host->n_ports; i++) {
+		struct ata_port *ap = ftide->host->ports[i];
+		struct ata_ioports *ioaddr = &ap->ioaddr;
+
+		ioaddr->bmdma_addr = ftide->base + DMA_REG;
+		ioaddr->cmd_addr = ftide->base + CMD_DATA_REG;
+		ioaddr->ctl_addr = ftide->base + ALTSTAT_CTRL_REG;
+		ioaddr->altstatus_addr = ftide->base + ALTSTAT_CTRL_REG;
+		ata_sff_std_ports(ioaddr);
+	}
+
+	platform_set_drvdata(pdev, ftide);
+	dev_info(dev, "device ID %08x, irq %d, io base 0x%08x\n",
+		 readl(ftide->base + IDE_DEVICE_ID), irq, res->start);
+
+	ret = ata_host_activate(ftide->host, irq, ata_bmdma_interrupt,
+				0, &pata_ftide010_sht);
+	if (ret)
+		goto err_dis_clk;
+
+	return 0;
+
+err_dis_clk:
+	if (!IS_ERR(ftide->pclk))
+		clk_disable_unprepare(ftide->pclk);
+	return ret;
+}
+
+static int pata_ftide010_remove(struct platform_device *pdev)
+{
+	struct ftide010 *ftide = platform_get_drvdata(pdev);
+
+	ata_host_detach(ftide->host);
+	if (!IS_ERR(ftide->pclk))
+		clk_disable_unprepare(ftide->pclk);
+
+	return 0;
+}
+
+static const struct of_device_id pata_ftide010_of_match[] = {
+	{
+		.compatible = "faraday,ftide010",
+	},
+	{},
+};
+
+static struct platform_driver pata_ftide010_driver = {
+	.driver = {
+		.name = "ftide010",
+		.of_match_table = of_match_ptr(pata_ftide010_of_match),
+	},
+	.probe = pata_ftide010_probe,
+	.remove = pata_ftide010_remove,
+};
+module_platform_driver(pata_ftide010_driver);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pata-ftide010");
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
new file mode 100644
index 000000000000..2618dbf5fc44
--- /dev/null
+++ b/drivers/ata/sata_gemini.c
@@ -0,0 +1,419 @@
+/*
+ * Cortina Systems Gemini SATA bridge add-on to Faraday FTIDE010
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/bitops.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/reset.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include "sata_gemini.h"
+
+/**
+ * struct sata_gemini - a state container for a Gemini SATA bridge
+ * @dev: the containing device
+ * @base: remapped I/O memory base
+ * @muxmode: the current muxing mode
+ * @ide_pins: if the device is using the plain IDE interface pins
+ * @sata_bridge: if the device enables the SATA bridge
+ * @sata0_reset: SATA0 reset handler
+ * @sata1_reset: SATA1 reset handler
+ * @sata0_pclk: SATA0 PCLK handler
+ * @sata1_pclk: SATA1 PCLK handler
+ */
+struct sata_gemini {
+	struct device *dev;
+	void __iomem *base;
+	enum gemini_muxmode muxmode;
+	bool ide_pins;
+	bool sata_bridge;
+	struct reset_control *sata0_reset;
+	struct reset_control *sata1_reset;
+	struct clk *sata0_pclk;
+	struct clk *sata1_pclk;
+};
+
+/* Global IDE PAD Skew Control Register */
+#define GLOBAL_IDE_SKEW_CTRL		0x18
+#define IDE1_HOST_STROBE_DELAY_SHIFT	28
+#define IDE1_DEVICE_STROBE_DELAY_SHIFT	24
+#define IDE1_OUTPUT_IO_SKEW_SHIFT	20
+#define IDE1_INPUT_IO_SKEW_SHIFT	16
+#define IDE0_HOST_STROBE_DELAY_SHIFT	12
+#define IDE0_DEVICE_STROBE_DELAY_SHIFT	8
+#define IDE0_OUTPUT_IO_SKEW_SHIFT	4
+#define IDE0_INPUT_IO_SKEW_SHIFT	0
+
+/* Miscellaneous Control Register */
+#define GLOBAL_MISC_CTRL		0x30
+/*
+ * Values of IDE IOMUX bits in the misc control register
+ *
+ * Bits 26:24 are "IDE IO Select", which decides what SATA
+ * adapters are connected to which of the two IDE/ATA
+ * controllers in the Gemini. We can connect the two IDE blocks
+ * to one SATA adapter each, both acting as master, or one IDE
+ * blocks to two SATA adapters so the IDE block can act in a
+ * master/slave configuration.
+ *
+ * We also bring out different blocks on the actual IDE
+ * pins (not SATA pins) if (and only if) these are muxed in.
+ *
+ * 111-100 - Reserved
+ * Mode 0: 000 - ata0 master <-> sata0
+ *               ata1 master <-> sata1
+ *               ata0 slave interface brought out on IDE pads
+ * Mode 1: 001 - ata0 master <-> sata0
+ *               ata1 master <-> sata1
+ *               ata1 slave interface brought out on IDE pads
+ * Mode 2: 010 - ata1 master <-> sata1
+ *               ata1 slave  <-> sata0
+ *               ata0 master and slave interfaces brought out
+ *                    on IDE pads
+ * Mode 3: 011 - ata0 master <-> sata0
+ *               ata1 slave  <-> sata1
+ *               ata1 master and slave interfaces brought out
+ *                    on IDE pads
+ */
+#define IDE_IOMUX_MASK			(7 << 24)
+#define IDE_IOMUX_MODE0			(0 << 24)
+#define IDE_IOMUX_MODE1			(1 << 24)
+#define IDE_IOMUX_MODE2			(2 << 24)
+#define IDE_IOMUX_MODE3			(3 << 24)
+#define IDE_IOMUX_SHIFT			(24)
+#define IDE_PADS_ENABLE			BIT(4)
+#define PFLASH_PADS_DISABLE		BIT(1)
+
+/*
+ * Registers directly controlling the PATA<->SATA adapters
+ */
+#define SATA_ID				0x00
+#define SATA_PHY_ID			0x04
+#define SATA0_STATUS			0x08
+#define SATA1_STATUS			0x0c
+#define SATA0_CTRL			0x18
+#define SATA1_CTRL			0x1c
+
+#define SATA_STATUS_BIST_DONE		BIT(5)
+#define SATA_STATUS_BIST_OK		BIT(4)
+#define SATA_STATUS_PHY_READY		BIT(0)
+
+#define SATA_CTRL_PHY_BIST_EN		BIT(14)
+#define SATA_CTRL_PHY_FORCE_IDLE	BIT(13)
+#define SATA_CTRL_PHY_FORCE_READY	BIT(12)
+#define SATA_CTRL_PHY_AFE_LOOP_EN	BIT(10)
+#define SATA_CTRL_PHY_DIG_LOOP_EN	BIT(9)
+#define SATA_CTRL_HOTPLUG_DETECT_EN	BIT(4)
+#define SATA_CTRL_ATAPI_EN		BIT(3)
+#define SATA_CTRL_BUS_WITH_20		BIT(2)
+#define SATA_CTRL_SLAVE_EN		BIT(1)
+#define SATA_CTRL_EN			BIT(0)
+
+/*
+ * There is only ever one instance of this bridge on a system,
+ * so create a singleton so that the FTIDE010 instances can grab
+ * a reference to it.
+ */
+static struct sata_gemini *sg_singleton;
+
+struct sata_gemini *gemini_sata_bridge_get(void)
+{
+	if (sg_singleton)
+		return sg_singleton;
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL(gemini_sata_bridge_get);
+
+bool gemini_sata_bridge_enabled(struct sata_gemini *sg, bool is_ata1)
+{
+	if (!sg->sata_bridge)
+		return false;
+	/*
+	 * In muxmode 2 and 3 one of the ATA controllers is
+	 * actually not connected to any SATA bridge.
+	 */
+	if ((sg->muxmode == GEMINI_MUXMODE_2) &&
+	    !is_ata1)
+		return false;
+	if ((sg->muxmode == GEMINI_MUXMODE_3) &&
+	    is_ata1)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(gemini_sata_bridge_enabled);
+
+enum gemini_muxmode gemini_sata_get_muxmode(struct sata_gemini *sg)
+{
+	return sg->muxmode;
+}
+EXPORT_SYMBOL(gemini_sata_get_muxmode);
+
+static int gemini_sata_setup_bridge(struct sata_gemini *sg,
+				    unsigned int bridge)
+{
+	unsigned long timeout = jiffies + (HZ * 1);
+	bool bridge_online;
+	u32 val;
+
+	if (bridge == 0) {
+		val = SATA_CTRL_HOTPLUG_DETECT_EN | SATA_CTRL_EN;
+		/* SATA0 slave mode is only used in muxmode 2 */
+		if (sg->muxmode == GEMINI_MUXMODE_2)
+			val |= SATA_CTRL_SLAVE_EN;
+		writel(val, sg->base + SATA0_CTRL);
+	} else {
+		val = SATA_CTRL_HOTPLUG_DETECT_EN | SATA_CTRL_EN;
+		/* SATA1 slave mode is only used in muxmode 3 */
+		if (sg->muxmode == GEMINI_MUXMODE_3)
+			val |= SATA_CTRL_SLAVE_EN;
+		writel(val, sg->base + SATA1_CTRL);
+	}
+
+	/* Vendor code waits 10 ms here */
+	msleep(10);
+
+	/* Wait for PHY to become ready */
+	do {
+		msleep(100);
+
+		if (bridge == 0)
+			val = readl(sg->base + SATA0_STATUS);
+		else
+			val = readl(sg->base + SATA1_STATUS);
+		if (val & SATA_STATUS_PHY_READY)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	bridge_online = !!(val & SATA_STATUS_PHY_READY);
+
+	dev_info(sg->dev, "SATA%d PHY %s\n", bridge,
+		 bridge_online ? "ready" : "not ready");
+
+	return bridge_online ? 0: -ENODEV;
+}
+
+int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge)
+{
+	struct clk *pclk;
+	int ret;
+
+	if (bridge == 0)
+		pclk = sg->sata0_pclk;
+	else
+		pclk = sg->sata1_pclk;
+	clk_enable(pclk);
+	msleep(10);
+
+	/* Do not keep clocking a bridge that is not online */
+	ret = gemini_sata_setup_bridge(sg, bridge);
+	if (ret)
+		clk_disable(pclk);
+
+	return ret;
+}
+EXPORT_SYMBOL(gemini_sata_start_bridge);
+
+void gemini_sata_stop_bridge(struct sata_gemini *sg, unsigned int bridge)
+{
+	if (bridge == 0)
+		clk_disable(sg->sata0_pclk);
+	else if (bridge == 1)
+		clk_disable(sg->sata1_pclk);
+}
+EXPORT_SYMBOL(gemini_sata_stop_bridge);
+
+int gemini_sata_reset_bridge(struct sata_gemini *sg,
+			     unsigned int bridge)
+{
+	if (bridge == 0)
+		reset_control_reset(sg->sata0_reset);
+	else
+		reset_control_reset(sg->sata1_reset);
+	msleep(10);
+	return gemini_sata_setup_bridge(sg, bridge);
+}
+EXPORT_SYMBOL(gemini_sata_reset_bridge);
+
+static int gemini_sata_bridge_init(struct sata_gemini *sg)
+{
+	struct device *dev = sg->dev;
+	u32 sata_id, sata_phy_id;
+	int ret;
+
+	sg->sata0_pclk = devm_clk_get(dev, "SATA0_PCLK");
+	if (IS_ERR(sg->sata0_pclk)) {
+		dev_err(dev, "no SATA0 PCLK");
+		return -ENODEV;
+	}
+	sg->sata1_pclk = devm_clk_get(dev, "SATA1_PCLK");
+	if (IS_ERR(sg->sata1_pclk)) {
+		dev_err(dev, "no SATA1 PCLK");
+		return -ENODEV;
+	}
+
+	ret = clk_prepare_enable(sg->sata0_pclk);
+	if (ret) {
+		pr_err("failed to enable SATA0 PCLK\n");
+		return ret;
+	}
+	ret = clk_prepare_enable(sg->sata1_pclk);
+	if (ret) {
+		pr_err("failed to enable SATA1 PCLK\n");
+		return ret;
+	}
+
+	sg->sata0_reset = devm_reset_control_get(dev, "sata0");
+	if (IS_ERR(sg->sata0_reset)) {
+		dev_err(dev, "no SATA0 reset controller\n");
+		return PTR_ERR(sg->sata0_reset);
+	}
+	sg->sata1_reset = devm_reset_control_get(dev, "sata1");
+	if (IS_ERR(sg->sata1_reset)) {
+		dev_err(dev, "no SATA1 reset controller\n");
+		return PTR_ERR(sg->sata1_reset);
+	}
+
+	sata_id = readl(sg->base + SATA_ID);
+	sata_phy_id = readl(sg->base + SATA_PHY_ID);
+	sg->sata_bridge = true;
+	clk_disable(sg->sata0_pclk);
+	clk_disable(sg->sata1_pclk);
+
+	dev_info(dev, "SATA ID %08x, PHY ID: %08x\n", sata_id, sata_phy_id);
+
+	return 0;
+}
+
+static int gemini_sata_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct sata_gemini *sg;
+	static struct regmap *map;
+	struct resource *res;
+	enum gemini_muxmode muxmode;
+	u32 gmode;
+	u32 gmask;
+	u32 val;
+	int ret;
+
+	sg = devm_kzalloc(dev, sizeof(*sg), GFP_KERNEL);
+	if (!sg)
+		return -ENOMEM;
+	sg->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	sg->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sg->base))
+		return PTR_ERR(sg->base);
+
+	map = syscon_regmap_lookup_by_phandle(np, "syscon");
+	if (IS_ERR(map)) {
+		dev_err(dev, "no global syscon\n");
+		return PTR_ERR(map);
+	}
+
+	/* Set up the SATA bridge if need be */
+	if (of_property_read_bool(np, "cortina,gemini-enable-sata-bridge")) {
+		ret = gemini_sata_bridge_init(sg);
+		if (ret)
+			return ret;
+	}
+
+	if (of_property_read_bool(np, "cortina,gemini-enable-ide-pins"))
+		sg->ide_pins = true;
+
+	if (!sg->sata_bridge && !sg->ide_pins) {
+		dev_err(dev, "neither SATA bridge or IDE output enabled\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(np, "cortina,gemini-ata-muxmode", &muxmode);
+	if (ret) {
+		dev_err(dev, "could not parse ATA muxmode\n");
+		return ret;
+	}
+	if (muxmode > GEMINI_MUXMODE_3) {
+		dev_err(dev, "illegal muxmode %d\n", muxmode);
+		return -EINVAL;
+	}
+	sg->muxmode = muxmode;
+	gmask = IDE_IOMUX_MASK;
+	gmode = (muxmode << IDE_IOMUX_SHIFT);
+
+	/*
+	 * If we mux out the IDE, parallel flash must be disabled.
+	 * SATA0 and SATA1 have dedicated pins and may coexist with
+	 * parallel flash.
+	 */
+	if (sg->ide_pins)
+		gmode |= IDE_PADS_ENABLE | PFLASH_PADS_DISABLE;
+	else
+		gmask |= IDE_PADS_ENABLE;
+
+	ret = regmap_update_bits(map, GLOBAL_MISC_CTRL, gmask, gmode);
+	if (ret) {
+		dev_err(dev, "unable to set up IDE muxing\n");
+		return -ENODEV;
+	}
+
+	/* FIXME: add more elaborate IDE skew control handling */
+	if (sg->ide_pins) {
+		ret = regmap_read(map, GLOBAL_IDE_SKEW_CTRL, &val);
+		if (ret) {
+			dev_err(dev, "cannot read IDE skew control register\n");
+			return ret;
+		}
+		dev_info(dev, "IDE skew control: %08x\n", val);
+	}
+
+	dev_info(dev, "set up the Gemini IDE/SATA nexus\n");
+	platform_set_drvdata(pdev, sg);
+	sg_singleton = sg;
+
+	return 0;
+}
+
+static int gemini_sata_remove(struct platform_device *pdev)
+{
+	struct sata_gemini *sg = platform_get_drvdata(pdev);
+
+	clk_unprepare(sg->sata0_pclk);
+	clk_unprepare(sg->sata1_pclk);
+	sg_singleton = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id gemini_sata_of_match[] = {
+	{
+		.compatible = "cortina,gemini-sata-bridge",
+	},
+	{},
+};
+
+static struct platform_driver gemini_sata_driver = {
+	.driver = {
+		.name = "gemini-sata-bridge",
+		.of_match_table = of_match_ptr(gemini_sata_of_match),
+	},
+	.probe = gemini_sata_probe,
+	.remove = gemini_sata_remove,
+};
+module_platform_driver(gemini_sata_driver);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:gemini-sata-bridge");
diff --git a/drivers/ata/sata_gemini.h b/drivers/ata/sata_gemini.h
new file mode 100644
index 000000000000..ca1837a394c8
--- /dev/null
+++ b/drivers/ata/sata_gemini.h
@@ -0,0 +1,21 @@
+/* Header for the Gemini SATA bridge */
+#ifndef SATA_GEMINI_H
+#define SATA_GEMINI_H
+
+struct sata_gemini;
+
+enum gemini_muxmode {
+	GEMINI_MUXMODE_0 = 0,
+	GEMINI_MUXMODE_1,
+	GEMINI_MUXMODE_2,
+	GEMINI_MUXMODE_3,
+};
+
+struct sata_gemini *gemini_sata_bridge_get(void);
+bool gemini_sata_bridge_enabled(struct sata_gemini *sg, bool is_ata1);
+enum gemini_muxmode gemini_sata_get_muxmode(struct sata_gemini *sg);
+int gemini_sata_start_bridge(struct sata_gemini *sg, unsigned int bridge);
+void gemini_sata_stop_bridge(struct sata_gemini *sg, unsigned int bridge);
+int gemini_sata_reset_bridge(struct sata_gemini *sg, unsigned int bridge);
+
+#endif
-- 
2.9.4

