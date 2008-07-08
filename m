From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] palm_bk3710: fix IDECLK period calculation
Date: Tue, 8 Jul 2008 18:29:06 +0400
Message-ID: <200807081829.06199.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:33784 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756504AbYGHO3B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2008 10:29:01 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, mcherkashin@ru.mvista.com

The driver uses completely bogus rounding formula for calculating period from
the IDECLK frequency which gives one-off period values (e.g. 11 ns with 100 MHz
IDECLK) which in turn can lead to overclocked IDE transfer timings.  Actually,
rounding is just wrong in this case, so use a mere division for a safe result.

While at it, also:

- give 'ide_palm_clk' variable a more suitable name;

- get rid of the useless 'ideclkp' variable;

- drop the LISP stype 'p' postfix from the 'clkp' variable's name. :-)

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ide/arm/palm_bk3710.c |   38 ++++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/ide/arm/palm_bk3710.c
===================================================================
--- linux-2.6.orig/drivers/ide/arm/palm_bk3710.c
+++ linux-2.6/drivers/ide/arm/palm_bk3710.c
@@ -76,7 +76,7 @@ struct palm_bk3710_udmatiming {
 
 #include "../ide-timing.h"
 
-static long ide_palm_clk;
+static unsigned ideclk_period; /* in nanoseconds */
 
 static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6] = {
 	{160, 240},		/* UDMA Mode 0 */
@@ -86,8 +86,6 @@ static const struct palm_bk3710_udmatimi
 	{85,  60},		/* UDMA Mode 4 */
 };
 
-static struct clk *ideclkp;
-
 static void palm_bk3710_setudmamode(void __iomem *base, unsigned int dev,
 				    unsigned int mode)
 {
@@ -97,10 +95,10 @@ static void palm_bk3710_setudmamode(void
 
 	/* DMA Data Setup */
 	t0 = DIV_ROUND_UP(palm_bk3710_udmatimings[mode].cycletime,
-			  ide_palm_clk) - 1;
-	tenv = DIV_ROUND_UP(20, ide_palm_clk) - 1;
+			  ideclk_period) - 1;
+	tenv = DIV_ROUND_UP(20, ideclk_period) - 1;
 	trp = DIV_ROUND_UP(palm_bk3710_udmatimings[mode].rptime,
-			   ide_palm_clk) - 1;
+			   ideclk_period) - 1;
 
 	/* udmatim Register */
 	val16 = readw(base + BK3710_UDMATIM) & (dev ? 0xFF0F : 0xFFF0);
@@ -141,8 +139,8 @@ static void palm_bk3710_setdmamode(void 
 	cycletime = max_t(int, t->cycle, min_cycle);
 
 	/* DMA Data Setup */
-	t0 = DIV_ROUND_UP(cycletime, ide_palm_clk);
-	td = DIV_ROUND_UP(t->active, ide_palm_clk);
+	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
+	td = DIV_ROUND_UP(t->active, ideclk_period);
 	tkw = t0 - td - 1;
 	td -= 1;
 
@@ -168,9 +166,9 @@ static void palm_bk3710_setpiomode(void 
 	struct ide_timing *t;
 
 	/* PIO Data Setup */
-	t0 = DIV_ROUND_UP(cycletime, ide_palm_clk);
+	t0 = DIV_ROUND_UP(cycletime, ideclk_period);
 	t2 = DIV_ROUND_UP(ide_timing_find_mode(XFER_PIO_0 + mode)->active,
-			  ide_palm_clk);
+			  ideclk_period);
 
 	t2i = t0 - t2 - 1;
 	t2 -= 1;
@@ -192,8 +190,8 @@ static void palm_bk3710_setpiomode(void 
 
 	/* TASKFILE Setup */
 	t = ide_timing_find_mode(XFER_PIO_0 + mode);
-	t0 = DIV_ROUND_UP(t->cyc8b, ide_palm_clk);
-	t2 = DIV_ROUND_UP(t->act8b, ide_palm_clk);
+	t0 = DIV_ROUND_UP(t->cyc8b, ideclk_period);
+	t2 = DIV_ROUND_UP(t->act8b, ideclk_period);
 
 	t2i = t0 - t2 - 1;
 	t2 -= 1;
@@ -350,22 +348,22 @@ static const struct ide_port_info __devi
 
 static int __devinit palm_bk3710_probe(struct platform_device *pdev)
 {
-	struct clk *clkp;
+	struct clk *clk;
 	struct resource *mem, *irq;
 	ide_hwif_t *hwif;
-	unsigned long base;
+	unsigned long base, rate;
 	int i;
 	hw_regs_t hw;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
-	clkp = clk_get(NULL, "IDECLK");
-	if (IS_ERR(clkp))
+	clk = clk_get(NULL, "IDECLK");
+	if (IS_ERR(clk))
 		return -ENODEV;
 
-	ideclkp = clkp;
-	clk_enable(ideclkp);
-	ide_palm_clk = clk_get_rate(ideclkp)/100000;
-	ide_palm_clk = (10000/ide_palm_clk) + 1;
+	clk_enable(clk);
+	rate = clk_get_rate(clk);
+	ideclk_period = 1000000000UL / rate;
+
 	/* Register the IDE interface with Linux ATA Interface */
 	memset(&hw, 0, sizeof(hw));
 

