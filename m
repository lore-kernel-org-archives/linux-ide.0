From: mkl0301@gmail.com
Subject: [PATCH v3 2/2] ahci_platform: add support for CNS3xxx SoC devices
Date: Fri,  7 Jan 2011 01:53:13 +0800
Message-ID: <1294336393-920-3-git-send-email-mkl0301@gmail.com>
References: <1294336393-920-1-git-send-email-mkl0301@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43226 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab1AFRxj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 12:53:39 -0500
Received: by gxk9 with SMTP id 9so3830368gxk.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 09:53:39 -0800 (PST)
In-Reply-To: <1294336393-920-1-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

From: Mac Lin <mkl0301@gmail.com>

CNS3xxx override the softreset function of ahci_platform ahci_softreset by
cns3xxx_ahci_softreset, which would retry ahci_do_softreset again with pmp=0 if
pmp=15 failed, for the controller has problem receiving D2H Reg FIS of the
different PMP setting of the previous sent H2D Reg FIS.

Following describe the isssue with original ahci_platform driver on
linux-2.6.37-rc3, arm/cns3xxx.

If CONFIG_SATA_PMP is enabled, while not using multiplier and connect the disks
directly to the board, the disk cannot be found due to software reset always
failed.

    ahci ahci.0: forcing PORTS_IMPL to 0x3
    ahci ahci.0: AHCI 0001.0100 32 slots 2 ports 3 Gbps 0x3 impl platform mode
    ahci ahci.0: flags: ncq sntf pm led clo only pmp pio slum part ccc
    scsi0 : ahci_platform
    scsi1 : ahci_platform
    ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 65
    ata2: SATA max UDMA/133 mmio [mem 0x83000000-0x83ffffff] port 0x180 irq 65
    ata2: SATA link down (SStatus 0 SControl 300)
    ata1: link is slow to respond, please be patient (ready=0)
    ata1: softreset failed (device not ready)
    ata1: link is slow to respond, please be patient (ready=0)
    ata1: softreset failed (device not ready)
    ata1: link is slow to respond, please be patient (ready=0)
    ata1: softreset failed (device not ready)
    ata1: limiting SATA link speed to 1.5 Gbps
    ata1: SATA link down (SStatus 1 SControl 310)

While using multiplier with CONFIG_SATA_PMP enabled, or using disks directly
without CONFIG_SATA_PMP have no issue. It seems the device is sending D2H Reg
FIS, but controller is not reflecting it on any known means.

Signed-off-by: Mac Lin <mkl0301@gmail.com>
---
 arch/arm/mach-cns3xxx/devices.c |    2 +-
 drivers/ata/Kconfig             |   11 +++++++++++
 drivers/ata/ahci_platform.c     |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
index 50b4d31..b496f02 100644
--- a/arch/arm/mach-cns3xxx/devices.c
+++ b/arch/arm/mach-cns3xxx/devices.c
@@ -40,7 +40,7 @@ static struct resource cns3xxx_ahci_resource[] = {
 static u64 cns3xxx_ahci_dmamask = DMA_BIT_MASK(32);
 
 static struct platform_device cns3xxx_ahci_pdev = {
-	.name		= "ahci",
+	.name		= "ahci-cns3xxx",
 	.id		= 0,
 	.resource	= cns3xxx_ahci_resource,
 	.num_resources	= ARRAY_SIZE(cns3xxx_ahci_resource),
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 36e2319..5d8b1a3 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -75,6 +75,17 @@ config SATA_AHCI_PLATFORM
 
 	  If unsure, say N.
 
+config SATA_AHCI_CNS3XXX
+	bool "AHCI Support on the Cavium Networks CNS3xxx SOC"
+	depends on ARCH_CNS3XXX
+	depends on SATA_AHCI_PLATFORM
+	help
+	  This option enables AHCI platform driver to support CNS3xxx
+	  System-on-Chip devices. This is only needed when using CNS3xxx AHCI
+	  controller.
+
+	  If unsure, say N.
+
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 25d98c8..7d6957f 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -176,8 +176,47 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_SATA_AHCI_CNS3XXX
+/*
+ * TODO: move cns3xxx_ahci_init to here after cns3xxx_pwr*() calls are
+ * thread-safe
+ */
+
+static int cns3xxx_ahci_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline)
+{
+	int pmp = sata_srst_pmp(link);
+	int ret;
+
+	ret = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
+	if (pmp && ret)
+		return ahci_do_softreset(link, class, 0, deadline,
+			ahci_check_ready);
+	return ret;
+}
+
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
+struct ahci_platform_data cns3xxx_ahci_platform_data = {
+	.ata_port_info	= &cns3xxx_ata_port_info,
+};
+#endif
+
 static const struct platform_device_id ahci_pltfm_ids[] = {
 	{ "ahci", },
+#ifdef CONFIG_SATA_AHCI_CNS3XXX
+	{ "ahci-cns3xxx", (kernel_ulong_t)&cns3xxx_ahci_platform_data},
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, ahci_pltfm_ids);
-- 
1.7.3

