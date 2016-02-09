From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH v8] SATA: OCTEON: support SATA on OCTEON platform
Date: Tue, 9 Feb 2016 12:04:29 +0000
Message-ID: <1455019469-5765-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:27698 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbcBIMFI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Feb 2016 07:05:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com
Cc: david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Zubair.Kakakhel@imgtec.com

From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>

The OCTEON SATA controller is currently found on cn71XX devices.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Vinita Gupta <vgupta@caviumnetworks.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
Changes in v8
- Rebase to v4.5-rc3
- Use __force behind the scenes via wrappers to avoid sparse warnings
- Add acked by Rob Herring

Changes in v7
- Rebase to v4.5-rc2
- Use #defines instead of __BITFIELD
- Add sign off from Zubair

Changes in v6
- Rebase to v4.5-rc1
- Tested on utm8 by rhino labs. CN7130

Changes in v5:
- Sparse warnings are fixed
- Device tree docs are improved

Changes in v4:
- The call to dma_coerce_mask_and_coherent() was removed as suggested
  by Arnd Bergmann dma_mask and coherent_dma_mask are actually set
  in the ahci_platform_init_host() (libahci_platform.c)

Changes in v3:
- Rebased to v4.0-rc2
- Cosmetic changes

Changes in v2:
- The driver was rewritten as a driver for the UCTL SATA controller glue.
  It allowed to get rid of the most changes in ahci_platform.c
- Documentation for the device tree bindings was fixed.
---
 .../devicetree/bindings/ata/ahci-platform.txt      |   1 +
 .../devicetree/bindings/mips/cavium/sata-uctl.txt  |  42 +++++++++
 arch/mips/include/asm/octeon/cvmx.h                |   9 ++
 drivers/ata/Kconfig                                |   9 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_platform.c                        |   1 +
 drivers/ata/sata_octeon.c                          | 105 +++++++++++++++++++++
 7 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
 create mode 100644 drivers/ata/sata_octeon.c

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c2340ee..3d84dca 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -11,6 +11,7 @@ Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
   - "hisilicon,hisi-ahci"
+  - "cavium,octeon-7130-ahci"
   - "ibm,476gtr-ahci"
   - "marvell,armada-380-ahci"
   - "snps,dwc-ahci"
diff --git a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
new file mode 100644
index 0000000..3bd3c2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
@@ -0,0 +1,42 @@
+* UCTL SATA controller glue
+
+UCTL is the bridge unit between the I/O interconnect (an internal bus)
+and the SATA AHCI host controller (UAHC). It performs the following functions:
+	- provides interfaces for the applications to access the UAHC AHCI
+	  registers on the CN71XX I/O space.
+	- provides a bridge for UAHC to fetch AHCI command table entries and data
+	  buffers from Level 2 Cache.
+	- posts interrupts to the CIU.
+	- contains registers that:
+		- control the behavior of the UAHC
+		- control the clock/reset generation to UAHC
+		- control endian swapping for all UAHC registers and DMA accesses
+
+Properties:
+
+- compatible: "cavium,octeon-7130-sata-uctl"
+
+  Compatibility with the cn7130 SOC.
+
+- reg: The base address of the UCTL register bank.
+
+- #address-cells, #size-cells, ranges and dma-ranges must be present and hold
+	suitable values to map all child nodes.
+
+Example:
+
+	uctl@118006c000000 {
+		compatible = "cavium,octeon-7130-sata-uctl";
+		reg = <0x11800 0x6c000000 0x0 0x100>;
+		ranges; /* Direct mapping */
+		dma-ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		sata: sata@16c0000000000 {
+			compatible = "cavium,octeon-7130-ahci";
+			reg = <0x16c00 0x00000000 0x0 0x200>;
+			interrupt-parent = <&cibsata>;
+			interrupts = <2 4>; /* Bit: 2, level */
+		};
+	};
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 774bb45..19e139c 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -275,6 +275,11 @@ static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
 		cvmx_read64(CVMX_MIO_BOOT_BIST_STAT);
 }
 
+static inline void cvmx_writeq_csr(void __iomem *csr_addr, uint64_t val)
+{
+	cvmx_write_csr((__force uint64_t)csr_addr, val);
+}
+
 static inline void cvmx_write_io(uint64_t io_addr, uint64_t val)
 {
 	cvmx_write64(io_addr, val);
@@ -287,6 +292,10 @@ static inline uint64_t cvmx_read_csr(uint64_t csr_addr)
 	return val;
 }
 
+static inline uint64_t cvmx_readq_csr(void __iomem *csr_addr)
+{
+	return cvmx_read_csr((__force uint64_t) csr_addr);
+}
 
 static inline void cvmx_send_single(uint64_t data)
 {
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 861643ea..98c5215 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -215,6 +215,15 @@ config SATA_SIL24
 
 	  If unsure, say N.
 
+config SATA_OCTEON
+	tristate "Cavium Octeon Soc Serial ATA"
+	depends on SATA_AHCI_PLATFORM && CAVIUM_OCTEON_SOC
+	default y
+	help
+	  This option enables support for Cavium Octeon SoC Serial ATA.
+
+	  If unsure, say N.
+
 config ATA_SFF
 	bool "ATA SFF support (for legacy IDE and PATA)"
 	default y
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index af45eff..dd6a036 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SATA_ACARD_AHCI)	+= acard-ahci.o libahci.o
 obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o libahci_platform.o
 obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
+obj-$(CONFIG_SATA_OCTEON)	+= sata_octeon.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 04975b8..4044233 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -76,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
 	{ .compatible = "hisilicon,hisi-ahci", },
+	{ .compatible = "cavium,octeon-7130-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
diff --git a/drivers/ata/sata_octeon.c b/drivers/ata/sata_octeon.c
new file mode 100644
index 0000000..ea865fe
--- /dev/null
+++ b/drivers/ata/sata_octeon.c
@@ -0,0 +1,105 @@
+/*
+ * SATA glue for Cavium Octeon III SOCs.
+ *
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2010-2015 Cavium Networks
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+
+#include <asm/octeon/octeon.h>
+#include <asm/bitfield.h>
+
+#define CVMX_SATA_UCTL_SHIM_CFG		0xE8
+
+#define SATA_UCTL_ENDIAN_MODE_BIG	1
+#define SATA_UCTL_ENDIAN_MODE_LITTLE	0
+#define SATA_UCTL_ENDIAN_MODE_MASK	3
+
+#define SATA_UCTL_DMA_ENDIAN_MODE_SHIFT	8
+#define SATA_UCTL_CSR_ENDIAN_MODE_SHIFT	0
+#define SATA_UCTL_DMA_READ_CMD_SHIFT	12
+
+static int ahci_octeon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct resource *res;
+	void __iomem *base;
+	u64 cfg;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
+		return -ENODEV;
+	}
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	cfg = cvmx_readq_csr(base + CVMX_SATA_UCTL_SHIM_CFG);
+
+	cfg &= ~(SATA_UCTL_ENDIAN_MODE_MASK << SATA_UCTL_DMA_ENDIAN_MODE_SHIFT);
+	cfg &= ~(SATA_UCTL_ENDIAN_MODE_MASK << SATA_UCTL_CSR_ENDIAN_MODE_SHIFT);
+
+#ifdef __BIG_ENDIAN
+	cfg |= SATA_UCTL_ENDIAN_MODE_BIG << SATA_UCTL_DMA_ENDIAN_MODE_SHIFT;
+	cfg |= SATA_UCTL_ENDIAN_MODE_BIG << SATA_UCTL_CSR_ENDIAN_MODE_SHIFT;
+#else
+	cfg |= SATA_UCTL_ENDIAN_MODE_LITTLE << SATA_UCTL_DMA_ENDIAN_MODE_SHIFT;
+	cfg |= SATA_UCTL_ENDIAN_MODE_LITTLE << SATA_UCTL_CSR_ENDIAN_MODE_SHIFT;
+#endif
+
+	cfg |= 1 << SATA_UCTL_DMA_READ_CMD_SHIFT;
+
+	cvmx_writeq_csr(base + CVMX_SATA_UCTL_SHIM_CFG, cfg);
+
+	if (!node) {
+		dev_err(dev, "no device node, failed to add octeon sata\n");
+		return -ENODEV;
+	}
+
+	ret = of_platform_populate(node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to add ahci-platform core\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ahci_octeon_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static const struct of_device_id octeon_ahci_match[] = {
+	{ .compatible = "cavium,octeon-7130-sata-uctl", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, octeon_ahci_match);
+
+static struct platform_driver ahci_octeon_driver = {
+	.probe          = ahci_octeon_probe,
+	.remove         = ahci_octeon_remove,
+	.driver         = {
+		.name   = "octeon-ahci",
+		.of_match_table = octeon_ahci_match,
+	},
+};
+
+module_platform_driver(ahci_octeon_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cavium, Inc. <support@cavium.com>");
+MODULE_DESCRIPTION("Cavium Inc. sata config.");
-- 
1.9.1

