From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.29-rc2] palm_bk3710 buildfix
Date: Sun, 18 Jan 2009 08:33:53 -0800
Message-ID: <200901180833.53969.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:27543 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934517AbZARQny (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Jan 2009 11:43:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

From: David Brownell <dbrownell@users.sourceforge.net>
Subject: drivers/ide/palm_bk3710.c buildfix

  CC      drivers/ide/palm_bk3710.o
drivers/ide/palm_bk3710.c: In function 'palm_bk3710_probe':
drivers/ide/palm_bk3710.c:382: warning: assignment makes integer from pointer without a cast

Someone should fix hw_regs_t to neither be a typedef, nor
use "unsigned long" where it should use "void __iomem *".

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/ide/palm_bk3710.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/ide/palm_bk3710.c
+++ b/drivers/ide/palm_bk3710.c
@@ -346,7 +346,8 @@ static int __init palm_bk3710_probe(stru
 {
 	struct clk *clk;
 	struct resource *mem, *irq;
-	unsigned long base, rate;
+	void __iomem *base;
+	unsigned long rate;
 	int i, rc;
 	hw_regs_t hw, *hws[] = { &hw, NULL, NULL, NULL };
 
@@ -382,11 +383,13 @@ static int __init palm_bk3710_probe(stru
 	base = IO_ADDRESS(mem->start);
 
 	/* Configure the Palm Chip controller */
-	palm_bk3710_chipinit((void __iomem *)base);
+	palm_bk3710_chipinit(base);
 
 	for (i = 0; i < IDE_NR_PORTS - 2; i++)
-		hw.io_ports_array[i] = base + IDE_PALM_ATA_PRI_REG_OFFSET + i;
-	hw.io_ports.ctl_addr = base + IDE_PALM_ATA_PRI_CTL_OFFSET;
+		hw.io_ports_array[i] = (unsigned long)
+				(base + IDE_PALM_ATA_PRI_REG_OFFSET + i);
+	hw.io_ports.ctl_addr = (unsigned long)
+			(base + IDE_PALM_ATA_PRI_CTL_OFFSET);
 	hw.irq = irq->start;
 	hw.dev = &pdev->dev;
 	hw.chipset = ide_palm3710;
