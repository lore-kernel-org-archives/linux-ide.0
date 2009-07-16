From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2] libata: Updates and fixes for pata_at91 driver
Date: Thu, 16 Jul 2009 22:38:55 +0400
Message-ID: <1247769535-11695-1-git-send-email-geomatsi@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:8970 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932901AbZGPSqJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Jul 2009 14:46:09 -0400
Received: by fg-out-1718.google.com with SMTP id e12so1155629fga.17
        for <linux-ide@vger.kernel.org>; Thu, 16 Jul 2009 11:46:07 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: Sergey Matyukevich <geomatsi@gmail.com>

Please consider the following updates and fixes for pata_at91 driver.

* Removed extra headers
	Here we need only static memory controller properties, which are
	contained in generic header at91sam9_smc.h.
	No need to include any specific headers for at91sam9260 SoC.

* No harsh BUG_ON for get_clk in set_smc_timing function
        get_clk is now performed in driver probing function,
	        probing fails if master clock is not available

* Fixed uint/ulong mess in calc_mck_cycles function

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 drivers/ata/pata_at91.c |   67 +++++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 8561a9f..5702aff 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -26,9 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 
-#include <mach/at91sam9260_matrix.h>
 #include <mach/at91sam9_smc.h>
-#include <mach/at91sam9260.h>
 #include <mach/board.h>
 #include <mach/gpio.h>
 
@@ -44,65 +42,62 @@ struct at91_ide_info {
 	unsigned long mode;
 	unsigned int cs;
 
+	struct clk *mck;
+
 	void __iomem *ide_addr;
 	void __iomem *alt_addr;
 };
 
-const struct ata_timing initial_timing =
+static const struct ata_timing initial_timing =
 	{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
 
-static unsigned int calc_mck_cycles(unsigned int ns, unsigned int mck_hz)
+static unsigned long calc_mck_cycles(unsigned long ns, unsigned long mck_hz)
 {
 	unsigned long mul;
 
-    /*
-     * cycles = x [nsec] * f [Hz] / 10^9 [ns in sec] =
-     *     x * (f / 1_000_000_000) =
-     *     x * ((f * 65536) / 1_000_000_000) / 65536 =
-     *     x * (((f / 10_000) * 65536) / 100_000) / 65536 =
-     */
+	/*
+	* cycles = x [nsec] * f [Hz] / 10^9 [ns in sec] =
+	*     x * (f / 1_000_000_000) =
+	*     x * ((f * 65536) / 1_000_000_000) / 65536 =
+	*     x * (((f / 10_000) * 65536) / 100_000) / 65536 =
+	*/
 
-    mul = (mck_hz / 10000) << 16;
-    mul /= 100000;
+	mul = (mck_hz / 10000) << 16;
+	mul /= 100000;
 
-    return (ns * mul + 65536) >> 16;    /* rounding */
+	return (ns * mul + 65536) >> 16;    /* rounding */
 }
 
 static void set_smc_mode(struct at91_ide_info *info)
 {
-    at91_sys_write(AT91_SMC_MODE(info->cs), info->mode);
-    return;
+	at91_sys_write(AT91_SMC_MODE(info->cs), info->mode);
+	return;
 }
 
 static void set_smc_timing(struct device *dev,
 		struct at91_ide_info *info, const struct ata_timing *ata)
 {
-	int read_cycle, write_cycle, active, recover;
-	int nrd_setup, nrd_pulse, nrd_recover;
-	int nwe_setup, nwe_pulse;
+	unsigned long read_cycle, write_cycle, active, recover;
+	unsigned long nrd_setup, nrd_pulse, nrd_recover;
+	unsigned long nwe_setup, nwe_pulse;
 
-	int ncs_write_setup, ncs_write_pulse;
-	int ncs_read_setup, ncs_read_pulse;
+	unsigned long ncs_write_setup, ncs_write_pulse;
+	unsigned long ncs_read_setup, ncs_read_pulse;
 
-	unsigned int mck_hz;
-	struct clk *mck;
+	unsigned long mck_hz;
 
 	read_cycle  = ata->cyc8b;
 	nrd_setup   = ata->setup;
 	nrd_pulse   = ata->act8b;
 	nrd_recover = ata->rec8b;
 
-	mck = clk_get(NULL, "mck");
-	BUG_ON(IS_ERR(mck));
-	mck_hz = clk_get_rate(mck);
+	mck_hz = clk_get_rate(info->mck);
 
 	read_cycle  = calc_mck_cycles(read_cycle, mck_hz);
 	nrd_setup   = calc_mck_cycles(nrd_setup, mck_hz);
 	nrd_pulse   = calc_mck_cycles(nrd_pulse, mck_hz);
 	nrd_recover = calc_mck_cycles(nrd_recover, mck_hz);
 
-	clk_put(mck);
-
 	active  = nrd_setup + nrd_pulse;
 	recover = read_cycle - active;
 
@@ -121,13 +116,13 @@ static void set_smc_timing(struct device *dev,
 	ncs_write_setup = ncs_read_setup;
 	ncs_write_pulse = ncs_read_pulse;
 
-	dev_dbg(dev, "ATA timings: nrd_setup = %d nrd_pulse = %d nrd_cycle = %d\n",
+	dev_dbg(dev, "ATA timings: nrd_setup = %lu nrd_pulse = %lu nrd_cycle = %lu\n",
 			nrd_setup, nrd_pulse, read_cycle);
-	dev_dbg(dev, "ATA timings: nwe_setup = %d nwe_pulse = %d nwe_cycle = %d\n",
+	dev_dbg(dev, "ATA timings: nwe_setup = %lu nwe_pulse = %lu nwe_cycle = %lu\n",
 			nwe_setup, nwe_pulse, write_cycle);
-	dev_dbg(dev, "ATA timings: ncs_read_setup = %d ncs_read_pulse = %d\n",
+	dev_dbg(dev, "ATA timings: ncs_read_setup = %lu ncs_read_pulse = %lu\n",
 			ncs_read_setup, ncs_read_pulse);
-	dev_dbg(dev, "ATA timings: ncs_write_setup = %d ncs_write_pulse = %d\n",
+	dev_dbg(dev, "ATA timings: ncs_write_setup = %lu ncs_write_pulse = %lu\n",
 			ncs_write_setup, ncs_write_pulse);
 
 	at91_sys_write(AT91_SMC_SETUP(info->cs),
@@ -217,6 +212,7 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 	struct resource *mem_res;
 	struct ata_host *host;
 	struct ata_port *ap;
+
 	int irq_flags = 0;
 	int irq = 0;
 	int ret;
@@ -261,6 +257,13 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	info->mck = clk_get(NULL, "mck");
+
+	if (IS_ERR(info->mck)) {
+		dev_err(dev, "failed to get access to mck clock\n");
+		return -ENODEV;
+	}
+
 	info->cs    = board->chipselect;
 	info->mode  = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
 		AT91_SMC_EXNWMODE_READY | AT91_SMC_BAT_SELECT |
@@ -304,6 +307,7 @@ err_alt_ioremap:
 	devm_iounmap(dev, info->ide_addr);
 
 err_ide_ioremap:
+	clk_put(info->mck);
 	kfree(info);
 
 	return ret;
@@ -326,6 +330,7 @@ static int __devexit pata_at91_remove(struct platform_device *pdev)
 
 	devm_iounmap(dev, info->ide_addr);
 	devm_iounmap(dev, info->alt_addr);
+	clk_put(info->mck);
 
 	kfree(info);
 	return 0;
-- 
1.6.2.5

