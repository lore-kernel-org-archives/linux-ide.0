From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/9] pata_cs5536: move code to be re-used by ide2libata to pata_cs5536.h
Date: Sat, 30 Jan 2010 20:49:58 +0100
Message-ID: <20100130194958.30779.65426.sendpatchset@localhost>
References: <20100130194918.30779.25485.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754655Ab0A3Tve@vger.kernel.org>
In-Reply-To: <20100130194918.30779.25485.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cs5536: move code to be re-used by ide2libata to pata_cs5536.h

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5536.c |  174 ---------------------------------------------
 drivers/ata/pata_cs5536.h |  175 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+), 173 deletions(-)

Index: b/drivers/ata/pata_cs5536.c
===================================================================
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -15,19 +15,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307	 USA
- *
- * Documentation:
- *	Available from AMD web site.
- *
- * The IDE timing registers for the CS5536 live in the Geode Machine
- * Specific Register file and not PCI config space.  Most BIOSes
- * virtualize the PCI registers so the chip looks like a standard IDE
- * controller.	Unfortunately not all implementations get this right.
- * In particular some have problems with unaligned accesses to the
- * virtualized PCI registers.  This driver always does full dword
- * writes to work around the issue.  Also, in case of a bad BIOS this
- * driver can be loaded with the "msr=1" parameter which forces using
- * the Machine Specific Registers to configure the device.
  */
 
 #include <linux/kernel.h>
@@ -43,166 +30,7 @@
 #define DRV_NAME	"pata_cs5536"
 #define DRV_VERSION	"0.0.7"
 
-enum {
-	MSR_IDE_CFG		= 0x51300010,
-	PCI_IDE_CFG		= 0x40,
-
-	CFG			= 0,
-	DTC			= 2,
-	CAST			= 3,
-	ETC			= 4,
-
-	IDE_CFG_CHANEN		= (1 << 1),
-	IDE_CFG_CABLE		= (1 << 17) | (1 << 16),
-
-	IDE_D0_SHIFT		= 24,
-	IDE_D1_SHIFT		= 16,
-	IDE_DRV_MASK		= 0xff,
-
-	IDE_CAST_D0_SHIFT	= 6,
-	IDE_CAST_D1_SHIFT	= 4,
-	IDE_CAST_DRV_MASK	= 0x3,
-	IDE_CAST_CMD_MASK	= 0xff,
-	IDE_CAST_CMD_SHIFT	= 24,
-
-	IDE_ETC_UDMA_MASK	= 0xc0,
-};
-
-static int use_msr;
-
-static int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
-{
-	if (unlikely(use_msr)) {
-		u32 dummy;
-
-		rdmsr(MSR_IDE_CFG + reg, *val, dummy);
-		return 0;
-	}
-
-	return pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
-}
-
-static int cs5536_write(struct pci_dev *pdev, int reg, int val)
-{
-	if (unlikely(use_msr)) {
-		wrmsr(MSR_IDE_CFG + reg, val, 0);
-		return 0;
-	}
-
-	return pci_write_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
-}
-
-static void cs5536_program_dtc(struct ata_device *adev, u8 tim)
-{
-	struct pci_dev *pdev = to_pci_dev(adev->link->ap->host->dev);
-	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
-	u32 dtc;
-
-	cs5536_read(pdev, DTC, &dtc);
-	dtc &= ~(IDE_DRV_MASK << dshift);
-	dtc |= tim << dshift;
-	cs5536_write(pdev, DTC, dtc);
-}
-
-/**
- *	cs5536_cable_detect	-	detect cable type
- *	@ap: Port to detect on
- *
- *	Perform cable detection for ATA66 capable cable.
- *
- *	Returns a cable type.
- */
-
-static int cs5536_cable_detect(struct ata_port *ap)
-{
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 cfg;
-
-	cs5536_read(pdev, CFG, &cfg);
-
-	if (cfg & IDE_CFG_CABLE)
-		return ATA_CBL_PATA80;
-	else
-		return ATA_CBL_PATA40;
-}
-
-/**
- *	cs5536_set_piomode		-	PIO setup
- *	@ap: ATA interface
- *	@adev: device on the interface
- */
-
-static void cs5536_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	static const u8 drv_timings[5] = {
-		0x98, 0x55, 0x32, 0x21, 0x20,
-	};
-
-	static const u8 addr_timings[5] = {
-		0x2, 0x1, 0x0, 0x0, 0x0,
-	};
-
-	static const u8 cmd_timings[5] = {
-		0x99, 0x92, 0x90, 0x22, 0x20,
-	};
-
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	struct ata_device *pair = ata_dev_pair(adev);
-	int mode = adev->pio_mode - XFER_PIO_0;
-	int cmdmode = mode;
-	int cshift = adev->devno ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
-	u32 cast;
-
-	if (pair)
-		cmdmode = min(mode, pair->pio_mode - XFER_PIO_0);
-
-	cs5536_program_dtc(adev, drv_timings[mode]);
-
-	cs5536_read(pdev, CAST, &cast);
-
-	cast &= ~(IDE_CAST_DRV_MASK << cshift);
-	cast |= addr_timings[mode] << cshift;
-
-	cast &= ~(IDE_CAST_CMD_MASK << IDE_CAST_CMD_SHIFT);
-	cast |= cmd_timings[cmdmode] << IDE_CAST_CMD_SHIFT;
-
-	cs5536_write(pdev, CAST, cast);
-}
-
-/**
- *	cs5536_set_dmamode		-	DMA timing setup
- *	@ap: ATA interface
- *	@adev: Device being configured
- *
- */
-
-static void cs5536_set_dmamode(struct ata_port *ap, struct ata_device *adev)
-{
-	static const u8 udma_timings[6] = {
-		0xc2, 0xc1, 0xc0, 0xc4, 0xc5, 0xc6,
-	};
-
-	static const u8 mwdma_timings[3] = {
-		0x67, 0x21, 0x20,
-	};
-
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 etc;
-	int mode = adev->dma_mode;
-	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
-
-	cs5536_read(pdev, ETC, &etc);
-
-	if (mode >= XFER_UDMA_0) {
-		etc &= ~(IDE_DRV_MASK << dshift);
-		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
-	} else { /* MWDMA */
-		etc &= ~(IDE_ETC_UDMA_MASK << dshift);
-		cs5536_program_dtc(adev, mwdma_timings[mode - XFER_MW_DMA_0]);
-	}
-
-	cs5536_write(pdev, ETC, etc);
-}
+#include "pata_cs5536.h"
 
 static struct scsi_host_template cs5536_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
Index: b/drivers/ata/pata_cs5536.h
===================================================================
--- /dev/null
+++ b/drivers/ata/pata_cs5536.h
@@ -0,0 +1,175 @@
+/*
+ * Documentation:
+ *	Available from AMD web site.
+ *
+ * The IDE timing registers for the CS5536 live in the Geode Machine
+ * Specific Register file and not PCI config space.  Most BIOSes
+ * virtualize the PCI registers so the chip looks like a standard IDE
+ * controller.	Unfortunately not all implementations get this right.
+ * In particular some have problems with unaligned accesses to the
+ * virtualized PCI registers.  This driver always does full dword
+ * writes to work around the issue.  Also, in case of a bad BIOS this
+ * driver can be loaded with the "msr=1" parameter which forces using
+ * the Machine Specific Registers to configure the device.
+ */
+
+enum {
+	MSR_IDE_CFG		= 0x51300010,
+	PCI_IDE_CFG		= 0x40,
+
+	CFG			= 0,
+	DTC			= 2,
+	CAST			= 3,
+	ETC			= 4,
+
+	IDE_CFG_CHANEN		= (1 << 1),
+	IDE_CFG_CABLE		= (1 << 17) | (1 << 16),
+
+	IDE_D0_SHIFT		= 24,
+	IDE_D1_SHIFT		= 16,
+	IDE_DRV_MASK		= 0xff,
+
+	IDE_CAST_D0_SHIFT	= 6,
+	IDE_CAST_D1_SHIFT	= 4,
+	IDE_CAST_DRV_MASK	= 0x3,
+	IDE_CAST_CMD_MASK	= 0xff,
+	IDE_CAST_CMD_SHIFT	= 24,
+
+	IDE_ETC_UDMA_MASK	= 0xc0,
+};
+
+static int use_msr;
+
+static int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
+{
+	if (unlikely(use_msr)) {
+		u32 dummy;
+
+		rdmsr(MSR_IDE_CFG + reg, *val, dummy);
+		return 0;
+	}
+
+	return pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
+}
+
+static int cs5536_write(struct pci_dev *pdev, int reg, int val)
+{
+	if (unlikely(use_msr)) {
+		wrmsr(MSR_IDE_CFG + reg, val, 0);
+		return 0;
+	}
+
+	return pci_write_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
+}
+
+static void cs5536_program_dtc(struct ata_device *adev, u8 tim)
+{
+	struct pci_dev *pdev = to_pci_dev(adev->link->ap->host->dev);
+	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
+	u32 dtc;
+
+	cs5536_read(pdev, DTC, &dtc);
+	dtc &= ~(IDE_DRV_MASK << dshift);
+	dtc |= tim << dshift;
+	cs5536_write(pdev, DTC, dtc);
+}
+
+/**
+ *	cs5536_cable_detect	-	detect cable type
+ *	@ap: Port to detect on
+ *
+ *	Perform cable detection for ATA66 capable cable.
+ *
+ *	Returns a cable type.
+ */
+
+static int cs5536_cable_detect(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u32 cfg;
+
+	cs5536_read(pdev, CFG, &cfg);
+
+	if (cfg & IDE_CFG_CABLE)
+		return ATA_CBL_PATA80;
+	else
+		return ATA_CBL_PATA40;
+}
+
+/**
+ *	cs5536_set_piomode		-	PIO setup
+ *	@ap: ATA interface
+ *	@adev: device on the interface
+ */
+
+static void cs5536_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	static const u8 drv_timings[5] = {
+		0x98, 0x55, 0x32, 0x21, 0x20,
+	};
+
+	static const u8 addr_timings[5] = {
+		0x2, 0x1, 0x0, 0x0, 0x0,
+	};
+
+	static const u8 cmd_timings[5] = {
+		0x99, 0x92, 0x90, 0x22, 0x20,
+	};
+
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	struct ata_device *pair = ata_dev_pair(adev);
+	int mode = adev->pio_mode - XFER_PIO_0;
+	int cmdmode = mode;
+	int cshift = adev->devno ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
+	u32 cast;
+
+	if (pair)
+		cmdmode = min(mode, pair->pio_mode - XFER_PIO_0);
+
+	cs5536_program_dtc(adev, drv_timings[mode]);
+
+	cs5536_read(pdev, CAST, &cast);
+
+	cast &= ~(IDE_CAST_DRV_MASK << cshift);
+	cast |= addr_timings[mode] << cshift;
+
+	cast &= ~(IDE_CAST_CMD_MASK << IDE_CAST_CMD_SHIFT);
+	cast |= cmd_timings[cmdmode] << IDE_CAST_CMD_SHIFT;
+
+	cs5536_write(pdev, CAST, cast);
+}
+
+/**
+ *	cs5536_set_dmamode		-	DMA timing setup
+ *	@ap: ATA interface
+ *	@adev: Device being configured
+ *
+ */
+
+static void cs5536_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	static const u8 udma_timings[6] = {
+		0xc2, 0xc1, 0xc0, 0xc4, 0xc5, 0xc6,
+	};
+
+	static const u8 mwdma_timings[3] = {
+		0x67, 0x21, 0x20,
+	};
+
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u32 etc;
+	int mode = adev->dma_mode;
+	int dshift = adev->devno ? IDE_D1_SHIFT : IDE_D0_SHIFT;
+
+	cs5536_read(pdev, ETC, &etc);
+
+	if (mode >= XFER_UDMA_0) {
+		etc &= ~(IDE_DRV_MASK << dshift);
+		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
+	} else { /* MWDMA */
+		etc &= ~(IDE_ETC_UDMA_MASK << dshift);
+		cs5536_program_dtc(adev, mwdma_timings[mode - XFER_MW_DMA_0]);
+	}
+
+	cs5536_write(pdev, ETC, etc);
+}
