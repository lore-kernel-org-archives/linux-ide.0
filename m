From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: [PATCH 2/3] ep93xx: IDE driver platform support code
Date: Thu, 29 Mar 2012 10:19:19 +0200
Message-ID: <4F741B07.7040107@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:44162 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab2C2IT1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Mar 2012 04:19:27 -0400
In-Reply-To: <4F7418E7.4060500@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, sshtylyov@ru.montavista.com, joao.ramos@inov.pt, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---
 arch/arm/mach-ep93xx/core.c                  |   36 +++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/platform.h |    1
 arch/arm/mach-ep93xx/soc.h                   |    1
 3 files changed, 38 insertions(+)

Index: linux-2.6/arch/arm/mach-ep93xx/soc.h
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/soc.h
+++ linux-2.6/arch/arm/mach-ep93xx/soc.h
@@ -69,6 +69,7 @@
 
 #define EP93XX_BOOT_ROM_BASE		EP93XX_AHB_IOMEM(0x00090000)
 
+#define EP93XX_IDE_PHYS_BASE		EP93XX_AHB_PHYS(0x000a0000)
 #define EP93XX_IDE_BASE			EP93XX_AHB_IOMEM(0x000a0000)
 
 #define EP93XX_VIC1_BASE		EP93XX_AHB_IOMEM(0x000b0000)
Index: linux-2.6/arch/arm/mach-ep93xx/core.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/core.c
+++ linux-2.6/arch/arm/mach-ep93xx/core.c
@@ -868,6 +868,42 @@ static struct platform_device ep93xx_wdt
 	.resource	= ep93xx_wdt_resources,
 };
 
+/*************************************************************************
+ * EP93xx IDE
+ *************************************************************************/
+static struct resource ep93xx_ide_resources[] = {
+	[0] = {
+		.start	= EP93XX_IDE_PHYS_BASE,
+		.end	= EP93XX_IDE_PHYS_BASE + 0xffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_EP93XX_EXT3,
+		.end	= IRQ_EP93XX_EXT3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ep93xx_ide_device = {
+	.name		= "ep93xx-ide",
+	.id		= -1,
+	.dev		= {
+		.dma_mask		= &ep93xx_ide_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(ep93xx_ide_resources),
+	.resource	= ep93xx_ide_resources,
+};
+
+void __init ep93xx_register_ide(void)
+{
+	/* GPIO ports E, G and H used by IDE */
+	ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_EONIDE |
+				 EP93XX_SYSCON_DEVCFG_GONIDE |
+				 EP93XX_SYSCON_DEVCFG_HONIDE);
+	platform_device_register(&ep93xx_ide_device);
+}
+
 void __init ep93xx_init_devices(void)
 {
 	/* Disallow access to MaverickCrunch initially */
Index: linux-2.6/arch/arm/mach-ep93xx/include/mach/platform.h
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/include/mach/platform.h
+++ linux-2.6/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -48,6 +48,7 @@ void ep93xx_register_i2s(void);
 int ep93xx_i2s_acquire(void);
 void ep93xx_i2s_release(void);
 void ep93xx_register_ac97(void);
+void ep93xx_register_ide(void);
 
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
