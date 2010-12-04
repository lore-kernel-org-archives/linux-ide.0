From: mkl0301@gmail.com
Subject: [PATCH 1/1] ARM: cns3xxx: ahci: Fixup for softwreset failures with
	direct connected disks with CONFIG_SATA_PMP enabled.
Date: Sun,  5 Dec 2010 00:43:41 +0800
Message-ID: <1291481021-23317-1-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: htejun@gmail.com, cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>
List-Id: linux-ide@vger.kernel.org

From: Mac Lin <mkl0301@gmail.com>

With linux-2.6.37-rc3, arm/cns3xxx, ahci-platform driver.

If CONFIG_SATA_PMP is enabled, while not using multiplier and connect the disks
directly to the board, the disk cannot be found due to software reset always
failed.

[   12.790000] ahci ahci.0: forcing PORTS_IMPL to 0x3
[   12.800000] ahci ahci.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl platform mode
[   12.810000] ahci ahci.0: flags: ncq sntf pm led clo only pmp pio slum part ccc
[   12.850000] scsi0 : ahci_platform
[   12.860000] scsi1 : ahci_platform
[   12.870000] ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 65
[   12.880000] ata2: SATA max UDMA/133 mmio [mem 0x83000000-0x83ffffff] port 0x180 irq 65
[   13.240000] ata2: SATA link down (SStatus 0 SControl 300)
[   18.900000] ata1: link is slow to respond, please be patient (ready=0)
[   22.930000] ata1: softreset failed (device not ready)
[   28.940000] ata1: link is slow to respond, please be patient (ready=0)
[   32.970000] ata1: softreset failed (device not ready)
[   38.980000] ata1: link is slow to respond, please be patient (ready=0)
[   68.030000] ata1: softreset failed (device not ready)
[   68.040000] ata1: limiting SATA link speed to 1.5 Gbps
[   70.280000] ata1: SATA link down (SStatus 1 SControl 310)

While using multiplier with CONFIG_SATA_PMP enabled, or using disks directly
without CONFIG_SATA_PMP have no issue.

The situation is that device is sending D2H Reg FIS, but controller is not
reflecting it on any known means. It seems the controller has problem receiving
D2H Reg FIS of the different PMP setting of the previous sent H2D Reg FIS.

This patch override the softreset function ahci_softreset by
cns3xxx_ahci_softreset, which would retry ahci_do_softreset again with pmp=0 if
pmp=15 failed.

Signed-off-by: Mac Lin <mkl0301@gmail.com>
---
 arch/arm/mach-cns3xxx/cns3420vb.c |    2 +-
 arch/arm/mach-cns3xxx/devices.c   |   86 +++++++++++++++++++++++++++----------
 arch/arm/mach-cns3xxx/devices.h   |    2 +-
 3 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 08e5c87..e7dec79 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -166,13 +166,13 @@ static struct platform_device *cns3420_pdevs[] __initdata = {
 	&cns3420_nor_pdev,
 	&cns3xxx_usb_ehci_device,
 	&cns3xxx_usb_ohci_device,
+	&cns3xxx_ahci_pdev,
 };
 
 static void __init cns3420_init(void)
 {
 	platform_add_devices(cns3420_pdevs, ARRAY_SIZE(cns3420_pdevs));
 
-	cns3xxx_ahci_init();
 	cns3xxx_sdhci_init();
 
 	pm_power_off = cns3xxx_power_off;
diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
index 79d1fb0..4dcbc4d 100644
--- a/arch/arm/mach-cns3xxx/devices.c
+++ b/arch/arm/mach-cns3xxx/devices.c
@@ -19,12 +19,54 @@
 #include <mach/cns3xxx.h>
 #include <mach/irqs.h>
 #include <mach/pm.h>
+#include <linux/libata.h>
+#include <linux/ahci_platform.h>
 #include "core.h"
 #include "devices.h"
+#include "../../../drivers/ata/ahci.h"
 
 /*
  * AHCI
  */
+static int cns3xxx_ahci_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline)
+{
+	int pmp = sata_srst_pmp(link);
+	int ret;
+	DPRINTK("ENTER\n");
+
+	ret = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
+	if (pmp && ret)
+		return ahci_do_softreset(link, class, 0, deadline,
+			ahci_check_ready);
+	else
+		return ret;
+}
+
+static int cns3xxx_ahci_init(struct device *dev, void __iomem *addr)
+{
+	u32 tmp;
+
+	DPRINTK("ENTER\n");
+
+	tmp = __raw_readl(MISC_SATA_POWER_MODE);
+	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
+	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
+	__raw_writel(tmp, MISC_SATA_POWER_MODE);
+
+	/* Enable SATA PHY */
+	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
+	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
+
+	/* Enable SATA Clock */
+	cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
+
+	/* De-Asscer SATA Reset */
+	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
+
+	return 0;
+}
+
 static struct resource cns3xxx_ahci_resource[] = {
 	[0] = {
 		.start	= CNS3XXX_SATA2_BASE,
@@ -40,7 +82,26 @@ static struct resource cns3xxx_ahci_resource[] = {
 
 static u64 cns3xxx_ahci_dmamask = DMA_BIT_MASK(32);
 
-static struct platform_device cns3xxx_ahci_pdev = {
+static struct ata_port_operations cns3xxx_ahci_ops = {
+	.inherits		= &ahci_ops,
+	.softreset		= cns3xxx_ahci_softreset,
+};
+
+static const struct ata_port_info cns3xxx_ata_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &cns3xxx_ahci_ops,
+};
+
+static struct ahci_platform_data cns3xxx_ahci_platform_data = {
+	.init		= cns3xxx_ahci_init,
+	.ata_port_info	= &cns3xxx_ata_port_info,
+	.force_port_map = 0,
+	.mask_port_map = 0,
+};
+
+struct platform_device cns3xxx_ahci_pdev  = {
 	.name		= "ahci",
 	.id		= 0,
 	.resource	= cns3xxx_ahci_resource,
@@ -48,31 +109,10 @@ static struct platform_device cns3xxx_ahci_pdev = {
 	.dev		= {
 		.dma_mask		= &cns3xxx_ahci_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &cns3xxx_ahci_platform_data,
 	},
 };
 
-void __init cns3xxx_ahci_init(void)
-{
-	u32 tmp;
-
-	tmp = __raw_readl(MISC_SATA_POWER_MODE);
-	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
-	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
-	__raw_writel(tmp, MISC_SATA_POWER_MODE);
-
-	/* Enable SATA PHY */
-	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
-	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
-
-	/* Enable SATA Clock */
-	cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
-
-	/* De-Asscer SATA Reset */
-	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
-
-	platform_device_register(&cns3xxx_ahci_pdev);
-}
-
 /*
  * SDHCI
  */
diff --git a/arch/arm/mach-cns3xxx/devices.h b/arch/arm/mach-cns3xxx/devices.h
index 27e15a1..509ea6f 100644
--- a/arch/arm/mach-cns3xxx/devices.h
+++ b/arch/arm/mach-cns3xxx/devices.h
@@ -14,7 +14,7 @@
 #ifndef __CNS3XXX_DEVICES_H_
 #define __CNS3XXX_DEVICES_H_
 
-void __init cns3xxx_ahci_init(void);
+extern struct platform_device cns3xxx_ahci_pdev;
 void __init cns3xxx_sdhci_init(void);
 
 #endif /* __CNS3XXX_DEVICES_H_ */
-- 
1.7.3
