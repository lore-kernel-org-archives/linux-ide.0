From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH] fix pata-rb532-cf
Date: Thu, 30 Oct 2008 22:47:31 +0100
Message-ID: <1225403251-15705-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:40995 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760196AbYJ3Vrg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Oct 2008 17:47:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Florian Fainelli <florian@openwrt.org>

After applying the following changes I could verify functionality by
mounting a filesystem on the cfdisk and reading/writing files in it.

The symbols rb532_gpio_set_ilevel and rb532_gpio_set_istat are not yet
available in a vanilla kernel, an appropriate patch has already been
sent to the linux-mips mailinglist.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 drivers/ata/pata_rb532_cf.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index f8b3ffc..a8b3c3a 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -39,9 +39,14 @@
 #define RB500_CF_MAXPORTS	1
 #define RB500_CF_IO_DELAY	400
 
-#define RB500_CF_REG_CMD	0x0800
+#define RB500_CF_REG_BASE	0x0800
 #define RB500_CF_REG_CTRL	0x080E
 #define RB500_CF_REG_DATA	0x0C00
+#define RB500_CF_REG_ERR	0x080D
+
+/* exported in arch/mips/rb532/gpio.c */
+extern void rb532_gpio_set_ilevel(int bit, unsigned gpio);
+extern void rb532_gpio_set_istat(int bit, unsigned gpio);
 
 struct rb532_cf_info {
 	void __iomem	*iobase;
@@ -62,21 +67,23 @@ static inline void rb532_pata_finish_io(struct ata_port *ap)
 	ata_sff_dma_pause(ap);
 	ndelay(RB500_CF_IO_DELAY);
 
-	set_irq_type(info->irq, IRQ_TYPE_LEVEL_HIGH);
+	rb532_gpio_set_ilevel(1, info->gpio_line);
 }
 
 static void rb532_pata_exec_command(struct ata_port *ap,
 				const struct ata_taskfile *tf)
 {
+
 	writeb(tf->command, ap->ioaddr.command_addr);
 	rb532_pata_finish_io(ap);
 }
 
-static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
+static unsigned int rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
 				unsigned int buflen, int write_data)
 {
 	struct ata_port *ap = adev->link->ap;
 	void __iomem *ioaddr = ap->ioaddr.data_addr;
+	unsigned int ret = buflen;
 
 	if (write_data) {
 		for (; buflen > 0; buflen--, buf++)
@@ -87,6 +94,8 @@ static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
 	}
 
 	rb532_pata_finish_io(adev->link->ap);
+
+	return ret;
 }
 
 static void rb532_pata_freeze(struct ata_port *ap)
@@ -109,13 +118,16 @@ static irqreturn_t rb532_pata_irq_handler(int irq, void *dev_instance)
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
+
 	return IRQ_HANDLED;
 }
 
@@ -146,12 +158,13 @@ static void rb532_pata_setup_ports(struct ata_host *ah)
 	ap->pio_mask	= 0x1f; /* PIO4 */
 	ap->flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
 
-	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_CMD;
+	ap->ioaddr.cmd_addr	= info->iobase + RB500_CF_REG_BASE;
 	ap->ioaddr.ctl_addr	= info->iobase + RB500_CF_REG_CTRL;
 	ap->ioaddr.altstatus_addr = info->iobase + RB500_CF_REG_CTRL;
 
 	ata_sff_std_ports(&ap->ioaddr);
 
+	ap->ioaddr.error_addr	= info->iobase + RB500_CF_REG_ERR;
 	ap->ioaddr.data_addr	= info->iobase + RB500_CF_REG_DATA;
 }
 
-- 
1.5.6.4

