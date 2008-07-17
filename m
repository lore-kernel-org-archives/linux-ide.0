From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] palm_bk3710: add UltraDMA/100 support
Date: Thu, 17 Jul 2008 17:04:59 +0400
Message-ID: <200807171705.00026.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:9295 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751461AbYGQNEy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jul 2008 09:04:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

This controller supports UltraDMA up to mode 5 but it should be clocked with
at least twice the data strobe frequency, so enable mode 5 for 100+ MHz IDECLK.

While at it, start passing the correct device to clk_get() -- it worked anyway
but WTF? :-/

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the recent pata-2.6 series.

 drivers/ide/arm/palm_bk3710.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ide/arm/palm_bk3710.c
===================================================================
--- linux-2.6.orig/drivers/ide/arm/palm_bk3710.c
+++ linux-2.6/drivers/ide/arm/palm_bk3710.c
@@ -82,6 +82,7 @@ static const struct palm_bk3710_udmatimi
 	{100, 120},		/* UDMA Mode 2 */
 	{100, 90},		/* UDMA Mode 3 */
 	{100, 60},		/* UDMA Mode 4 */
+	{85,  40},		/* UDMA Mode 5 */
 };
 
 static void palm_bk3710_setudmamode(void __iomem *base, unsigned int dev,
@@ -334,12 +335,11 @@ static const struct ide_port_ops palm_bk
 	.cable_detect		= palm_bk3710_cable_detect,
 };
 
-static const struct ide_port_info __devinitdata palm_bk3710_port_info = {
+static struct ide_port_info __devinitdata palm_bk3710_port_info = {
 	.init_dma		= palm_bk3710_init_dma,
 	.port_ops		= &palm_bk3710_ports_ops,
 	.host_flags		= IDE_HFLAG_MMIO,
 	.pio_mask		= ATA_PIO4,
-	.udma_mask		= ATA_UDMA4,	/* (input clk 99MHz) */
 	.mwdma_mask		= ATA_MWDMA2,
 };
 
@@ -352,7 +352,7 @@ static int __devinit palm_bk3710_probe(s
 	int i, rc;
 	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
 
-	clk = clk_get(NULL, "IDECLK");
+	clk = clk_get(&pdev->dev, "IDECLK");
 	if (IS_ERR(clk))
 		return -ENODEV;
 
@@ -392,6 +392,9 @@ static int __devinit palm_bk3710_probe(s
 	hw.irq = irq->start;
 	hw.chipset = ide_palm3710;
 
+	palm_bk3710_port_info.udma_mask = rate < 100000000 ? ATA_UDMA4 :
+							     ATA_UDMA5;
+
 	rc = ide_host_add(&palm_bk3710_port_info, hws, NULL);
 	if (rc)
 		goto out;

