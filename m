From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] palm_bk3710: fix resource management (take 2)
Date: Mon, 16 Jun 2008 23:48:19 +0400
Message-ID: <200806162348.19971.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:15855 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750911AbYFPTsN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 15:48:13 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The driver expected a *virtual* address in the IDE platform device's memory
resource and didn't request the memory region for the register block. Fix this
taking into account the fact that DaVinci SoC devices are fixed-mapped to the
virtual memory early and we can get their virtual addresses using IO_ADDRESS()
macro, not having to call ioremap()...

While at it, also do some cosmetic changes...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Argh! I have finally run checkpatch.pl and it detected some whitespace damage.
So, here's take 2 of that stupid patch...

 drivers/ide/arm/palm_bk3710.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/ide/arm/palm_bk3710.c
===================================================================
--- linux-2.6.orig/drivers/ide/arm/palm_bk3710.c
+++ linux-2.6/drivers/ide/arm/palm_bk3710.c
@@ -353,8 +353,8 @@ static int __devinit palm_bk3710_probe(s
 	struct clk *clkp;
 	struct resource *mem, *irq;
 	ide_hwif_t *hwif;
-	void __iomem *base;
-	int pribase, i;
+	unsigned long base;
+	int i;
 	hw_regs_t hw;
 	u8 idx[4] = { 0xff, 0xff, 0xff, 0xff };
 
@@ -374,22 +374,27 @@ static int __devinit palm_bk3710_probe(s
 		printk(KERN_ERR "failed to get memory region resource\n");
 		return -ENODEV;
 	}
+
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq == NULL) {
 		printk(KERN_ERR "failed to get IRQ resource\n");
 		return -ENODEV;
 	}
 
-	base = (void *)mem->start;
+	if (request_mem_region(mem->start, mem->end - mem->start + 1,
+			       "palm_bk3710") == NULL) {
+		printk(KERN_ERR "failed to request memory region\n");
+		return -EBUSY;
+	}
+
+	base = IO_ADDRESS(mem->start);
 
 	/* Configure the Palm Chip controller */
-	palm_bk3710_chipinit(base);
+	palm_bk3710_chipinit((void __iomem *)base);
 
-	pribase = mem->start + IDE_PALM_ATA_PRI_REG_OFFSET;
 	for (i = 0; i < IDE_NR_PORTS - 2; i++)
-		hw.io_ports_array[i] = pribase + i;
-	hw.io_ports.ctl_addr = mem->start +
-			IDE_PALM_ATA_PRI_CTL_OFFSET;
+ 		hw.io_ports_array[i] = base + IDE_PALM_ATA_PRI_REG_OFFSET + i;
+	hw.io_ports.ctl_addr = base + IDE_PALM_ATA_PRI_CTL_OFFSET;
 	hw.irq = irq->start;
 	hw.chipset = ide_palm3710;
 
@@ -434,4 +439,3 @@ static int __init palm_bk3710_init(void)
 
 module_init(palm_bk3710_init);
 MODULE_LICENSE("GPL");
-

