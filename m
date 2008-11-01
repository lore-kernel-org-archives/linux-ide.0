From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] fix pata-rb532-cf
Date: Sat,  1 Nov 2008 17:12:45 +0100
Message-ID: <1225555965-27557-1-git-send-email-n0-1@freewrt.org>
References: <20081101160930.GA10321@nuty>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:51477 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbYKAQMv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Nov 2008 12:12:51 -0400
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id E7CA0386DBBE
	for <linux-ide@vger.kernel.org>; Sat,  1 Nov 2008 17:12:49 +0100 (CET)
In-Reply-To: <20081101160930.GA10321@nuty>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

After applying the following changes I could verify functionality by
mounting a filesystem on the cfdisk and reading/writing files in it.

The symbols rb532_gpio_set_ilevel and rb532_gpio_set_istat are not yet
available in a vanilla kernel, an appropriate patch has already been
sent to the linux-mips mailinglist.

Also change rb532_pata_data_xfer() so it reads and writes 4-byte blocks,
like the original driver did. Rename the offset definition of the
buffered data register for clearness.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   35 +++++++++++++++++++++++------------
 1 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index f8b3ffc..bdf413e 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -31,6 +31,7 @@
 #include <scsi/scsi_host.h>
 
 #include <asm/gpio.h>
+#include <asm/mach-rc32434/gpio.h>
 
 #define DRV_NAME	"pata-rb532-cf"
 #define DRV_VERSION	"0.1.0"
@@ -39,9 +40,11 @@
 #define RB500_CF_MAXPORTS	1
 #define RB500_CF_IO_DELAY	400
 
-#define RB500_CF_REG_CMD	0x0800
+#define RB500_CF_REG_BASE	0x0800
 #define RB500_CF_REG_CTRL	0x080E
-#define RB500_CF_REG_DATA	0x0C00
+/* 32bit buffered data register offset */
+#define RB500_CF_REG_DBUF32	0x0C00
+#define RB500_CF_REG_ERR	0x080D
 
 struct rb532_cf_info {
 	void __iomem	*iobase;
@@ -62,7 +65,7 @@ static inline void rb532_pata_finish_io(struct ata_port *ap)
 	ata_sff_dma_pause(ap);
 	ndelay(RB500_CF_IO_DELAY);
 
-	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
+	rb532_gpio_set_ilevel(1, info->gpio_line);
 }
 
 static void rb532_pata_exec_command(struct ata_port *ap,
@@ -72,21 +75,26 @@ static void rb532_pata_exec_command(struct ata_port *ap,
 	rb532_pata_finish_io(ap);
 }
 
-static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
+static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
 				unsigned int buflen, int write_data)
 {
+	int i;
 	struct ata_port *ap = adev->link->ap;
 	void __iomem *ioaddr = ap->ioaddr.data_addr;
 
+	BUG_ON(buflen % sizeof(u32));
+
 	if (write_data) {
-		for (; buflen > 0; buflen--, buf++)
-			writeb(*buf, ioaddr);
+		for(i = 0; i < buflen / sizeof(u32); i++)
+			writel(((u32 *)buf)[i], ioaddr);
 	} else {
-		for (; buflen > 0; buflen--, buf++)
-			*buf = readb(ioaddr);
+		for(i = 0; i < buflen / sizeof(u32); i++)
+			((u32 *)buf)[i] = readl(ioaddr);
 	}
 
 	rb532_pata_finish_io(adev->link->ap);
+
+	return buflen;
 }
 
 static void rb532_pata_freeze(struct ata_port *ap)
@@ -109,13 +117,15 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
 	struct rb532_cf_info *info = ah->private_data;
 
 	if (gpio_get_value(info->gpio_line)) {
-		set_irq_type(info->irq, IRQ_TYPE_LEVEL_LOW);
+		rb532_gpio_set_ilevel(0, info->gpio_line);
 		if (!info->frozen)
 			ata_sff_interrupt(info->irq, dev_instance);
 	} else {
-		set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
+		rb532_gpio_set_ilevel(1, info->gpio_line);
 	}
 
+	rb532_gpio_set_istat(0, info->gpio_line);
+
 	return IRQ_HANDLED;
 }
 
@@ -146,13 +156,14 @@ static void rb532_pata_setup_ports(struct ata_host *ah)
 	ap->pio_mask	= 0x1f; /* PIO4 */
 	ap->flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
 
-	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_CMD;
+	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_BASE;
 	ap->ioaddr.ctl_addr	= info->iobase + RB500_CF_REG_CTRL;
 	ap->ioaddr.altstatus_addr = info->iobase + RB500_CF_REG_CTRL;
 
 	ata_sff_std_ports(&ap->ioaddr);
 
-	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DATA;
+	ap->ioaddr.error_addr	= info->iobase + RB500_CF_REG_ERR;
+	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DBUF32;
 }
 
 static __devinit int rb532_pata_driver_probe(struct platform_device *pdev)
-- 
1.5.6.4

