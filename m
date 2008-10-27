From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH 2/2] tx4938ide: Do not call devm_ioremap for whole 128KB
Date: Mon, 27 Oct 2008 22:39:39 +0900 (JST)
Message-ID: <20081027.223939.59650930.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:56513 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbYJ0Njk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 09:39:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org, sshtylyov@ru.mvista.com

Call devm_ioremap() for CS0 and CS1 separetely.
And some style cleanups.

Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/tx4938ide.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/ide/tx4938ide.c b/drivers/ide/tx4938ide.c
index 7e4820e..28402cc 100644
--- a/drivers/ide/tx4938ide.c
+++ b/drivers/ide/tx4938ide.c
@@ -235,7 +235,7 @@ static int __init tx4938ide_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct tx4938ide_platform_info *pdata = pdev->dev.platform_data;
 	int irq, ret, i;
-	unsigned long mapbase;
+	unsigned long mapbase, mapctl;
 	struct ide_port_info d = tx4938ide_port_info;
 
 	irq = platform_get_irq(pdev, 0);
@@ -249,38 +249,43 @@ static int __init tx4938ide_probe(struct platform_device *pdev)
 				     res->end - res->start + 1, "tx4938ide"))
 		return -EBUSY;
 	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
-					      res->end - res->start + 1);
-	if (!mapbase)
+					      8 << pdata->ioport_shift);
+	mapctl = (unsigned long)devm_ioremap(&pdev->dev,
+					     res->start + 0x10000 +
+					     (6 << pdata->ioport_shift),
+					     1 << pdata->ioport_shift);
+	if (!mapbase || !mapctl)
 		return -EBUSY;
 
 	memset(&hw, 0, sizeof(hw));
 	if (pdata->ioport_shift) {
 		unsigned long port = mapbase;
+		unsigned long ctl = mapctl;
 
 		hw.io_ports_array[0] = port;
 #ifdef __BIG_ENDIAN
 		port++;
+		ctl++;
 #endif
 		for (i = 1; i <= 7; i++)
 			hw.io_ports_array[i] =
 				port + (i << pdata->ioport_shift);
-		hw.io_ports.ctl_addr =
-			port + 0x10000 + (6 << pdata->ioport_shift);
+		hw.io_ports.ctl_addr = ctl;
 	} else
-		ide_std_init_ports(&hw, mapbase, mapbase + 0x10006);
+		ide_std_init_ports(&hw, mapbase, mapctl);
 	hw.irq = irq;
 	hw.dev = &pdev->dev;
 
-	pr_info("TX4938 IDE interface (base %#lx, irq %d)\n", mapbase, hw.irq);
+	pr_info("TX4938 IDE interface (base %#lx, ctl %#lx, irq %d)\n",
+		mapbase, mapctl, hw.irq);
 	if (pdata->gbus_clock)
 		tx4938ide_tune_ebusc(pdata->ebus_ch, pdata->gbus_clock, 0);
 	else
 		d.port_ops = NULL;
 	ret = ide_host_add(&d, hws, &host);
-	if (ret)
-		return ret;
-	platform_set_drvdata(pdev, host);
-	return 0;
+	if (!ret)
+		platform_set_drvdata(pdev, host);
+	return ret;
 }
 
 static int __exit tx4938ide_remove(struct platform_device *pdev)
-- 
1.5.6.3

