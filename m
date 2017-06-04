From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4 v4] ata: Add driver for Faraday Technology FTIDE010
Date: Sun,  4 Jun 2017 10:50:08 +0200
Message-ID: <20170604085009.11902-3-linus.walleij@linaro.org>
References: <20170604085009.11902-1-linus.walleij@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34888 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdFDIuc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 4 Jun 2017 04:50:32 -0400
Received: by mail-lf0-f50.google.com with SMTP id c184so54520384lfe.2
        for <linux-ide@vger.kernel.org>; Sun, 04 Jun 2017 01:50:31 -0700 (PDT)
In-Reply-To: <20170604085009.11902-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- Switch timings when going from slave->master or master->slave
  access using the .qc_issue() callback and storing the currently
  active device (master or slave) in the active port private data.
- Use hardcoded timings instead of putting them in the
  state container.
- Fix the clock disable/unprepare on the errorpath in the SATA
  bridge portions.
- Use DRV_NAME throughout for name, driver name and alias.
- Prefix all defines with FTIDE010_* or GEMINI_* for clarity.
- Fix some u8 types.
- Replace an instance of iowrite8() with writeb() for consistency.
ChangeLog v2->v3:
- Remove the call to platform_set_drvdata() which was
  overwriting the host pointer. Rely instead on
  host->private_data like everyone else.
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
---
 MAINTAINERS                 |   9 +
 drivers/ata/Kconfig         |  21 ++
 drivers/ata/Makefile        |   2 +
 drivers/ata/pata_ftide010.c | 567 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/sata_gemini.c   | 438 ++++++++++++++++++++++++++++++++++
 drivers/ata/sata_gemini.h   |  21 ++
 6 files changed, 1058 insertions(+)
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
index 000000000000..7b7e417ba8ba
--- /dev/null
+++ b/drivers/ata/pata_ftide010.c
@@ -0,0 +1,567 @@
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
+#define DRV_NAME "pata_ftide010"
+
+/**
+ * struct ftide010 - state container for the Faraday FTIDE010
+ * @dev: pointer back to the device representing this controller
+ * @base: remapped I/O space address
+ * @pclk: peripheral clock for the IDE block
+ * @host: pointer to the ATA host for this device
+ * @master_cbl: master cable type
+ * @slave_cbl: slave cable type
+ * @sg: Gemini SATA bridge pointer, if running on the Gemini
+ * @master_to_sata0: Gemini SATA bridge: the ATA master is connected
+ * to the SATA0 bridge
+ * @slave_to_sata0: Gemini SATA bridge: the ATA slave is connected
+ * to the SATA0 bridge
+ * @master_to_sata1: Gemini SATA bridge: the ATA master is connected
+ * to the SATA1 bridge
+ * @slave_to_sata1: Gemini SATA bridge: the ATA slave is connected
+ * to the SATA1 bridge
+ */
+struct ftide010 {
+	struct device *dev;
+	void __iomem *base;
+	struct clk *pclk;
+	struct ata_host *host;
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
+#define FTIDE010_DMA_REG	0x00
+#define FTIDE010_DMA_STATUS	0x02
+#define FTIDE010_IDE_BMDTPR	0x04
+#define FTIDE010_IDE_DEVICE_ID	0x08
+#define FTIDE010_PIO_TIMING	0x10
+#define FTIDE010_MWDMA_TIMING	0x11
+#define FTIDE010_UDMA_TIMING0	0x12 /* Master */
+#define FTIDE010_UDMA_TIMING1	0x13 /* Slave */
+#define FTIDE010_CLK_MOD	0x14
+/* These registers are mapped directly to the IDE registers */
+#define FTIDE010_CMD_DATA	0x20
+#define FTIDE010_ERROR_FEATURES	0x21
+#define FTIDE010_NSECT		0x22
+#define FTIDE010_LBAL		0x23
+#define FTIDE010_LBAM		0x24
+#define FTIDE010_LBAH		0x25
+#define FTIDE010_DEVICE		0x26
+#define FTIDE010_STATUS_COMMAND	0x27
+#define FTIDE010_ALTSTAT_CTRL	0x36
+
+/* Set this bit for UDMA mode 5 and 6 */
+#define FTIDE010_UDMA_TIMING_MODE_56	BIT(7)
+
+/* 0 = 50 MHz, 1 = 66 MHz */
+#define FTIDE010_CLK_MOD_DEV0_CLK_SEL	BIT(0)
+#define FTIDE010_CLK_MOD_DEV1_CLK_SEL	BIT(1)
+/* Enable UDMA on a device */
+#define FTIDE010_CLK_MOD_DEV0_UDMA_EN	BIT(4)
+#define FTIDE010_CLK_MOD_DEV1_UDMA_EN	BIT(5)
+
+static struct scsi_host_template pata_ftide010_sht = {
+	ATA_BMDMA_SHT(DRV_NAME),
+};
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
+	u8 speed = adev->dma_mode;
+	u8 devno = adev->devno & 1;
+	u8 udma_en_mask;
+	u8 f66m_en_mask;
+	u8 clkreg;
+	u8 timreg;
+	u8 i;
+
+	/* Target device 0 (master) or 1 (slave) */
+	if (!devno) {
+		udma_en_mask = FTIDE010_CLK_MOD_DEV0_UDMA_EN;
+		f66m_en_mask = FTIDE010_CLK_MOD_DEV0_CLK_SEL;
+	} else {
+		udma_en_mask = FTIDE010_CLK_MOD_DEV1_UDMA_EN;
+		f66m_en_mask = FTIDE010_CLK_MOD_DEV1_CLK_SEL;
+	}
+
+	clkreg = readb(ftide->base + FTIDE010_CLK_MOD);
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
+			timreg = udma_66_setup_time[i] << 4 |
+				udma_66_hold_time[i];
+		} else {
+			timreg = udma_50_setup_time[i] << 4 |
+				udma_50_hold_time[i];
+		}
+
+		/* A special bit needs to be set for modes 5 and 6 */
+		if (i >= 5)
+			timreg |= FTIDE010_UDMA_TIMING_MODE_56;
+
+		dev_dbg(ftide->dev, "UDMA write clkreg = %02x, timreg = %02x\n",
+			clkreg, timreg);
+
+		writeb(clkreg, ftide->base + FTIDE010_CLK_MOD);
+		writeb(timreg, ftide->base + FTIDE010_UDMA_TIMING0 + devno);
+	} else {
+		i = speed & ~XFER_MW_DMA_0;
+		dev_dbg(ftide->dev, "set MWDMA mode %02x, index %d\n",
+			speed, i);
+
+		if (set_mdma_66_mhz[i]) {
+			clkreg |= f66m_en_mask;
+			timreg = mwdma_66_active_time[i] << 4 |
+				mwdma_66_recovery_time[i];
+		} else {
+			timreg = mwdma_50_active_time[i] << 4 |
+				mwdma_50_recovery_time[i];
+		}
+		dev_dbg(ftide->dev,
+			"MWDMA write clkreg = %02x, timreg = %02x\n",
+			clkreg, timreg);
+		/* This will affect all devices */
+		writeb(clkreg, ftide->base + FTIDE010_CLK_MOD);
+		writeb(timreg, ftide->base + FTIDE010_MWDMA_TIMING);
+	}
+
+	/*
+	 * Store the current device (master or slave) in ap->private_data
+	 * so that .qc_issue() can detect if this changes and reprogram
+	 * the DMA settings.
+	 */
+	ap->private_data = adev;
+
+	return;
+}
+
+static void ftide010_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct ftide010 *ftide = ap->host->private_data;
+	u8 pio = adev->pio_mode - XFER_PIO_0;
+
+	dev_dbg(ftide->dev, "set PIO mode %02x, index %d\n",
+		adev->pio_mode, pio);
+	writeb(pio_active_time[pio] << 4 | pio_recovery_time[pio],
+	       ftide->base + FTIDE010_PIO_TIMING);
+}
+
+/*
+ * We implement our own qc_issue() callback since we may need to set up
+ * the timings differently for master and slave transfers: the CLK_MOD_REG
+ * and MWDMA_TIMING_REG is shared between master and slave, so reprogramming
+ * this may be necessary.
+ */
+static unsigned int ftide010_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_device *adev = qc->dev;
+
+	/*
+	 * If the device changed, i.e. slave->master, master->slave,
+	 * then set up the DMA mode again so we are sure the timings
+	 * are correct.
+	 */
+	if (adev != ap->private_data && ata_dma_enabled(adev))
+		ftide010_set_dmamode(ap, adev);
+
+	return ata_bmdma_qc_issue(qc);
+}
+
+static struct ata_port_operations pata_ftide010_port_ops = {
+	.inherits	= &ata_bmdma_port_ops,
+	.set_dmamode	= ftide010_set_dmamode,
+	.set_piomode	= ftide010_set_piomode,
+	.qc_issue	= ftide010_qc_issue,
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
+	/*
+	 * We assume that a simple 40-wire cable is used in the PATA mode.
+	 * if you're adding a system using the PATA interface, make sure
+	 * the right cable is set up here, it might be necessary to use
+	 * special hardware detection or encode the cable type in the device
+	 * tree with special properties.
+	 */
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
+		ioaddr->bmdma_addr = ftide->base + FTIDE010_DMA_REG;
+		ioaddr->cmd_addr = ftide->base + FTIDE010_CMD_DATA;
+		ioaddr->ctl_addr = ftide->base + FTIDE010_ALTSTAT_CTRL;
+		ioaddr->altstatus_addr = ftide->base + FTIDE010_ALTSTAT_CTRL;
+		ata_sff_std_ports(ioaddr);
+	}
+
+	dev_info(dev, "device ID %08x, irq %d, io base 0x%08x\n",
+		 readl(ftide->base + FTIDE010_IDE_DEVICE_ID), irq, res->start);
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
+	struct ata_host *host = platform_get_drvdata(pdev);
+	struct ftide010 *ftide = host->private_data;
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
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(pata_ftide010_of_match),
+	},
+	.probe = pata_ftide010_probe,
+	.remove = pata_ftide010_remove,
+};
+module_platform_driver(pata_ftide010_driver);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
new file mode 100644
index 000000000000..8c704523bae7
--- /dev/null
+++ b/drivers/ata/sata_gemini.c
@@ -0,0 +1,438 @@
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
+#define DRV_NAME "gemini_sata_bridge"
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
+#define GEMINI_GLOBAL_IDE_SKEW_CTRL		0x18
+#define GEMINI_IDE1_HOST_STROBE_DELAY_SHIFT	28
+#define GEMINI_IDE1_DEVICE_STROBE_DELAY_SHIFT	24
+#define GEMINI_IDE1_OUTPUT_IO_SKEW_SHIFT	20
+#define GEMINI_IDE1_INPUT_IO_SKEW_SHIFT		16
+#define GEMINI_IDE0_HOST_STROBE_DELAY_SHIFT	12
+#define GEMINI_IDE0_DEVICE_STROBE_DELAY_SHIFT	8
+#define GEMINI_IDE0_OUTPUT_IO_SKEW_SHIFT	4
+#define GEMINI_IDE0_INPUT_IO_SKEW_SHIFT		0
+
+/* Miscellaneous Control Register */
+#define GEMINI_GLOBAL_MISC_CTRL		0x30
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
+#define GEMINI_IDE_IOMUX_MASK			(7 << 24)
+#define GEMINI_IDE_IOMUX_MODE0			(0 << 24)
+#define GEMINI_IDE_IOMUX_MODE1			(1 << 24)
+#define GEMINI_IDE_IOMUX_MODE2			(2 << 24)
+#define GEMINI_IDE_IOMUX_MODE3			(3 << 24)
+#define GEMINI_IDE_IOMUX_SHIFT			(24)
+#define GEMINI_IDE_PADS_ENABLE			BIT(4)
+#define GEMINI_PFLASH_PADS_DISABLE		BIT(1)
+
+/*
+ * Registers directly controlling the PATA<->SATA adapters
+ */
+#define GEMINI_SATA_ID				0x00
+#define GEMINI_SATA_PHY_ID			0x04
+#define GEMINI_SATA0_STATUS			0x08
+#define GEMINI_SATA1_STATUS			0x0c
+#define GEMINI_SATA0_CTRL			0x18
+#define GEMINI_SATA1_CTRL			0x1c
+
+#define GEMINI_SATA_STATUS_BIST_DONE		BIT(5)
+#define GEMINI_SATA_STATUS_BIST_OK		BIT(4)
+#define GEMINI_SATA_STATUS_PHY_READY		BIT(0)
+
+#define GEMINI_SATA_CTRL_PHY_BIST_EN		BIT(14)
+#define GEMINI_SATA_CTRL_PHY_FORCE_IDLE		BIT(13)
+#define GEMINI_SATA_CTRL_PHY_FORCE_READY	BIT(12)
+#define GEMINI_SATA_CTRL_PHY_AFE_LOOP_EN	BIT(10)
+#define GEMINI_SATA_CTRL_PHY_DIG_LOOP_EN	BIT(9)
+#define GEMINI_SATA_CTRL_HOTPLUG_DETECT_EN	BIT(4)
+#define GEMINI_SATA_CTRL_ATAPI_EN		BIT(3)
+#define GEMINI_SATA_CTRL_BUS_WITH_20		BIT(2)
+#define GEMINI_SATA_CTRL_SLAVE_EN		BIT(1)
+#define GEMINI_SATA_CTRL_EN			BIT(0)
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
+		val = GEMINI_SATA_CTRL_HOTPLUG_DETECT_EN | GEMINI_SATA_CTRL_EN;
+		/* SATA0 slave mode is only used in muxmode 2 */
+		if (sg->muxmode == GEMINI_MUXMODE_2)
+			val |= GEMINI_SATA_CTRL_SLAVE_EN;
+		writel(val, sg->base + GEMINI_SATA0_CTRL);
+	} else {
+		val = GEMINI_SATA_CTRL_HOTPLUG_DETECT_EN | GEMINI_SATA_CTRL_EN;
+		/* SATA1 slave mode is only used in muxmode 3 */
+		if (sg->muxmode == GEMINI_MUXMODE_3)
+			val |= GEMINI_SATA_CTRL_SLAVE_EN;
+		writel(val, sg->base + GEMINI_SATA1_CTRL);
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
+			val = readl(sg->base + GEMINI_SATA0_STATUS);
+		else
+			val = readl(sg->base + GEMINI_SATA1_STATUS);
+		if (val & GEMINI_SATA_STATUS_PHY_READY)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	bridge_online = !!(val & GEMINI_SATA_STATUS_PHY_READY);
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
+		clk_disable_unprepare(sg->sata0_pclk);
+		return ret;
+	}
+
+	sg->sata0_reset = devm_reset_control_get(dev, "sata0");
+	if (IS_ERR(sg->sata0_reset)) {
+		dev_err(dev, "no SATA0 reset controller\n");
+		clk_disable_unprepare(sg->sata1_pclk);
+		clk_disable_unprepare(sg->sata0_pclk);
+		return PTR_ERR(sg->sata0_reset);
+	}
+	sg->sata1_reset = devm_reset_control_get(dev, "sata1");
+	if (IS_ERR(sg->sata1_reset)) {
+		dev_err(dev, "no SATA1 reset controller\n");
+		clk_disable_unprepare(sg->sata1_pclk);
+		clk_disable_unprepare(sg->sata0_pclk);
+		return PTR_ERR(sg->sata1_reset);
+	}
+
+	sata_id = readl(sg->base + GEMINI_SATA_ID);
+	sata_phy_id = readl(sg->base + GEMINI_SATA_PHY_ID);
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
+		ret = -EINVAL;
+		goto out_unprep_clk;
+	}
+
+	ret = of_property_read_u32(np, "cortina,gemini-ata-muxmode", &muxmode);
+	if (ret) {
+		dev_err(dev, "could not parse ATA muxmode\n");
+		goto out_unprep_clk;
+	}
+	if (muxmode > GEMINI_MUXMODE_3) {
+		dev_err(dev, "illegal muxmode %d\n", muxmode);
+		ret = -EINVAL;
+		goto out_unprep_clk;
+	}
+	sg->muxmode = muxmode;
+	gmask = GEMINI_IDE_IOMUX_MASK;
+	gmode = (muxmode << GEMINI_IDE_IOMUX_SHIFT);
+
+	/*
+	 * If we mux out the IDE, parallel flash must be disabled.
+	 * SATA0 and SATA1 have dedicated pins and may coexist with
+	 * parallel flash.
+	 */
+	if (sg->ide_pins)
+		gmode |= GEMINI_IDE_PADS_ENABLE | GEMINI_PFLASH_PADS_DISABLE;
+	else
+		gmask |= GEMINI_IDE_PADS_ENABLE;
+
+	ret = regmap_update_bits(map, GEMINI_GLOBAL_MISC_CTRL, gmask, gmode);
+	if (ret) {
+		dev_err(dev, "unable to set up IDE muxing\n");
+		ret = -ENODEV;
+		goto out_unprep_clk;
+	}
+
+	/* FIXME: add more elaborate IDE skew control handling */
+	if (sg->ide_pins) {
+		ret = regmap_read(map, GEMINI_GLOBAL_IDE_SKEW_CTRL, &val);
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
+
+out_unprep_clk:
+	if (sg->sata_bridge) {
+		clk_unprepare(sg->sata1_pclk);
+		clk_unprepare(sg->sata0_pclk);
+	}
+	return ret;
+}
+
+static int gemini_sata_remove(struct platform_device *pdev)
+{
+	struct sata_gemini *sg = platform_get_drvdata(pdev);
+
+	if (sg->sata_bridge) {
+		clk_unprepare(sg->sata1_pclk);
+		clk_unprepare(sg->sata0_pclk);
+	}
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
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(gemini_sata_of_match),
+	},
+	.probe = gemini_sata_probe,
+	.remove = gemini_sata_remove,
+};
+module_platform_driver(gemini_sata_driver);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
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

