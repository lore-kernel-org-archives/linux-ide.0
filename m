From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH] pata_at91: Updates for pata_at91 driver
Date: Wed, 24 Jun 2009 21:51:25 +0400
Message-ID: <20090624215125.1df08e3b@realm>
References: <20090623060600.GA9603@havoc.gtf.org>
	<20090622233157.fe0e0e2c.akpm@linux-foundation.org>
	<20090623213743.2f1dfe5d@realm>
	<4A411810.6070308@garzik.org>
	<20090623234214.1b3018fd@realm>
	<4A414983.3020604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:54921 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbZFXR6s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 13:58:48 -0400
Received: by fg-out-1718.google.com with SMTP id e12so392953fga.17
        for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2009 10:58:50 -0700 (PDT)
In-Reply-To: <4A414983.3020604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Sergey Lapin <slapin@ossfans.org>, Andrew Victor <avictor.za@gmail.com>

On Tue, 23 Jun 2009 17:30:43 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Once I (or someone else, in the case of another driver) merges a
> driver, you will want to send a diff against that merged version.  In
> this case, the driver is upstream as of an hour or two ago, so you'll
> want to diff against that.
> 
> Note that little details like email subject line matter, because they 
> are copied into the kernel changelog by default, when merging
> patches. See Documentation/SubmittingPatches for a list of details.
> 
> 	Jeff


Driver pata_at91 is updated according to A. Morton comments.

* No harsh BUG_ON for get_clk in set_smc_timing function
	get_clk is now performed in driver probing function,
	probing fails if master clock is not available

* Fixed uint/ulong mess in calc_mck_cycles function

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 drivers/ata/pata_at91.c |   65 ++++++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 4b27617..c9996e5 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -44,65 +44,62 @@ struct at91_ide_info {
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
 
@@ -121,13 +118,13 @@ static void set_smc_timing(struct device *dev,
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
@@ -217,6 +214,7 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
 	struct resource *mem_res;
 	struct ata_host *host;
 	struct ata_port *ap;
+
 	int irq_flags = 0;
 	int irq = 0;
 	int ret;
@@ -261,6 +259,13 @@ static int __devinit pata_at91_probe(struct platform_device *pdev)
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
@@ -304,6 +309,7 @@ err_alt_ioremap:
 	devm_iounmap(dev, info->ide_addr);
 
 err_ide_ioremap:
+	clk_put(info->mck);
 	kfree(info);
 
 	return ret;
@@ -325,6 +331,7 @@ static int __devexit pata_at91_remove(struct platform_device *pdev)
 
 	devm_iounmap(dev, info->ide_addr);
 	devm_iounmap(dev, info->alt_addr);
+	clk_put(info->mck);
 
 	kfree(info);
 	return 0;
-- 
1.6.2.5

