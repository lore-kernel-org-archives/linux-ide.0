From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 07/10] pcmcia: at91_cf: Use syscon to configure the MC/smc
Date: Mon, 16 Mar 2015 23:44:43 +0100
Message-ID: <1426545886-19162-8-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

Use syscon/regmap to configure the smc part of the memory controller. This
allows to avoid using mach/at91rm9200_mc.h and mach/at91_ramc.h and to compile
the driver in a multiplatform configuration.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pcmcia/Kconfig   |  1 -
 drivers/pcmcia/at91_cf.c | 25 ++++++++++++++-----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 075d5cd4c5ab..56ff3dc1235e 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -280,7 +280,6 @@ config AT91_CF
 	tristate "AT91 CompactFlash Controller"
 	depends on PCI
 	depends on PCMCIA && ARCH_AT91
-	depends on !ARCH_MULTIPLATFORM
 	help
 	  Say Y here to support the CompactFlash controller on AT91 chips.
 	  Or choose M to compile the driver as a module named "at91_cf".
diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index e7775a41ae5d..87147bcd1655 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -20,16 +20,15 @@
 #include <linux/platform_data/atmel.h>
 #include <linux/io.h>
 #include <linux/sizes.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/atmel-mc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/regmap.h>
 
 #include <pcmcia/ss.h>
 
-#include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
-
-
 /*
  * A0..A10 work in each range; A23 indicates I/O space;  A25 is CFRNW;
  * some other bit in {A24,A22..A11} is nREG to flag memory access
@@ -40,6 +39,8 @@
 #define	CF_IO_PHYS	(1 << 23)
 #define	CF_MEM_PHYS	(0x017ff800)
 
+struct regmap *mc;
+
 /*--------------------------------------------------------------------------*/
 
 struct at91_cf_socket {
@@ -155,10 +156,7 @@ static int at91_cf_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
 
 	/*
 	 * Use 16 bit accesses unless/until we need 8-bit i/o space.
-	 */
-	csr = at91_ramc_read(0, AT91_SMC_CSR(cf->board->chipselect)) & ~AT91_SMC_DBW;
-
-	/*
+	 *
 	 * NOTE: this CF controller ignores IOIS16, so we can't really do
 	 * MAP_AUTOSZ.  The 16bit mode allows single byte access on either
 	 * D0-D7 (even addr) or D8-D15 (odd), so it's close enough for many
@@ -169,13 +167,14 @@ static int at91_cf_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
 	 * CF 3.0 spec table 35 also giving the D8-D15 option.
 	 */
 	if (!(io->flags & (MAP_16BIT | MAP_AUTOSZ))) {
-		csr |= AT91_SMC_DBW_8;
+		csr = AT91_MC_SMC_DBW_8;
 		dev_dbg(&cf->pdev->dev, "8bit i/o bus\n");
 	} else {
-		csr |= AT91_SMC_DBW_16;
+		csr = AT91_MC_SMC_DBW_16;
 		dev_dbg(&cf->pdev->dev, "16bit i/o bus\n");
 	}
-	at91_ramc_write(0, AT91_SMC_CSR(cf->board->chipselect), csr);
+	regmap_update_bits(mc, AT91_MC_SMC_CSR(cf->board->chipselect),
+			   AT91_MC_SMC_DBW, csr);
 
 	io->start = cf->socket.io_offset;
 	io->stop = io->start + SZ_2K - 1;
@@ -236,6 +235,10 @@ static int at91_cf_dt_init(struct platform_device *pdev)
 
 	pdev->dev.platform_data = board;
 
+	mc = syscon_regmap_lookup_by_compatible("atmel,at91rm9200-sdramc");
+	if (IS_ERR(mc))
+		return PTR_ERR(mc);
+
 	return 0;
 }
 #else
-- 
2.1.0
